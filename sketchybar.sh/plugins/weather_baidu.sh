#!/bin/bash

source "$CONFIG_DIR/settings.sh"

case "$SENDER" in
"mouse.clicked")
    open -a Weather
    exit 0
    ;;
esac

weather_info=$(curl -sf --max-time 10 --retry 3 https://weathernew.pae.baidu.com/weathernew/pc\?query\=${WEATHER_BAIDU_QUERY}\&srcid\=${WEATHER_BAIDU_SRCID}\&forecast\=long_day_forecast)
curl_status=$?

if [[ $curl_status -eq 0 ]] && [[ -n "$weather_info" ]]; then
    read temp weather_desc <<<$(echo "$weather_info" | grep 'data\["weather"\]' | cut -d '=' -f2 | cut -d ';' -f1 | jq -r '.temperature, .weather')
    read sunrise sunset <<<$(echo "$weather_info" | grep 'data\["feature"\]' | cut -d '=' -f2 | cut -d ';' -f1 | jq -r '.sunriseTime, .sunsetTime')
else
    echo "Error: weather curl failed. Curl status: $curl_status, weather_info: $weather_info"
    exit 1
fi

if [[ -z "$temp" || "$temp" == "null" ]] || [[ -z "$weather_desc" || "$weather_desc" == "null" ]] ||
    [[ -z "$sunrise" || "$sunrise" == "null" ]] || [[ -z "$sunset" || "$sunset" == "null" ]]; then
    echo "Error: parse weather_info failed. temp: $temp, weather_desc: $weather_desc, sunrise: $sunrise, sunset: $sunset"
    exit 1
fi

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

# https://openstd.samr.gov.cn/bzgk/std/newGbInfo?hcno=C4DD7502C8BBD485E2AB8B929608BB05
case $weather_desc in
'晴')
    ICON=$(in_daytime && echo 􀆮 || echo 􀇁)
    ;;
'少云' | '多云')
    ICON=$(in_daytime && echo 􀇕 || echo 􀇛)
    ;;
'阴')
    ICON=􀇃
    ;;
'雾' | '轻雾')
    ICON=􀇋
    ;;
'霾')
    ICON=$(in_daytime && echo 􀆸 || echo 􁑰)
    ;;
'阵雨')
    ICON=$(in_daytime && echo 􀇗 || echo 􀇝)
    ;;
'小雨')
    ICON=􀇅
    ;;
'雨' | '中雨')
    ICON=􀇇
    ;;
'大雨' | '暴雨' | '大暴雨' | '特大暴雨')
    ICON=􀇉
    ;;
'雷暴' | '雷暴大风')
    ICON=􀇓
    ;;
'雷阵雨')
    ICON=􀇟
    ;;
'冰雹')
    ICON=􀇍
    ;;
'雨夹雪')
    ICON=􀇑
    ;;
'阵雪')
    ICON=􁷑
    ;;
'雪' | '小雪' | '中雪')
    ICON=􀇏
    ;;
'大雪' | '暴雪' | '大暴雪' | '特大暴雪')
    ICON=􀇥
    ;;
'沙尘天气' | '浮尘' | '扬沙' | '沙尘暴' | '强沙尘暴' | '特强沙尘暴')
    ICON=$(in_daytime && echo 􀆶 || echo 􁶾)
    ;;
'热带气旋' | '热带低压' | '热带风暴' | '强热带风暴' | '台风' | '强台风' | '超强台风')
    ICON=􀇩
    ;;
'龙卷')
    ICON=􀇧
    ;;
*)
    ICON=􀆿
    echo "Unknown weather desc: $weather_desc"
    ;;
esac

temp=$(awk "BEGIN {printf(\"%.0f\", $temp)}")
LABEL="${temp}°C"

sketchybar --set $NAME icon="$ICON" label="$LABEL"
