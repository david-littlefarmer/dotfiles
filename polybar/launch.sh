#!/usr/bin/env sh

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [ $(uname -n) = 'lf-pc' ]; then
	polybar lfccmbr-pc-HDMI-A-0 &
	polybar lfccmbr-pc-HDMI-A-1 &
fi

if [ $(uname -n) = 'lf-x250' ]; then
	external_monitor=$(xrandr --query | grep '^DP-1')
	if [[ $external_monitor = *disconnected* ]]; then
		polybar lfccmbr-x250-eDP-1 &
	else
		polybar lfccmbr-x250-DP-1 &
	fi
fi

if [ $(uname -n) = 'lf-t480s' ]; then
	external_monitor=$(xrandr --query | grep '^DP-2-1')
	if [[ -z "$external_monitor" ]] || [[ $external_monitor = *disconnected* ]]; then
		polybar lfccmbr-x250-eDP-1 &
	else
		polybar lfccmbr-t480s-DP-2-1 &
	fi
fi

if [ $(uname -n) = 'lf-x200' ]; then
	polybar lfccmbr-x200-LVDS1 &
fi
