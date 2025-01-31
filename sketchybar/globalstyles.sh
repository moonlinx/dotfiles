#!/bin/bash

# Load defined icons
source "$CONFIG_DIR/icons.sh"

# Load defined colors
source "$CONFIG_DIR/colors.sh"

PADDINGS=8
FONT="JetBrains Mono"

# Bar Appearance
bar=(
  color=$BAR_COLOR
  position=top
  y_offset=4
  topmost=off
  shadow=off

  sticky=on
  height=32
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  corner_radius=5
  padding_right=2
  padding_left=2
  blur_radius=0
  notch_width=0
  margin=9

)

# Item Defaults
item_defaults=(
  background.padding_left=$((26 / 2))
  background.padding_right=$((26 / 2))
  icon.padding_left=$(($PADDINGS / 2))
  icon.background.corner_radius=4
  icon.background.height=18
  icon.font="$FONT:Regular:14"
  icon.color=$ICON_COLOR
  icon.highlight_color=$HIGHLIGHT
  label.font="sketchybar-app-font:Regular:16"
  label.color=$LABEL_COLOR
  label.highlight_color=$HIGHLIGHT
  label.padding_left=6
  updates=when_shown
  scroll_texts=on
)

icon_defaults=(
  label.drawing=off
)

notification_defaults=(
  drawing=off
  update_freq=120
  updates=on
  background.color="$(getcolor white 25)"
  background.height=16
  background.corner_radius=16
  icon.font.size=10
  icon.padding_left=$PADDINGS
  icon.padding_right=0
  icon.color="$(getcolor black 75)"
  label.color="$(getcolor black 75)"
  label.padding_right=$PADDINGS
  label.font.size=11
  label.font.style=Bold
)

bracket_defaults=(
  background.height=36
  background.color=00000000
  blur_radius=50
  label.font="$FONT:Regular:14"
  background.corner_radius=10
)

menu_defaults=(
  popup.blur_radius=36
  popup.background.color=$POPUP_BACKGROUND_COLOR
  popup.background.corner_radius=$PADDINGS
  popup.background.shadow.drawing=on
  popup.background.shadow.color=$(getcolor black 50)
  popup.background.shadow.angle=90
  popup.background.shadow.distance=16
)

menu_item_defaults=(
  label.font="$FONT:Regular:14"
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  icon.padding_left=0
  icon.color=$HIGHLIGHT
  background.color=$TRANSPARENT
  scroll_texts=on
)

separator=(
  background.height=1
  width=240
  background.color="$(getcolor white 25)"
  background.y_offset=-26
)
