#!/bin/bash
export RELPATH=$(dirname $0)/../..;
source "$RELPATH/icon_map.sh"

if [ "$SENDER" = "space_windows_change" ]; then
  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $(__icon_map "$app"; echo $icon_result)"
    done <<< "${apps}"
    sketchybar --set space.$space label="$icon_strip" label.drawing=on #background.drawing=on
  else
    icon_strip=" -"
    sketchybar --set space.$space label.drawing=off #background.drawing=off
  fi
fi
