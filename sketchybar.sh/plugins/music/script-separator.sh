#!/bin/bash
export PATH=/opt/homebrew/bin/:$PATH;
GRAPHSTATE="$(sketchybar --query graph | sed 's/\\n//g; s/\\\$//g; s/\\ //g' | jq -r '.geometry.drawing')"
MUSICSTATE="$(sketchybar --query music | sed 's/\\n//g; s/\\\$//g; s/\\ //g' | jq -r '.geometry.drawing')"

activitycount=0

if [ "$GRAPHSTATE" = "on" ]; then ((activitycount++)); fi
if [ "$MUSICSTATE" = "on" ]; then ((activitycount++)); fi

if [ $activitycount -gt 0 ]; then
  sketchybar --set separator_center drawing=on
else
  sketchybar --set separator_center drawing=off
fi