#!/bin/bash

volume=(
    script="$PLUGIN_DIR/volume.sh"
)

sketchybar --add item volume right \
    --set volume "${volume[@]}" \
    --subscribe volume volume_change mouse.clicked
