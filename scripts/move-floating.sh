#!/usr/bin/env bash

# Move floating window or fallback to tiling move
direction=$1
amount=$2

if hyprctl activewindow -j | jq -r .floating | grep -q true; then
  hyprctl dispatch moveactive "$direction" "$amount"
else
  hyprctl dispatch movewindow "$direction"
fi

