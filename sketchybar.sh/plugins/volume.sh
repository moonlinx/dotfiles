#!/bin/bash

set_icon() {
    VOLUME=$1
    HIGHLIGHT=off

    case $VOLUME in
    [6-9][0-9] | 100)
        ICON=􀊩
        ;;
    [3-5][0-9])
        ICON=􀊧
        ;;
    [1-9] | [1-2][0-9])
        ICON=􀊥
        ;;
    *)
        ICON=􀊣
        HIGHLIGHT=on
        ;;
    esac

    sketchybar --set $NAME icon=$ICON icon.highlight=$HIGHLIGHT
}

case "$SENDER" in
"mouse.clicked")
    IS_MUTED=$(osascript -e "output muted of (get volume settings)")
    if [[ "$IS_MUTED" == "true" ]]; then
        osascript -e "set volume output muted false"
    else
        osascript -e "set volume output muted true"
    fi
    ;;
"volume_change")
    set_icon $INFO
    ;;
*)
    VOLUME=$(osascript -e "output volume of (get volume settings)")
    set_icon $VOLUME
    ;;
esac
