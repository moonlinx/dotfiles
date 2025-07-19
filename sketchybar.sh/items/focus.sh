#!/bin/bash

focus=(
    icon=􀆺
    update_freq=10
    updates=on
    drawing=off
    script="$PLUGIN_DIR/focus.sh"
)

sketchybar --add item focus right \
    --set focus "${focus[@]}" \
    \
    --add event focus_enabled '_NSDoNotDisturbEnabledNotification' \
    --add event focus_disabled '_NSDoNotDisturbDisabledNotification' \
    --subscribe focus focus_enabled focus_disabled
