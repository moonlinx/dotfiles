#!/bin/bash

time=(
    icon.drawing=off
    width=100
    align=left
    padding_left=0
    padding_right=0
    label.padding_left=0
    update_freq=1
    script="$PLUGIN_DIR/time.sh"
)

sketchybar --add item time center \
    --set time "${time[@]}" \
    --subscribe time mouse.clicked
