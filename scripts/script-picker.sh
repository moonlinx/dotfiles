#!/bin/bash

selection=$(
  eza "$HOME/Developer/Scripts/choose/" |
    choose -f "JetBrainsMono Nerd Font" -b "31748f" -c "eb6f92"
)

if [[ -n "$selection" && -f "$HOME/Developer/Scripts/choose/$selection" ]]; then
  "$HOME/Developer/Scripts/choose/$selection"
else
  echo "No valid script selected or script not found: $selection"
  exit 1
fi
