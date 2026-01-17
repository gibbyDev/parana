#!/usr/bin/env bash

current_workspace=$(hyprctl monitors | grep "active workspace" | awk '{print $NF}')
if [ "$1" == "up" ]; then
  new_workspace=$((current_workspace + 1))
elif [ "$1" == "down" ]; then
  new_workspace=$((current_workspace - 1))
fi
hyprctl dispatch workspace "$new_workspace"