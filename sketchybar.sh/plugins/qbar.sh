#!/bin/bash

source "$CONFIG_DIR/settings.sh"

if [[ "$NAME" == "qbar_body" ]]; then
    NAME="qbar"
fi

URL="http://127.0.0.1:9527/get_jarvis_state"

if is_dark_mode; then
    RED=$RED1
    GREEN=$GREEN1
else
    RED=$RED2
    GREEN=$GREEN2
fi

refresh() {
    BUILD_POPUP=$1

    state_info=$(curl -sf --max-time 10 --retry 3 "$URL")
    curl_status=$?

    if [[ $curl_status -eq 0 ]] && [[ -n "$state_info" ]]; then
        read code_name last_price prev_close holding last_run_ts messages <<<$(echo "$state_info" | jq -r '.code_name, .last_price, .prev_close, .holding, .last_run_tsxxx, .messages')
    else
        # echo "Error: state curl failed. Curl status: $curl_status, state_info: $state_info"
        sketchybar --set qbar label="Loading..." \
            --set qbar_body drawing=off
        exit 1
    fi

    ### prefix(holding or not), content(price change or pnl)
    PREFIX=""
    CONTENT=""
    COLOR=""
    if [[ "$holding" == "true" ]]; then
        read price qty side <<<$(echo "$state_info" | jq -r '.position' | jq -r '.price, .qty, .side')

        if [[ "$qty" == "0" ]]; then
            PREFIX="Jarvis"
        else
            PREFIX="Carbyn"
        fi

        if [[ "$side" == "long" ]]; then
            PREFIX="${PREFIX}󰧆"
        else
            PREFIX="${PREFIX}󰦺"
        fi

        read pnl max_loss max_profit <<<$(echo "$state_info" | jq -r '.pnl' | jq -r '.pnl, .max_loss, .max_profit')

        arrow=""
        delta_sign=""
        if [[ "$pnl" -gt 0 ]]; then
            arrow="󰁞"
            delta_sign="+"
            COLOR=$RED
        elif [[ "$pnl" -lt 0 ]]; then
            arrow="󰁆"
            COLOR=$GREEN
        else
            COLOR=$GREY1
        fi

        CONTENT="${last_price}${arrow} ${delta_sign}${pnl}[$max_loss,$max_profit]"
    else
        PREFIX=$code_name
        delta=$(($last_price - $prev_close))
        delta_ratio=$(echo "scale=3; $delta * 100 / $prev_close" | bc)
        delta_ratio=$(awk "BEGIN {printf(\"%.2f\", $delta_ratio)}")

        arrow=""
        delta_sign=""
        if [[ "$delta" -gt 0 ]]; then
            arrow="󰁞"
            delta_sign="+"
            COLOR=$RED
        elif [[ "$delta" -lt 0 ]]; then
            arrow="󰁆"
            COLOR=$GREEN
        else
            COLOR=$GREY1
        fi

        CONTENT="${last_price}${arrow} ${delta_sign}${delta} ${delta_sign}${delta_ratio}%"
    fi

    sketchybar --set qbar label="$PREFIX" \
        --set qbar_body drawing=on label="$CONTENT" label.color=$COLOR

    ### messages popup
    if [[ "$BUILD_POPUP" == "off" ]]; then
        return
    fi

    args=(--set qbar popup.align=left)
    if $(sketchybar --query qbar | jq '.popup.items | length != 0'); then
        args+=(--remove '/qbar.popup\.*/')
    fi

    if [[ -n "$messages" && "$messages" != "[]" && "$messages" != "null" ]]; then
        while read -r message; do
            read id ts content <<<$(jq -r '.id, .ts, .content' <<<"$message")
            time=$(date -r "$ts" "+%H:%M")

            args+=(
                --add item qbar.popup.$ts popup.qbar
                --set qbar.popup.$ts "${popup_item[@]}" label="$time  $content"
            )
        done < <(echo "$messages" | jq -c 'reverse | .[]')
    else
        args+=(
            --add item qbar.popup.empty popup.qbar
            --set qbar.popup.empty "${popup_item[@]}" label="****** No Messages ******"
        )
    fi

    sketchybar -m "${args[@]}"
}

case "$SENDER" in
"mouse.clicked")
    refresh on
    popup on
    ;;
"mouse.exited.global")
    popup off
    ;;
*)
    refresh off
    ;;
esac
