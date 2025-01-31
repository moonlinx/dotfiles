#!/bin/bash
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/globalstyles.sh"

render_item() {
  PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
  CHARGING=$(pmset -g batt | grep 'AC Power')

  if [ $PERCENTAGE = "" ]; then
    exit 0
  fi

  # Define colors using getcolor function
  DARK_GREEN=$(getcolor dark_green)
  YELLOW=$(getcolor yellow)
  RED=$(getcolor red)
  WHITE=$(getcolor white)

  # Set icon based on battery level
  if [ $PERCENTAGE -ge 90 ]; then
    ICON="􀛨"
  elif [ $PERCENTAGE -ge 60 ]; then
    ICON="􀺸"
  elif [ $PERCENTAGE -ge 30 ]; then
    ICON="􀺶"
  elif [ $PERCENTAGE -ge 20 ]; then
    ICON="􀛩"
  else
    ICON="􀛪"
  fi

  # Set color based on battery level and charging status
  if [[ $CHARGING != "" ]]; then
    ICON="􀢋"
    if [ $PERCENTAGE -ge 30 ]; then
      COLOR=$DARK_GREEN
    else
      COLOR=$YELLOW
    fi
  else
    if [ $PERCENTAGE -ge 30 ]; then
      COLOR=$WHITE
    elif [ $PERCENTAGE -ge 20 ]; then
      COLOR=$YELLOW
    else
      COLOR=$RED
    fi
  fi

  # Update sketchybar
  sketchybar --set $NAME icon=$ICON \
                        icon.color=$COLOR \
                        label="${PERCENTAGE}%" \
                        label.drawing=on 
}

case "$SENDER" in
  "mouse.clicked")
    # Do nothing on click, as we always want to show the percentage
    ;;
  "routine"|"forced"|"power_source_change")
    render_item
    ;;
esac