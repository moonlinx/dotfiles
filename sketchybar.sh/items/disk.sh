#!/bin/bash

source "$CONFIG_DIR/settings.sh"

if is_dark_mode; then
    ICON_COLOR=$BLUE
else
    ICON_COLOR=$BLACK
fi

disk=(
    icon=􀨪
    icon.color=$ICON_COLOR
    update_freq=300
    script="$PLUGIN_DIR/disk.sh"
)

sketchybar --add item disk left \
    --set disk "${disk[@]}"
