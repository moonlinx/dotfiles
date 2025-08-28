#!/bin/bash
export RELPATH=$(dirname $0)/../..;
source $RELPATH/colors.sh

ICONS_MICROPHONE=(􀊲 􀊰 􀊱)
update_icon() {
  VOLUME=$(osascript -e 'set ivol to input volume of (get volume settings)')
  case $VOLUME in
  [6-9][0-9] | 100)
    ICON=${ICONS_MICROPHONE[2]}
    COLOR=$IRIS_MOON
    ;;
  [1-9] | [1-5][0-9])
    ICON=${ICONS_MICROPHONE[1]}
    COLOR=$ROSE_MOON
    ;;
  *)
    ICON=${ICONS_MICROPHONE[0]}
    COLOR=$LOVE_MOON
    ;;
  esac

  sketchybar --animate tanh 30 --set $NAME icon=$ICON icon.color=$COLOR
}

update_label() {
  VOLUME=$(osascript -e 'set ivol to input volume of (get volume settings)')
  if [ $VOLUME != 0 ]; then
    mic=(
      label=$VOLUME
      label.drawing=off
    )
    sketchybar --set $NAME "${mic[@]}"
  fi
}

mute_mic() {
  osascript -e 'set volume input volume 0'
}

unmute_mic() {
  STORED_VOLUME=$(sketchybar --query $NAME | sed 's/\\n//g; s/\\\$//g; s/\\ //g' | jq -r '.label.value')
  osascript -e "set volume input volume $STORED_VOLUME"
}

toggle_mic() {
  VOLUME=$(osascript -e 'set ivol to input volume of (get volume settings)')
  if [ $VOLUME = 0 ]; then 
    update_label
    unmute_mic
  else
    mute_mic
  fi
}

case "$SENDER" in
  "mouse.clicked") toggle_mic; update_icon
  ;;
  *) update_label; update_icon
  ;;
esac