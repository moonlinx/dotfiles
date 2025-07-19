#!/bin/bash

source "$CONFIG_DIR/settings.sh"

if is_dark_mode; then
    ICON_COLOR=$ORANGE
else
    ICON_COLOR=$BLACK
fi

ram=(
    icon=
    icon.color=$ICON_COLOR
    update_freq=5
    script="$PLUGIN_DIR/ram.sh"
)

sketchybar --add item ram left \
    --set ram "${ram[@]}"
