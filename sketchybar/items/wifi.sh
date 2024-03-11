#!/bin/bash

source "$PLUGIN_DIR/wifi.sh"

wifi=(
	script="$PLUGIN_DIR/wifi.sh"
	click_script="$POPUP_CLICK_SCRIPT"
	label.padding_right=10
	update_freq=100
)

rm -f /tmp/sketchybar_speed
rm -f /tmp/sketchybar_wifi
sketchybar --add item wifi right \
	--set wifi "${wifi[@]}" \
	--subscribe wifi system_woke
