#!/bin/bash
setscroll() {
  STATE="$(sketchybar --query "music.title" | sed 's/\\n//g; s/\\\$//g; s/\\ //g' | jq -r '.geometry.scroll_texts')"

  case "$1" in
    "on") target="off"
    ;;
    "off") target="on"
    ;;
  esac

  if [[ "$STATE" == "$target" ]]; then
    sketchybar --set "music.title" scroll_texts=$1
    sketchybar --set "music.subtitle" scroll_texts=$1
  fi

}

case "$SENDER" in
  "mouse.entered") setscroll on 
  ;;
  "mouse.exited") setscroll off
  ;;
esac