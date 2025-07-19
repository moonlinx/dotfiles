#!/bin/bash

IP="$(ipconfig getsummary en0 | grep -o "yiaddr = .*" | sed 's/^yiaddr = //')"

ICON=􀙈
HIGHLIGHT=on
if [[ -n "$IP" ]]; then
  ICON=􀙇
  HIGHLIGHT=off
fi

sketchybar --set $NAME icon=$ICON icon.highlight=$HIGHLIGHT
