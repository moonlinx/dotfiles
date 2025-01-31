#!/bin/env/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

music=(
  "${bracket_defaults[@]}"
  script="$PLUGIN_DIR/music.sh"
  popup.align=center
  icon.padding_right=$PADDINGS
  label.padding_left=28
  label.padding_right=50
  # padding_right=$(($PADDINGS * 2))
  drawing=off
  label="Loading…"
  background.image=media.artwork
  background.image.scale=0.62
  background.image.corner_radius=3
  icon.font="$FONT:Regular:14"
  label.max_chars=40
  updates=on
  --subscribe music media_change
)

sketchybar \
  --add item music right \
  --set music "${music[@]}"

