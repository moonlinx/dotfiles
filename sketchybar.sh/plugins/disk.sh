#!/bin/bash

sketchybar --set $NAME label=$(df -H | grep -E '^(/dev/disk3s5).' | awk '{ printf ("%s\n", $4) }')
