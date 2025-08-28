#!/bin/bash
SCRIPT_POPUP_TOGGLE="export PATH=$PATH; $RELPATH/plugins/logo/script.sh \"$FONT\" $X_BAR_PADDING"

logo=(
  icon=􀆔
  padding_left=$X_BAR_PADDING
  padding_right=10
  icon.font="$FONT:Semibold:14.0"
  icon.color=$TEXT_MOON
  icon.padding_left=8
  icon.padding_right=8
  script="$SCRIPT_POPUP_TOGGLE"
  label.drawing=off
  background.height=$(($BAR_HEIGHT - 8))
  background.border_width=2
  background.border_color=$HIGH_MED_MOON
  background.color=$OVERLAY_MOON
  background.drawing=off
)

sketchybar --add item logo left \
  --set logo "${logo[@]}" \
  --subscribe logo front_app_switched mouse.clicked 
