#!/usr/bin/env bash

export LANG=en_US.UTF-8

selection=$(
  cat "$HOME/Developer/Scripts/system-scripts/stuff/emoji" |
    choose -f "JetBrainsMono Nerd Font" -b "31748f" -c "eb6f92" |
    sed "s/ .*//"
)

[[ -z "$selection" ]] && exit 1

printf "%s" "$selection" | pbcopy

osascript -e 'tell application "System Events" to keystroke "v" using {command down}'
