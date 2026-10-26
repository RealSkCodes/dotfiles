#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_FILE="$HOME/.cache/hyprquickpaper/current_wallpaper"
LOCK_CONFIG="$HOME/.config/hypr/hyprlock.conf"
TEMP_CONFIG="$HOME/.cache/hyprlock-current.conf"

WALLPAPER="$(< "$WALLPAPER_FILE")"

if [[ ! -f "$WALLPAPER" ]]; then
    notify-send "Hyprlock" "Current wallpaper not found: $WALLPAPER"
    exit 1
fi

# Replace only the wallpaper path in a temporary copy.
sed "s|^    path = .*|    path = $WALLPAPER|" \
    "$LOCK_CONFIG" > "$TEMP_CONFIG"

exec hyprlock --config "$TEMP_CONFIG"