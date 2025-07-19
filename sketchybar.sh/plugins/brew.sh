#!/bin/bash

source "$CONFIG_DIR/settings.sh"

clear() {
    source "$CONFIG_DIR/settings.sh"
    args=(--set $NAME icon.color=$ICON_COLOR)
    if $(sketchybar --query $NAME | jq '.popup.items | length != 0'); then
        args+=(--remove '/brew.popup\.*/')
    fi
    sketchybar -m "${args[@]}" >/dev/null
}

refresh() {
    zsh -c 'brew update &>/dev/null'
    OUTDATED=$(zsh -c 'brew outdated --verbose | grep -v pinned')

    if [[ -z "$OUTDATED" ]]; then
        clear
        return
    fi

    args=(--set $NAME icon.color=$SALMON popup.align=right)
    if $(sketchybar --query $NAME | jq '.popup.items | length != 0'); then
        args+=(--remove '/brew.popup\.*/')
    fi

    COUNTER=0
    while IFS= read -r package; do
        args+=(
            --add item "$NAME".popup.$COUNTER popup."$NAME"
            --set "$NAME".popup.$COUNTER "${popup_item[@]}" label="${package}"
        )
        COUNTER=$((COUNTER + 1))
    done <<<"$OUTDATED"

    sketchybar -m "${args[@]}" >/dev/null
}

update() {
    osascript -e 'display notification "Starting Brew package updates..." with title "Package Updates"'
    zsh -c 'brew upgrade >/dev/null && brew cleanup >/dev/null'
    osascript -e 'display notification "Brew packages updated" with title "Package Updates"'
    clear
}

case "$SENDER" in
"mouse.entered")
    popup on
    ;;
"mouse.exited" | "mouse.exited.global")
    popup off
    ;;
"mouse.clicked")
    popup off
    update
    ;;
*)
    refresh
    ;;
esac
