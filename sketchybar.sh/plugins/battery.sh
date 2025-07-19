#!/bin/bash

source "$CONFIG_DIR/settings.sh"

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

# TEST: No battery on mac studio
# PERCENTAGE=100

if [[ -z "$PERCENTAGE" ]]; then
    exit 0
fi

COLOR=$ICON_COLOR
case $PERCENTAGE in
9[0-9] | 100)
    ICON=􀛨
    ;;
[6-8][0-9])
    ICON=􀺸
    ;;
[3-5][0-9])
    ICON=􀺶
    ;;
[1-2][0-9])
    ICON=􀛩
    ;;
*)
    ICON=􀛪
    COLOR=$RED
    ;;
esac

if [[ -n "$CHARGING" ]]; then
    ICON=􀢋
fi

sketchybar --set $NAME icon=$ICON icon.color=$COLOR drawing=on
