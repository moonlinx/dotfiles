#!/bin/bash

source "$CONFIG_DIR/settings.sh"

case "$SENDER" in
"mouse.clicked")
    open -a Weather
    exit 0
    ;;
esac

# https://open-meteo.com/en/docs/cma-api
url="https://api.open-meteo.com/v1/forecast?latitude=${WEATHER_METEO_LATITUDE}&longitude=${WEATHER_METEO_LONGITUDE}&hourly=temperature_2m,weather_code&daily=sunrise,sunset&timezone=auto&forecast_days=1&models=cma_grapes_global"

weather_info=$(curl -sf --max-time 10 --retry 3 "$url")
curl_status=$?

hour=$(date "+%H")
if [[ $curl_status -eq 0 ]] && [[ -n "$weather_info" ]]; then
    read temp weather_code sunrise sunset <<<$(echo "$weather_info" | jq -r ".hourly.temperature_2m[$hour], .hourly.weather_code[$hour], .daily.sunrise[0], .daily.sunset[0]")
else
    echo "Error: weather curl failed. Curl status: $curl_status, weather_info: $weather_info"
    exit 1
fi

if [[ -z "$temp" || "$temp" == "null" ]] || [[ -z "$weather_code" || "$weather_code" == "null" ]] ||
    [[ -z "$sunrise" || "$sunrise" == "null" ]] || [[ -z "$sunset" || "$sunset" == "null" ]]; then
    echo "Error: parse weather_info failed. temp: $temp, weather_code: $weather_code, sunrise: $sunrise, sunset: $sunset"
    exit 1
fi

sunrise=$(echo $sunrise | cut -d 'T' -f2)
sunset=$(echo $sunset | cut -d 'T' -f2)

is_time_between() {
    local start="$1"
    local end="$2"
    local current=$(date +%H:%M)

    local start_min=$((10#${start%%:*} * 60 + 10#${start##*:}))
    local end_min=$((10#${end%%:*} * 60 + 10#${end##*:}))
    local curr_min=$((10#${current%%:*} * 60 + 10#${current##*:}))

    if ((end_min < start_min)); then
        ((curr_min >= start_min || curr_min < end_min))
    else
        ((curr_min >= start_min && curr_min < end_min))
    fi
}

in_daytime() {
    if is_time_between $sunrise $sunset; then
        return 0
    else
        return 1
    fi
}

# https://open-meteo.com/en/docs
case $weather_code in
0)
    ICON=$(in_daytime && echo 􀆮 || echo 􀇁)
    ;;
1 | 2)
    ICON=$(in_daytime && echo 􀇕 || echo 􀇛)
    ;;
3)
    ICON=􀇃
    ;;
45 | 48)
    ICON=􀇋
    ;;
51 | 53 | 55 | 56 | 57)
    ICON=$(in_daytime && echo 􀇗 || echo 􀇝)
    ;;
61 | 63 | 65 | 66 | 67)
    ICON=􀇉
    ;;
71 | 73 | 75)
    ICON=􀇏
    ;;
77)
    ICON=􀇥
    ;;
80 | 81 | 82)
    ICON=􀇉
    ;;
85 | 86)
    ICON=􀇏
    ;;
95 | 96 | 99)
    ICON=􀇟
    ;;
*)
    ICON=􀆿
    echo "Unknown weather code: $weather_code"
    ;;
esac

temp=$(awk "BEGIN {printf(\"%.0f\", $temp)}")
LABEL="${temp}°C"

sketchybar --set $NAME icon="$ICON" label="$LABEL"
