#!/bin/bash

sketchybar --set $NAME label="$(date +"%a %-d %b")"

case "$SENDER" in
"mouse.clicked")
    open -a Calendar
    ;;
esac
