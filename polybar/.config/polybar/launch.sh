#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Check if HDMI-1 is connected and NOT off
if xrandr | grep "HDMI-1 connected" | grep -q "1920x1080"; then
    # Start monitor bar if HDMI is the primary output
    polybar monitor &
else
    # Start laptop bar if we are on the built-in screen
    polybar laptop &
fi
