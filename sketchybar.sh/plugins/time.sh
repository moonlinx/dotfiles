#!/bin/bash

sketchybar --set $NAME label="$(date "+%H:%M")"

case "$SENDER" in
"mouse.clicked")
    open -a Clock
    ;;
esac
