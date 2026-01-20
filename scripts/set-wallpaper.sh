#!/usr/bin/env bash
set -euo pipefail

# ======================
# Configuration
# ======================

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
INDEX_FILE="/tmp/current_wallpaper_index"

# ======================
# Load wallpapers
# ======================

mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( \
    -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.webp' \
\) | sort)

TOTAL_WALLPAPERS="${#WALLPAPERS[@]}"

if [[ "$TOTAL_WALLPAPERS" -eq 0 ]]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# ======================
# Load current index
# ======================

if [[ -f "$INDEX_FILE" ]]; then
    CURRENT_INDEX="$(<"$INDEX_FILE")"
else
    CURRENT_INDEX=0
fi

# ======================
# KDE Plasma wallpaper setter
# ======================

set_kde_wallpaper() {
    local wallpaper="$1"

    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
        var desktops = desktops();
        for (var i = 0; i < desktops.length; i++) {
            var d = desktops[i];
            d.wallpaperPlugin = 'org.kde.image';
            d.currentConfigGroup = ['Wallpaper', 'org.kde.image', 'General'];
            d.writeConfig('Image', 'file://$wallpaper');
        }
    "
}

# ======================
# Apply wallpaper + colors
# ======================

apply_wallpaper() {
    local wallpaper="${WALLPAPERS[$CURRENT_INDEX]}"
    echo "Setting wallpaper: $wallpaper"

    # KDE wallpaper
    set_kde_wallpaper "$wallpaper"

    # Generate pywal colors (no GTK reload)
    wal -i "$wallpaper" --backend wal -n

    # Neovim colors
    if [[ -f "$HOME/.cache/wal/colors-wal.vim" ]]; then
        cp "$HOME/.cache/wal/colors-wal.vim" \
           "$HOME/.config/nvim/colors-wal.vim"
    fi

    # Reload Neovim if running
    if pgrep -x nvim >/dev/null; then
        nvim --server /tmp/nvim.pipe \
             --remote-send '<Esc>:source $HOME/.cache/wal/colors-wal.vim<CR>' \
             || true
    fi
}

# ======================
# Navigation
# ======================

next_wallpaper() {
    CURRENT_INDEX=$(( (CURRENT_INDEX + 1) % TOTAL_WALLPAPERS ))
    echo "$CURRENT_INDEX" > "$INDEX_FILE"
    apply_wallpaper
}

prev_wallpaper() {
    CURRENT_INDEX=$(( (CURRENT_INDEX - 1 + TOTAL_WALLPAPERS) % TOTAL_WALLPAPERS ))
    echo "$CURRENT_INDEX" > "$INDEX_FILE"
    apply_wallpaper
}

# ======================
# Entry point
# ======================

case "${1:-}" in
    next)
        next_wallpaper
        ;;
    prev)
        prev_wallpaper
        ;;
    *)
        echo "Usage: $0 {next|prev}"
        exit 1
        ;;
esac

