#!/bin/bash

pagesize=$(sysctl -n hw.pagesize)
vm_stat_output=$(vm_stat)

get_pages() {
    echo "$vm_stat_output" | awk "/$1/ {print \$NF}" | sed 's/\.//'
}

active=$(get_pages "Pages active")
wired=$(get_pages "Pages wired down")

used_pages=$((active + wired))
used_mem=$((used_pages * pagesize))
total_mem=$(sysctl -n hw.memsize)

usage=$(awk "BEGIN {printf \"%.0f\", 100 * $used_mem / $total_mem}")

sketchybar --set $NAME label="${usage}%"
