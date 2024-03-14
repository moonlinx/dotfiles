#!/bin/bash

# SPACE_ICONS=("I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X")
SPACE_ICONS=("一" "二" "三" "四" "五" "六" "七" "八" "九" "十")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (󰇙)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"; do
	sid=$(($i + 1))

	space=(
		associated_space=$sid
		icon=${SPACE_ICONS[i]}
		icon.padding_left=10
		icon.padding_right=10
		padding_left=2
		padding_right=2
		label.padding_right=15
		icon.highlight_color=$CYAN
		label.font="sketchybar-app-font:Regular:13.0"
		label.background.height=26
		label.background.drawing=on
		label.background.color=$BACKGROUND_2
		label.background.corner_radius=8
		label.drawing=off
		script="$PLUGIN_DIR/space.sh"
	)

	sketchybar --add space space.$sid left \
		--set space.$sid "${space[@]}" \
		--subscribe space.$sid mouse.clicked
done

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"; do
	sid=$(($i + 1))

	space=(
		associated_space=$sid
		icon=${SPACE_ICONS[i]}
		icon.padding_left=10
		icon.padding_right=15
		padding_left=2
		padding_right=2
		label.padding_right=20
		icon.highlight_color=$CYAN
		label.font="sketchybar-app-font:Regular:16.0"
		label.background.height=26
		label.background.drawing=on
		label.background.color=$BACKGROUND_2
		label.background.corner_radius=8
		label.drawing=off
		script="$PLUGIN_DIR/space.sh"
	)

	sketchybar --add space space.$sid left \
		--set space.$sid "${space[@]}" \
		--subscribe space.$sid mouse.clicked
done

spaces_bracket=(
	background.color=$BACKGROUND_1
	background.border_color=$BACKGROUND_2
	background.border_width=2
	background.drawing=on
)

separator=(
	icon=􀆊
	icon.font="$FONT:Heavy:13.0"
	padding_left=10
	padding_right=4
	label.drawing=off
	associated_display=active
	click_script='yabai -m space --create && sketchybar --trigger space_change'
	icon.color=$GOLD
)

sketchybar --add bracket spaces_bracket '/space\..*/' \
	--set spaces_bracket "${spaces_bracket[@]}" \
	\
	--add item separator left \
	--set separator "${separator[@]}"

# sid=0
# spaces=()
# for i in "${!SPACE_ICONS[@]}"; do
# 	sid=$(($i + 1))
#
# 	space=(
# 		associated_space=$sid
# 		icon=${SPACE_ICONS[i]}
# 		icon.padding_left=9
# 		icon.padding_right=13
# 		padding_left=2
# 		padding_right=2
# 		label.padding_right=20
# 		icon.highlight_color=$CYAN
# 		label.font="sketchybar-app-font:Regular:13.0"
# 		label.background.height=26
# 		label.background.drawing=on
# 		label.background.color=$BACKGROUND_2
# 		label.background.corner_radius=6
# 		label.drawing=off
# 		script="$PLUGIN_DIR/space.sh"
# 	)
#
# 	sketchybar --add space space.$sid left \
# 		--set space.$sid "${space[@]}" \
# 		--subscribe space.$sid mouse.clicked
# done
#
# spaces=(
# 	background.color=$BACKGROUND_1
# 	background.border_color=$BACKGROUND_2
# 	background.border_width=2
# 	background.drawing=on
# )
#
# separator=(
# 	icon=􀆊
# 	icon.font="$FONT:Heavy:14.0"
# 	padding_left=12
# 	padding_right=2
# 	label.drawing=off
# 	associated_display=active
# 	click_script='yabai -m space --create && sketchybar --trigger space_change'
# 	icon.color=$YELLOW
# )
#
# sketchybar --add bracket spaces '/space\..*/' \
# 	--set spaces "${spaces[@]}" \
# 	\
# 	--add item separator left \
# 	--set separator "${separator[@]}"
