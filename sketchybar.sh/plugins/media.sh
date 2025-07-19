#!/bin/bash

get_music_info() {
    osascript <<EOF
tell application "Music"
  if it is running and player state is playing then
    set track_name to name of current track
    set artist_name to artist of current track
    return track_name & " - " & artist_name
  else
    return ""
  end if
end tell
EOF
}

music_info=$(get_music_info)

if [[ -n "$music_info" ]]; then
    sketchybar --set $NAME label="$music_info" drawing=on
else
    sketchybar --set $NAME label="" drawing=off
fi
