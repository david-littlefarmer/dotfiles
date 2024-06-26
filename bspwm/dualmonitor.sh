#!/bin/bash

# set up the two monitors for bspwm
# NOTE This is a simplistic approach because I already know the settings I
# want to apply.
my_laptop_external_monitor=$(xrandr --query | grep '^DP-2-1')
if [[ $my_laptop_external_monitor = *connected* ]]; then
	xrandr --output eDP-1 --off --output DP-2-1 --mode 3440x1440 --pos 0x0 --rotate normal
fi
