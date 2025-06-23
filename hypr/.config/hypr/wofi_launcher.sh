#!/bin/bash
if ! pgrep -x "wofi" > /dev/null; then
    wofi --show drun
else
    echo "Wofi is already running."
fi

