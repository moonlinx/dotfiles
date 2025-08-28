#!/bin/bash
export RELPATH=$(dirname $0)/../..;

controls=(
  $1
)
menuitems=(
  $2
)
INNER_PADDINGS=$3
FONT="$4"

ICON_VALUE="$(sketchybar --query $NAME | sed 's/\\n//g; s/\\\$//g; s/\\ //g' | jq -r '.icon.value')"
GRAPHSTATE="$(sketchybar --query graph | sed 's/\\n//g; s/\\\$//g; s/\\ //g' | jq -r '.geometry.drawing')"

if [[ $ICON_VALUE = '|' ]]; then
  STATE=on
else
  STATE=off
fi

menu_set() {
  for item in ${menuitems[@]}; do
    sketchybar --animate tanh 15 \
               --set moremenu.$item drawing=$1
  done

  for item in "${controls[@]}"; do
    item=$(echo "$item" | sed -e "s/__/ /g")
    sketchybar --animate tanh 15 \
               --set "$item" drawing=$1
  done

  if [ $1 = "on" ]; then
    sketchybar --trigger more-menu-update
  fi
}

#echo $STATE $GRAPHSTATE $MODIFIER

if [ "$STATE" = "off" ]; then
  if [ "$MODIFIER" = "alt" ] && [ "$GRAPHSTATE" = "off" ];then 
    sketchybar --set '/graph.*/' drawing=on \
               --set $NAME icon=􀫰 \
               --trigger activities_update

  elif [ $GRAPHSTATE = "on" ];then 
    sketchybar --set '/graph.*/' drawing=off \
               --set $NAME icon=􀯶 \
               --trigger activities_update

    for (( i=0; i <= 140; ++i )); do
      sketchybar --push graph 0.0
    done

  else 
    menu_set "on"
    separator=(
      icon="|"
      icon.font="$FONT:Bold:16.0"
      icon.padding_left=0
      icon.padding_right=0
    )
    sketchybar --set $NAME icon.y_offset=2 \
               --animate tanh 15 \
               --set $NAME "${separator[@]}"
  fi
else
  menu_set "off"
  separator=(
    icon="􀯶"
    icon.font="$FONT:Semibold:14.0"
    icon.padding_left=$INNER_PADDINGS
    icon.padding_right=$INNER_PADDINGS
  )
  sketchybar --set $NAME icon.y_offset=0 \
             --animate tanh 15 \
             --set $NAME "${separator[@]}"
fi