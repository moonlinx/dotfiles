#!/bin/bash
sleep $((59 - $(date '+%S')))

while [[ $(date '+%S') != "00" ]]; do
  sleep 0.1
done
sketchybar --set $NAME icon="$(date '+%a %d. %b')" label="$(date '+%H:%M')"