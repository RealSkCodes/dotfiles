#!/usr/bin/env bash
set -e

DOTDIR="$HOME/dotfiles"

# 1. Cherry-pick entire directories
# Format: "source_path:destination_relative_to_dotdir"
SYNC_DIRS=(
    # --- .config folders ---
    "$HOME/.config/hypr:.config/hypr"
    "$HOME/.config/waybar:.config/waybar"
    "$HOME/.config/swaync:.config/swaync"
    "$HOME/.config/kitty:.config/kitty"
    "$HOME/.config/fastfetch:.config/fastfetch"
    "$HOME/.config/fish:.config/fish"

    # --- .local folders ---
    "$HOME/.local/share/fonts/JetBrainsMono:.local/share/fonts/JetBrainsMono"
)

# 2. Cherry-pick single files
SYNC_FILES=(
    # --- .config individual files ---
    "$HOME/.config/Code/User/settings.json:.config/Code/User/settings.json"
    "$HOME/.config/electron-flags.conf:.config/electron-flags.conf"
    "$HOME/.config/mimeapps.list:.config/mimeapps.list"
    "$HOME/.config/starship.toml:.config/starship.toml"

    # --- Home individual files ---
    "$HOME/.bashrc:.bashrc"
    "$HOME/.nanorc:.nanorc"
)

echo "Starting dotfiles sync..."

# Sync directories
for entry in "${SYNC_DIRS[@]}"; do
    SRC="${entry%%:*}"
    DEST="$DOTDIR/${entry##*:}"

    if [ -d "$SRC" ]; then
        mkdir -p "$DEST"
        rsync -av --delete "$SRC/" "$DEST/"
    fi
done

# Sync individual files
for entry in "${SYNC_FILES[@]}"; do
    SRC="${entry%%:*}"
    DEST="$DOTDIR/${entry##*:}"

    if [ -f "$SRC" ]; then
        mkdir -p "$(dirname "$DEST")"
        cp "$SRC" "$DEST"
    fi
done

cd "$DOTDIR"

# Check if there are changes
if [ -z "$(git status --porcelain)" ]; then
    echo "Everything is already up to date. Nothing to push."
    exit 0
fi

# Commit and push
git add .
MSG="${1:-Update dotfiles: $(date '+%Y-%m-%d %H:%M')}"
git commit -m "$MSG"
git push origin main

echo "Dotfiles successfully synced to GitHub!"