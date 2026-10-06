#!/bin/bash
WP_PATH="$1"

# Set wallpaper
swww img "$WP_PATH" --transition-type simple

# Generate colors via matugen
matugen image "$WP_PATH"

# Reload waybar to apply new css
killall waybar
waybar &
