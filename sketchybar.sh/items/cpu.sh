#!/bin/bash

source "$CONFIG_DIR/settings.sh"

if is_dark_mode; then
    ICON_COLOR=$GREEN
else
    ICON_COLOR=$BLACK
fi

cpu=(
    icon=􀧓
    icon.color=$ICON_COLOR
    update_freq=5
    script="$PLUGIN_DIR/cpu.sh"
)

sketchybar --add item cpu left \
    --set cpu "${cpu[@]}"
