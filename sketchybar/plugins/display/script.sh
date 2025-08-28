#!/bin/bash
export PATH=/opt/homebrew/bin/:$PATH;

displaygroups=(
  "Built-in"
  "Built-in + External"
  "Dual External"
)

ICON="􀢹"
if [ -n "$(pgrep "BetterDisplay")" ]; then
  for displayGroup in "${displaygroups[@]}"; do
    if [ "$(betterdisplaycli get --name="$displayGroup" --active)" = "on" ]; then
      case "$displayGroup" in
        'Built-in') ICON="􁈸"
        ;;
        'Built-in + External') ICON="􂤓"
        ;;
        'Dual External') ICON="􀨧"
        ;;
      esac
    fi
  done
  sketchybar --set $NAME icon="$ICON" drawing="on" 
else
  sketchybar --set $NAME drawing="off"
fi