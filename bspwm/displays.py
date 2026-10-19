#!/usr/bin/python3
"""Prefer HDMI on kevin; keep bspwm desktops and Polybar on the active screen."""

import argparse
import fcntl
import logging
import os
from pathlib import Path
import re
import select
import subprocess
import time

INTERNAL = "eDP-1"
EXTERNAL = "HDMI-1"
DESKTOPS = ["web", "dev", "hel", "sla", "com", "med", "ran"]
CONFIG = Path(os.environ.get("XDG_CONFIG_HOME", Path.home() / ".config"))
RUNTIME = Path(os.environ.get("XDG_RUNTIME_DIR", CONFIG / "bspwm"))
SESSION = re.sub(r"[^a-zA-Z0-9_-]", "_", os.environ.get("DISPLAY", ":0"))


def run(*args, optional=False):
    result = subprocess.run(args, text=True, capture_output=True, timeout=15)
    if not optional:
        result.check_returncode()
    return result.stdout.strip()


def outputs():
    return dict(re.findall(r"^(\S+) (connected|disconnected)\b",
                           run("xrandr", "--query"), re.MULTILINE))


def configure(force_laptop=False):
    with (RUNTIME / f"bspwm-displays-{SESSION}.lock").open("w") as lock:
        fcntl.flock(lock, fcntl.LOCK_EX)
        state = outputs()
        target = EXTERNAL if not force_laptop and state.get(EXTERNAL) == "connected" else INTERNAL
        if state.get(target) != "connected":
            raise RuntimeError(f"No usable output: {state}")
        focused = run("bspc", "query", "-D", "-d", "focused", optional=True)

        # Keep disconnected monitors until their replacement is enabled and
        # their desktops have been moved. This also avoids a zero-monitor race.
        run("bspc", "config", "remove_disabled_monitors", "false")
        run("bspc", "config", "remove_unplugged_monitors", "false")
        run("bspc", "config", "merge_overlapping_monitors", "false")
        # Never turn off the working screen before the replacement succeeds.
        run("xrandr", "--output", target, "--auto", "--primary", "--pos", "0x0")
        for _ in range(40):
            if target in run("bspc", "query", "-M", "--names").splitlines():
                break
            time.sleep(0.05)
        else:
            raise RuntimeError(f"bspwm did not detect {target}")

        old_monitors = [m for m in run("bspc", "query", "-M", "--names").splitlines() if m != target]
        for monitor in old_monitors:
            desktops = run("bspc", "query", "-D", "-m", monitor).splitlines()
            # bspwm refuses to transfer a monitor's last desktop.
            run("bspc", "monitor", monitor, "--add-desktops", "Desktop")
            for desktop in desktops:
                run("bspc", "desktop", desktop, "--to-monitor", target)

        off = [arg for name in state if name != target for arg in ("--output", name, "--off")]
        if off:
            run("xrandr", *off)
        for monitor in old_monitors:
            run("bspc", "monitor", monitor, "--remove")

        existing = run("bspc", "query", "-D", "-m", target, "--names").splitlines()
        for desktop in DESKTOPS:
            if desktop not in existing:
                run("bspc", "monitor", target, "--add-desktops", desktop)
        # bspwm creates an empty Desktop when it adds a monitor. Remove only
        # these placeholders, never a desktop containing a window.
        for desktop in run("bspc", "query", "-D", "-m", target).splitlines():
            name = run("bspc", "query", "-D", "-d", desktop, "--names")
            if name == "Desktop" and not run("bspc", "query", "-N", "-d", desktop, optional=True):
                run("bspc", "desktop", desktop, "--remove")
        existing = run("bspc", "query", "-D", "-m", target, "--names").splitlines()
        run("bspc", "monitor", target, "--reorder-desktops", *DESKTOPS,
            *(d for d in existing if d not in DESKTOPS))
        run("bspc", "monitor", target, "--focus")
        if focused:
            run("bspc", "desktop", focused, "--focus", optional=True)
        # Detach the bar so it survives this one-shot process and doesn't hold
        # the daemon's lock. The launcher chooses the current primary output.
        subprocess.Popen([str(CONFIG / "polybar" / "launch.sh")],
                         stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                         start_new_session=True)
        logging.info("Active display: %s", target)
        return state


def watch():
    from Xlib import display
    from Xlib.ext import randr

    with (RUNTIME / f"bspwm-displays-watch-{SESSION}.lock").open("w") as lock:
        try:
            fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError:
            return  # Already running, including after a bspwm restart.
        connection = display.Display()
        connection.screen().root.xrandr_select_input(
            randr.RROutputChangeNotifyMask | randr.RRScreenChangeNotifyMask)
        connection.sync()
        previous = None
        while True:
            # Retry transient hotplug failures before returning to event waiting.
            for attempt in range(3):
                try:
                    current = outputs()
                    if current != previous:
                        previous = configure()
                    break
                except (subprocess.SubprocessError, RuntimeError):
                    logging.exception("Display configuration failed")
                    time.sleep(1)
            # Drain events generated by our own xrandr calls, then block with
            # no idle polling. Only a physical connection change reapplies policy.
            if not connection.pending_events():
                select.select([connection], [], [])
            connection.next_event()
            time.sleep(0.5)
            while connection.pending_events():
                connection.next_event()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--watch", action="store_true", help="watch XRandR hotplug events")
    mode.add_argument("--laptop", action="store_true", help="restore the laptop screen manually")
    args = parser.parse_args()
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
    if args.watch:
        watch()
    else:
        configure(force_laptop=args.laptop)
