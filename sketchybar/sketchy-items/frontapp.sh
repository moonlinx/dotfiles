#!/bin/bash
SCRIPT_FRONT_APP="export PATH=$PATH; $RELPATH/plugins/frontapp/script.sh"

SCRIPT_CLICK_FRONT_APP="export PATH=$PATH; yabai -m window --toggle float"

front_app=(
  background.color=$OVERLAY_MOON
  background.height=$(($BAR_HEIGHT - 12))
  background.corner_radius=7
  icon=􀢌
  icon.font="sketchybar-app-font:Regular:15.0"
  icon.color=$PINE_MOON
  script="$SCRIPT_FRONT_APP"
  click_script="$SCRIPT_CLICK_FRONT_APP"
  padding_left=5
  label.color=$TEXT_MOON
  label.font="$FONT:Black:12.0"
  associated_display=active
)

sketchybar --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app system_woke front_app_switched
