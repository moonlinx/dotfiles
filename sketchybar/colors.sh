#!/bin/bash

# set -x

# https://material-theme.com/docs/reference/color-palette/

#!/bin/bash

getcolor() {

  color_name=$1
  opacity=$2

  local o100=0xff
  local o75=0xbf
  local o60=0xac
  local o50=0x80
  local o25=0x40
  local o10=0x1a
  local o0=0x00

  #Vuesion
  local teal=#d80f8f
  local cyan=#33cccc
  local blue=#446e9d
  local grey=#565f89
  local green=#9ece6a
  local hgreen=#a4d8ba
  local yellow=#e0af68
  local orange=#ff9e64
  local red=#f7768e
  local purple=#bb9af7
  local black=#3b585d
  local trueblack=#000000
  local white=#cfc9c2
  local dark_green=#00ca00
  local solo=#c8d9e5
  local leveling=#4c1a6f

  case $opacity in
  75) local opacity=$o75 ;;
  60) local opacity=$o60 ;;
  50) local opacity=$o50 ;;
  25) local opacity=$o25 ;;
  10) local opacity=$o10 ;;
  0) local opacity=$o0 ;;
  *) local opacity=$o100 ;;
  esac

  case $color_name in
  blue) local color=$blue ;;
  hgreen) local color=$hgreen ;;
  teal) local color=$teal ;;
  cyan) local color=$cyan ;;
  grey) local color=$grey ;;
  green) local color=$green ;;
  yellow) local color=$yellow ;;
  orange) local color=$orange ;;
  red) local color=$red ;;
  purple) local color=$purple ;;
  black) local color=$black ;;
  trueblack) local color=$trueblack ;;
  white) local color=$white ;;
  dark_green) local color=$dark_green ;; # Added DARK_GREEN case
  solo) local color=$solo ;;
  leveling) local color=$leveling ;;
  *)
    echo "Invalid color name: $color_name" >&2
    return 1
    ;;
  esac

  echo $opacity${color:1}
}

# Pick color based on day of week
daily_color() {
  DAY_OF_WEEK=$(date +%u)
  local COLORS=("blue" "teal" "cyan" "green" "yellow" "orange" "red" "purple")
  echo ${COLORS[$DAY_OF_WEEK]}
}

# Pick a random color name
RANDOMHIGHLIGHT=hgreen

# Bar and item colors
export BAR_COLOR=$(getcolor trueblack 60)
export BAR_BORDER_COLOR=$(getcolor black 50)
export HIGHLIGHT=$(getcolor $RANDOMHIGHLIGHT)
export HIGHLIGHT_75=$(getcolor $RANDOMHIGHLIGHT 75)
export HIGHLIGHT_50=$(getcolor $RANDOMHIGHLIGHT 50)
export HIGHLIGHT_25=$(getcolor $RANDOMHIGHLIGHT 25)
export HIGHLIGHT_10=$(getcolor $RANDOMHIGHLIGHT 10)
export ICON_COLOR=$(getcolor white)
export ICON_COLOR_INACTIVE=$(getcolor white 50)
export LABEL_COLOR=$(getcolor white 75)
export POPUP_BACKGROUND_COLOR=$(getcolor black 25)
export POPUP_BORDER_COLOR=$(getcolor black 0)
export SHADOW_COLOR=$(getcolor black)
export TRANSPARENT=$(getcolor black 0)
