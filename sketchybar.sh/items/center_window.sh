#!/bin/bash

center_window=(
    icon=􀥝
    click_script="hs -c 'hs.window.frontmostWindow():centerOnScreen()'"
)

sketchybar --add item center_window right \
    --set center_window "${center_window[@]}"
