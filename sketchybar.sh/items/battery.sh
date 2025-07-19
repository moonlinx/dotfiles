#!/bin/bash

battery=(
    update_freq=60
    updates=on
    drawing=off
    script="$PLUGIN_DIR/battery.sh"
)

sketchybar --add item battery right \
    --set battery "${battery[@]}" \
    --subscribe battery power_source_change system_woke
