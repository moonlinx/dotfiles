#!/bin/bash

wifi=(
    update_freq=5
    script="$PLUGIN_DIR/wifi.sh"
)
vpn=(
    update_freq=5
    script="$PLUGIN_DIR/vpn.sh"
)

sketchybar \
    --add item vpn right \
    --set vpn "${vpn[@]}" \
    --subscribe vpn mouse.clicked \
    \
    --add item wifi right \
    --set wifi "${wifi[@]}" \
    --subscribe wifi wifi_change
