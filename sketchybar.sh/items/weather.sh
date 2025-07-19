#!/bin/bash

weather=(
    width=100
    align=right
    padding_left=0
    padding_right=0
    label.padding_right=0
    label="--°"
    update_freq=300

    # Of the 3 data sources, select the one you find most accurate.
    script="$PLUGIN_DIR/weather_baidu.sh"
    # script="$PLUGIN_DIR/weather_nmc.sh"
    # script="$PLUGIN_DIR/weather_meteo.sh"
)

sketchybar --add item weather center \
    --set weather "${weather[@]}" \
    --subscribe weather mouse.clicked
