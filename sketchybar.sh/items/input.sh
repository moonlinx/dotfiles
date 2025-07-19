#!/bin/bash

input=(
    icon.font.size=13.0
    update_freq=1 # The input_change event sometimes fails to trigger.
    script="$PLUGIN_DIR/input.sh"
)

sketchybar --add item input right \
    --set input "${input[@]}" \
    \
    --add event input_change 'AppleSelectedInputSourcesChangedNotification' \
    --subscribe input input_change
