#!/bin/bash

calendar=(
	icon.font="$FONT:Black:15.0"
	icon.color=$HONEY
	label.font="$FONT:Black:13.0"
	label.color=$WHITE
	icon.y_offset=1
	icon.padding_right=28
	label.width=45
	label.align=right
	padding_left=13
	update_freq=30
	script="$PLUGIN_DIR/calendar.sh"
	click_script="Open /Applications/Dato.app"
)

sketchybar --add item calendar right \
	--set calendar "${calendar[@]}" \
	--subscribe calendar system_woke
