#!/usr/bin/env bash

folder="$HOME/Notes/"

opennote() {
  osascript <<EOF
    delay 1

    on is_running(appName)
    	tell application "System Events" to (name of processes) contains appName
    end is_running

    if not is_running("wezterm") then
    	tell application "wezterm" to activate
    else
    	tell application "System Events" to tell process "wezterm"
    		click menu item "New OS Window" of menu 1 of menu bar item "Shell" of menu bar 1
    	end tell
    end if

    delay 0.2

    tell application "System Events"
        keystroke "nvim "
        keystroke "$folder/$1"
        key code 36 -- press return
    end tell
EOF
}

newnote() {
  name="$(echo "-" | choose -f 'JetBrainsMono Nerd Font' -b '31748f' -c 'eb6f92' -p 'Enter a name: ' -m)" || exit 0

  if [ "$name" = "-" ]; then
    name="$(date +%F_%T | tr ':' '-')"
  fi

  name="${name}.md"
  opennote "$name"
}

selected() {
  options="New"$'\n'"$(ls -1t "$folder")"
  choice=$(printf "%s" "$options" | choose -f 'JetBrainsMono Nerd Font' -b '31748f' -c 'eb6f92' -p 'Choose note or create new: ')
  case "$choice" in
  New)
    newnote
    ;;
  *.md)
    opennote "$choice"
    ;;
  *)
    exit
    ;;
  esac
}

selected
