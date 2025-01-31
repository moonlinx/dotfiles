#!/bin/bash

# Loads defined colors
source "$CONFIG_DIR/colors.sh"

POPUP_OFF="sketchybar --set wifi popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set wifi popup.drawing=toggle"

IS_VPN=$(scutil --nwi | grep -m1 'VPN' | awk '{ print $4 }')
# IS_VPN="Disconnected"
CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
IP_ADDRESS="$(ipconfig getsummary en0)"
SSID="$(echo "$CURRENT_WIFI" | awk -F ' SSID : ' '/ SSID : / {print $2}')"
CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"
# "$(ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}')"

if [[ $IS_VPN != "Disconnected" ]]; then
  ICON_COLOR=$(getcolor white)
  ICON=􀙇
elif [[ $SSID = "Ebrietas" ]]; then
  ICON_COLOR=$(getcolor white)
  ICON=􀉤
elif [[ $SSID != "" ]]; then
  ICON_COLOR=$(getcolor white)
  ICON=􀐿
elif [[ $CURRENT_WIFI = "AirPort: Off" ]]; then
  ICON=􀉤
else
  ICON_COLOR=$(getcolor white)
  ICON=􀙇
fi

render_bar_item() {
  sketchybar --set $NAME \
    icon.color=$ICON_COLOR \
    icon=$ICON \
    click_script="$POPUP_CLICK_SCRIPT"
}

render_popup() {
  if [ "$SSID" != "" ]; then
    args=(
      --set wifi click_script="$POPUP_CLICK_SCRIPT"
      --set wifi.ssid label="$SSID"
      --set wifi.strength label="$CURR_TX Mbps"
      --set wifi.ipaddress label="$IP_ADDRESS"
      click_script="printf $IP_ADDRESS | pbcopy;$POPUP_OFF"
    )
  else
    args=(
      --set wifi click_script="")
  fi

  sketchybar "${args[@]}" >/dev/null
}

update() {
  render_bar_item
  render_popup
}

popup() {
  sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in
"routine" | "forced")
  update
  ;;
"mouse.clicked")
  popup on
  ;;
"mouse.exited" | "mouse.exited.global")
  popup off
  ;;
esac

# click_script="sketchybar --set wifi.alias popup.drawing=toggle; $WIFI_CLICK_SCRIPT" \
