#!/bin/bash

case "$SENDER" in
"focus_enabled")
    sketchybar --set $NAME drawing=on
    ;;
"focus_disabled")
    sketchybar --set $NAME drawing=off
    ;;
*)
    FOCUS=$(defaults read com.apple.controlcenter "NSStatusItem Visible FocusModes")
    if [[ $FOCUS == "1" ]]; then
        sleep 6 # Wait until the dimmed Focus icon disappears.
        FOCUS=$(defaults read com.apple.controlcenter "NSStatusItem Visible FocusModes")
        if [[ $FOCUS == "1" ]]; then
            sketchybar --set $NAME drawing=on
        else
            sketchybar --set $NAME drawing=off
        fi
    else
        sketchybar --set $NAME drawing=off
    fi
    ;;
esac
