#!/bin/bash

source "$CONFIG_DIR/settings.sh"

VPN_STATUS=$(scutil --nwi | grep -E '^   utun[0-9]')

case "$SENDER" in
"mouse.clicked")
    VPN_EXIST=$(networksetup -showpppoestatus "$VPN_NAME")
    if [[ -z "$VPN_EXIST" ]]; then
        echo "Error: VPN $VPN_NAME not exists, set VPN name in settings.sh first."
    else
        if [[ -n "$VPN_STATUS" ]]; then
            networksetup -disconnectpppoeservice "$VPN_NAME"
        else
            networksetup -connectpppoeservice "$VPN_NAME"
        fi
        sleep 1
        VPN_STATUS=$(scutil --nwi | grep -E '^   utun[0-9]')
        if [[ -n "$VPN_STATUS" ]]; then
            hs -c 'hs.alert("VPN Connected")'
        else
            hs -c 'hs.alert("VPN Disconnected")'
        fi
    fi
    ;;
esac

ICON=􀞞
HIGHLIGHT=on
if [[ -n "$VPN_STATUS" ]]; then
    ICON=􁃘
    HIGHLIGHT=off
fi

sketchybar --set $NAME icon="$ICON" icon.highlight="$HIGHLIGHT"
