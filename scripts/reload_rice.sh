#!/bin/bash

# An Update to the bash script to reload my entire system for the most part
# Added a few things that I learned from my project at work like
# Functions, Calling functiosn, esac, values, etc

# Function to restart yabai
restart_yabai() {
  echo "Restarting yabai..."
  yabai --restart-service
  sleep 1
}

# Function to restart skhd
restart_skhd() {
  echo "Restarting skhd..."
  skhd --restart-service
  sleep 1
}

# Function to restart sketchybar
restart_sketchybar() {
  echo "Restarting sketchybar..."
  brew services restart sketchybar
  sleep 1
}

# Function to restart borders
restart_borders() {
  echo "Restarting borders..."
  brew services restart borders
}

# Function to restart all services
restart_all() {
  restart_yabai
  restart_skhd
  restart_sketchybar
  restart_borders
  echo "All services restarted successfully!"
}

# Function to display the menu and get user selection
show_menu() {
  clear
  echo "╭───────────────────────────────────╮"
  echo "│       Rice Reloader Menu          │"
  echo "╰───────────────────────────────────╯"
  echo "1) Restart Yabai"
  echo "2) Restart SKHD"
  echo "3) Restart Sketchybar"
  echo "4) Restart Borders"
  echo "5) Restart All Services"
  echo "0) Exit"
  echo
  echo -n "Please enter your choice [0-5]: "
}

# Check if command line argument was provided
if [ $# -eq 0 ]; then
  # No arguments provided, show interactive menu
  while true; do
    show_menu
    read choice

    case $choice in
    1)
      restart_yabai
      echo -e "\nPress Enter to continue..."
      read
      ;;
    2)
      restart_skhd
      echo -e "\nPress Enter to continue..."
      read
      ;;
    3)
      restart_sketchybar
      echo -e "\nPress Enter to continue..."
      read
      ;;
    4)
      restart_borders
      echo -e "\nPress Enter to continue..."
      read
      ;;
    5)
      restart_all
      echo -e "\nPress Enter to continue..."
      read
      ;;
    0)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid option. Press Enter to try again..."
      read
      ;;
    esac
  done
else
  # Command line argument provided, use the original behavior
  case "$1" in
  "yabai") restart_yabai ;;
  "skhd") restart_skhd ;;
  "sketchybar") restart_sketchybar ;;
  "borders") restart_borders ;;
  "all") restart_all ;;
  *)
    echo "Usage: $0 {yabai|skhd|sketchybar|borders|all}"
    echo "Or run without arguments for interactive menu."
    ;;
  esac
fi
