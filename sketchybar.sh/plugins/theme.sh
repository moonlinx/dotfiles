#!/bin/bash

source "$CONFIG_DIR/settings.sh"

set_wallpaper() {
    NEW_WALLPAPER=$1
    if [[ -f "$NEW_WALLPAPER" ]]; then
        osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$NEW_WALLPAPER\""
    else
        echo "Error: NEW_WALLPAPER not found, set wallpapers path in settings.sh first."
    fi
}

switch_theme() {
    if is_dark_mode; then
        NEW_THEME="light"
        NEW_WALLPAPER=$LIGHT_WALLPAPER
    else
        NEW_THEME="dark"
        NEW_WALLPAPER=$DARK_WALLPAPER
    fi

    sed -i '' "s/^THEME=\"$THEME\"/THEME=\"$NEW_THEME\"/" $CONFIG_DIR/settings.sh
    sketchybar --reload
    set_wallpaper $NEW_WALLPAPER
}

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

if [[ "$THEME" == "light" ]]; then
    set_wallpaper $LIGHT_WALLPAPER
else
    set_wallpaper $DARK_WALLPAPER
fi

if [[ "$AUTO_SWITCH_THEME" == "on" ]]; then
    if is_dark_mode; then
        if is_time_between $LIGHT_START_TIME $LIGHT_END_TIME; then
            switch_theme
        fi
    else
        if ! is_time_between $LIGHT_START_TIME $LIGHT_END_TIME; then
            switch_theme
        fi
    fi
fi

case "$SENDER" in
"mouse.clicked")
    if [[ "$AUTO_SWITCH_THEME" == "on" ]]; then
        hs -c 'hs.alert("Auto Switch Enabled")'
    else
        switch_theme
    fi
    ;;
esac
