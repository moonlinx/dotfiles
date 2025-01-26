#!/bin/bash

yabai=(
  icon.width=0
  label.width=0
  script="$PLUGIN_DIR/yabai.sh"
  icon.font="$FONT:Bold:16.0"
  associated_display=active
)

sketchybar --add event window_focus \
  --add event windows_on_spaces \
  --add item yabai left \
  --set yabai "${yabai[@]}" \
  --subscribe yabai window_focus \
  space_change \
  windows_on_spaces \
  mouse.scrolled.global \
  mouse.clicked

#!/bin/bash

yabai=(
  icon=$ICON_YABAI_GRID
  label.drawing=off
  width=28
  script="$PLUGIN_DIR/yabai.sh"
  label.padding_right=$PADDINGS
)

# Allows my shortcut / workflow in Alfred to trigger things in Sketchybar
sketchybar --add event update_yabai_icon

sketchybar --add item yabai left \
  --set yabai "${yabai[@]}" \
  --subscribe yabai space_change \
  mouse.scrolled.global \
  mouse.clicked \
  front_app_switched \
  space_windows_change \
  alfred_trigger \
  update_yabai_icon
