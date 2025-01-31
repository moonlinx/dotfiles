#!/bin/env/bash
source "$CONFIG_DIR/globalstyles.sh"
battery=(
  icon.font.size=16
  icon.padding_right=0
  label.font="$FONT:BOLD:14"
  icon.font.style="Light"
  update_freq=30
  popup.align=right                                            
  script="$PLUGIN_DIR/battery.sh"                              
  updates=when_shown                                           
)

sketchybar                                 \
  --add item battery right                 \
  --set battery "${battery[@]}"            \
  --subscribe battery power_source_change  \
                      mouse.clicked
