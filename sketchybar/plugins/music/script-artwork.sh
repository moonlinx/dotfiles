#!/bin/bash
export PATH=/opt/homebrew/bin/:$PATH;
export RELPATH=$(dirname $0)/../..;
#SKETCHYBAR_MEDIASTREAM#

pids=$(ps -p $(pgrep sh) | grep '#SKETCHYBAR_MEDIASTREAM#' | awk '{print $1}')

if [[ -n "$pids" ]]; then
  pids+=" $(cat ${TMPDIR}/sketchybar/pids)"
  echo killing "#SKETCHYBAR_MEDIASTREAM# pids:" $pids
  kill -9 $pids
fi

ARTWORK_MARGIN="$1"
BAR_HEIGHT="$2"

media-control stream | grep --line-buffered 'data' | while IFS= read -r line; do

  if ps -p $$>/dev/null; then # list childs to prevent multiple background process remaining
    pgrep -P $$ >${TMPDIR}/sketchybar/pids
  fi

  if ! { 
    [[ "$(echo $line | jq -r .payload)" == '{}' ]] || 
    { [[ -n "$lastAppPID" ]] && ! ps -p "$lastAppPID" > /dev/null; }; 
  }; then

    artworkData=$(echo $line | jq -r .payload.artworkData)
    currentPID=$(echo $line | jq -r .payload.processIdentifier)
    playing=$(echo $line | jq -r .payload.playing)

    # Set Artwork

    if [[ $artworkData != "null" ]];then

      tmpfile=$(mktemp ${TMPDIR}sketchybar/cover.XXXXXXXXXX)

      echo $artworkData | \
        base64 -d > $tmpfile

      case $(identify -ping -format '%m' $tmpfile) in
        "JPEG") ext=jpg
        mv $tmpfile $tmpfile.$ext
        ;;
        "PNG") ext=png
        mv $tmpfile $tmpfile.$ext
        ;;
        "TIFF") 
        mv $tmpfile $tmpfile.tiff
        magick $tmpfile.tiff $tmpfile.jpg
        ext=jpg
        ;;
      esac

      scale=$(bc <<< "scale=4; 
        ( ($BAR_HEIGHT - $ARTWORK_MARGIN * 2) / $(identify -ping -format '%h' $tmpfile.$ext) )
      ")
      icon_width=$(bc <<< "scale=0; 
        ( $(identify -ping -format '%w' $tmpfile.$ext) * $scale )
      ")

      sketchybar --set $NAME background.image=$tmpfile.$ext \
                              background.image.scale=$scale \
                              icon.width=$(printf "%.0f" $icon_width)

      rm -f $tmpfile*
    fi

    # Set Title and artist + ?Album

    if [[ $(echo $line | jq -r .payload.title) != "null" ]];then

      title_label="$(echo $line | jq -r .payload.title)"
      artist=$(echo "$line" | jq -r .payload.artist)
      album=$(echo "$line" | jq -r .payload.album)

      subtitle_label="$artist"
      if [[ -n "$album" ]]; then
        subtitle_label+=" • $album"
      fi

      sketchybar --set $NAME.title label="$title_label" \
                  --set $NAME.subtitle label="$subtitle_label"
    fi

    # Set Playing state indicator

    if [[ $playing != "null" && $(echo $line | jq -r .diff) == "true" ]];then
      case $playing in
        "true") sketchybar --set $NAME icon.padding_left=-3 \
                            --animate tanh 5 \
                            --set $NAME icon="􀊆" \
                                        icon.drawing=on 
        {
          sleep 5
          sketchybar --animate tanh 45 --set $NAME icon.drawing=false
        } &
        ;;
        "false") sketchybar --set $NAME icon.padding_left=0 \
                            --animate tanh 5 \
                            --set $NAME icon="􀊄" \
                                        icon.drawing=on 
        {
          sleep 5
          sketchybar --animate tanh 45 --set $NAME icon.drawing=false
        } &
        ;;
      esac
    fi

    if [[ $currentPID != "null" ]];then
      lastAppPID=$currentPID
    fi

    sketchybar --set $NAME drawing=on \
                --set $NAME.title drawing=on \
                --set $NAME.subtitle drawing=on \
                --trigger activities_update


  else

    sketchybar --set $NAME drawing=off \
              --set $NAME.title drawing=off \
              --set $NAME.subtitle drawing=off \
              --trigger activities_update

    lastAppPID=""
  fi

done