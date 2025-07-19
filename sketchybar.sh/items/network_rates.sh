#!/bin/bash

source "$CONFIG_DIR/settings.sh"

if is_dark_mode; then
    ICON_COLOR=$RED
else
    ICON_COLOR=$BLACK
fi

down=(
    icon=􁾯
    icon.color=$ICON_COLOR
    icon.padding_right=5
    script="$PLUGIN_DIR/network_rates.sh"
    update_freq=5
)
sketchybar \
    --add item net_down left \
    --set net_down "${down[@]}"
