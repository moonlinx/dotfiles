#!/bin/bash
export RELPATH=$(dirname $0)/../..;
WIDTH=100

if which menubar 2>/dev/null 1>&2;then
  menubar=$(which menubar)
else
  menubar=$RELPATH/menubar
fi

detail_on() {
  sketchybar --animate tanh 30 --set volume slider.width=$WIDTH
}

detail_off() {
  sketchybar --animate tanh 30 --set volume slider.width=0
}

toggle_detail() {
  if [ $BUTTON = "left" ]; then
    INITIAL_WIDTH=$(sketchybar --query volume | sed 's/\\n/\\\\n/g; s/\\\$/$/g' | jq -r '.slider.width')
    if [ "$INITIAL_WIDTH" -eq "0" ]; then
      detail_on
    else
      detail_off
    fi
  else
    $menubar -s "Control Center,Sound"
  fi
}

toggle_detail