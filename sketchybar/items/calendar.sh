#!/bin/bash

calendar=(
	icon=cal
	icon.font="$FONT:Bold:14.0"
	icon.color="$WHITE"
	icon.padding_right=0
	label.width=45
	label.align=right
	label.font="$FONT:Black:13.0"
	label.color="$WHITE"
	padding_left=15
	update_freq=30
	script="$PLUGIN_DIR/calendar.sh"
	click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right \
	--set calendar "${calendar[@]}" \
	--subscribe calendar system_woke
