#!/usr/bin/env bash

selection=$(
    ffmpeg -f avfoundation -list_devices true -i "" 2>&1 | \
    awk '/AVFoundation video devices:/,/AVFoundation audio devices:/ {if (/\[[0-9]\]/) print}' | \
    sed 's/.*\(\[[0-9]\] .*\)/\1/' | \
    choose -f "JetBrainsMono Nerd Font" -b "31748f" -c "eb6f92"
)

[[ -z "$selection" ]] && exit 1

camera_index=$(echo "$selection" | grep -o '\[[0-9]\+\]' | tr -d '[]')

ffplay -f avfoundation -framerate 30 -window_title Camera -video_size 1280x720 -i "${camera_index}:"
