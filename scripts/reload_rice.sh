#!/usr/bin/env bash

yabai --restart-service
sleep 1
skhd --restart-service
sleep 1
brew services restart sketchybar
sleep 1
brew services restart borders
