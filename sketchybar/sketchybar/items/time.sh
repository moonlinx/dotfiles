#!/bin/bash

time=(
	icon.font="$FONT:Black:14.0"
	icon.color=$CHERRYBL
	label.font="$FONT:Black:13.0"
	label.color=$WHITE
	icon.y_offset=1
	label.padding_right=10
	label.padding_left=0
	icon.padding_left=0
	background.y_offset=0
	label.y_offset=-0
	label.align=right
	update_freq=30
	padding_left=2
	script="$PLUGIN_DIR/time.sh"
	click_script="$PLUGIN_DIR/zen.sh"
	# background.color="0xb8ebcb8b"
	#background.color=$CHERRYBL
	#background.corner_radius=6
	#background.height=25
	blur_radius=30
)

sketchybar --add item time right \
	--set time "${time[@]}" \
	--subscribe time
