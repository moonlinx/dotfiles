#!/bin/bash

theme=(
    icon=􀀂
    update_freq=60
    script="$PLUGIN_DIR/theme.sh"
)

sketchybar --add item theme right \
    --set theme "${theme[@]}" \
    --subscribe theme mouse.clicked system_woke
