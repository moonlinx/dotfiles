#!/bin/bash
RealName=$(dscl . -read /Users/$(whoami) | awk '/RealName/ {gsub("RealName: ",""); print}')
sketchybar --set "$NAME" label="$RealName"