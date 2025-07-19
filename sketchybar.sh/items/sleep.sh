#!/bin/bash

sleep=(
    icon=􀷄
    click_script="osascript -e 'tell application \"System Events\" to sleep'"
)

sketchybar --add item sleep right \
    --set sleep "${sleep[@]}"
