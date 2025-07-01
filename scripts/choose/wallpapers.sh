#!/usr/bin/env bash

selection=$(
  ls "$HOME/Pictures/Wallpapers" |
    sed 's/\.[^.]*$//' |
    choose -f "JetBrainsMono Nerd Font" -b "31748f" -c "eb6f92"
)

# Exit if nothing was selected
[[ -z "$selection" ]] && exit 1

file_path=$(find "$HOME/Pictures/Wallpapers" -type f -name "${selection}.*" | head -n 1)

# Exit if no matching file found
[[ -z "$file_path" ]] && {
  echo "File not found"
  exit 1
}

osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"${file_path}\""
