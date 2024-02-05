#!/bin/bash

calendar=(
	icon.font="$FONT:Black:15.0"
	icon.color=$CHERRYBL
	label.font="$FONT:Black:13.0"
	label.color=$WHITE
	icon.y_offset=1
	icon.padding_right=55
	label.width=45
	label.align=right
	padding_left=13
	update_freq=30
	script="$PLUGIN_DIR/calendar.sh"
	click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right \
	--set calendar "${calendar[@]}" \
	--subscribe calendar system_woke
