#!/usr/bin/env bash

# VPN=$(scutil --nc list | grep Connected | sed -E 's/.*"(.*)".*/\1/')

VPN_STATUS=$(scutil --nwi | grep -m1 'VPN')

if [[ "$VPN_STATUS" == "Connected" ]]; then
  sketchybar --set $NAME icon=􀎡 drawing=on
else
  sketchybar --set $NAME drawing=off
fi

