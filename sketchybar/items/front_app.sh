# #!/bin/bash

# FRONT_APP_SCRIPT='[ "$SENDER" = "front_app_switched" ] && sketchybar --set $NAME label="$INFO"'
#
# front_app=(
# 	icon.drawing=on
# 	label.font="$FONT:Black:13.0"
# 	label.color=$CYAN
# 	associated_display=active
# 	script="$FRONT_APP_SCRIPT"
# )
#
# sketchybar --add event window_focus \
# 	--add event windows_on_spaces \
# 	--add item yabai left \
# 	--set yabai "${yabai[@]}" \
# 	--subscribe yabai window_focus \
# 	windows_on_spaces \
# 	mouse.clicked \
# 	\
# 	--add item front_app left \
# 	--set front_app "${front_app[@]}" \
# 	--subscribe front_app front_app_switched
# #
front_app=(
	label.font="$FONT:Black:13.0"
	label.color=$CYAN
	icon.background.drawing=on
	display=active
	script="$PLUGIN_DIR/front_app.sh"
	click_script="open -a 'Mission Control'"
)

sketchybar --add item front_app left \
	--set front_app "${front_app[@]}" \
	--subscribe front_app front_app_switched
