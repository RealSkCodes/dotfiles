
#!/usr/bin/env bash

WALLPAPER_FILE="$HOME/.cache/hyprquickpaper/current_wallpaper"

# Start hyprpaper if it isn't running
if ! pgrep -x hyprpaper >/dev/null; then
    hyprpaper &
fi

# Wait for hyprpaper's IPC interface to become available
for _ in {1..50}; do
    if hyprctl hyprpaper listactive >/dev/null 2>&1; then
        break
    fi
    sleep 0.2
done

# Read the last selected wallpaper
if [[ ! -r "$WALLPAPER_FILE" ]]; then
    exit 0
fi

WALLPAPER="$(<"$WALLPAPER_FILE")"

# Don't apply a missing or empty path
if [[ -z "$WALLPAPER" || ! -f "$WALLPAPER" ]]; then
    exit 0
fi

# Preload and restore the wallpaper
hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ",$WALLPAPER"
