source "$PLUGIN_DIR/wifi.sh"

sketchybar --add item           wifi.control right                      \
                                                                        \
           --set wifi.control   icon=$WIFI                              \
                                icon.color=$MAGENTA                        \
                                label.drawing=on                       \
                                click_script="$POPUP_CLICK_SCRIPT"      \
                                popup.background.color=0x70000000       \
                                popup.blur_radius=50                    \
                                popup.background.corner_radius=5        \
                                                                        \
           --add item           wifi.ssid popup.wifi.control            \
           --set wifi.ssid      icon=$NETWORK                           \
                                label="${SSID}"                         \
           --add item           wifi.ip popup.wifi.control              \
           --set wifi.ip        icon=$IP                                \
                                label="$IP_ADDR"                        \
                                update_freq=60                           \
           --add item           wifi.speed     popup.wifi.control       \
           --set wifi.speed     icon=$SPEED                              \
                                script="$PLUGIN_DIR/wifi_click.sh"        \
                                update_freq=10                          \


if [ ! -f /tmp/sketchybar_wifi ]; then
  touch /tmp/sketchybar_wifi
fi

if [ ! -f /tmp/sketchybar_speed ]; then
  (
    COUNTER=0
    END_TIME=$(($(date +%s) + 9))
    while [ $(date +%s) -lt $END_TIME ]; do
      case $COUNTER in
      0) LABEL="Loading." ;;
      1) LABEL="Loading.." ;;
      2) LABEL="Loading..." ;;
      esac
      sketchybar --set wifi.speed label="$LABEL"
      sleep 1
      COUNTER=$(((COUNTER + 1) % 3))
    done
  ) &
fi

if [ "$WIFI_POWER" == "Off" ]; then
  sketchybar --set $NAME label=$WIFI_OFF
  exit 0
fi

SSID_LOWER=$(echo "$SSID" | tr '[:upper:]' '[:lower:]')
if [[ "$SSID_LOWER" == *iphone* ]]; then
  sketchybar --set $NAME label=$HOTSPOT
  exit 0
fi

if [ $CURR_TX = 0 ]; then
  sketchybar --set $NAME label=$WIFI_NO_INTERNET
  exit 0
fi

sketchybar --set $NAME label=$WIFI
