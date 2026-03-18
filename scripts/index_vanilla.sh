#!/bin/bash
# index_vanilla.sh — Index vanilla CK3 game files
# Usage: ./scripts/index_vanilla.sh /path/to/CK3/game
#
# Lists all .txt, .gui, .gfx, and .asset files grouped by top-level folder.
# Shows relative path, size (human-readable), and line count.

set -euo pipefail

if [ $# -lt 1 ]; then
    echo "Usage: $0 /path/to/CK3/game"
    echo ""
    echo "Lists all moddable files in the CK3 game folder, grouped by top-level folder."
    echo "Shows relative path, file size, and line count."
    exit 1
fi

GAME_PATH="$1"

if [ ! -d "$GAME_PATH" ]; then
    echo "Error: '$GAME_PATH' is not a valid directory."
    echo "Expected the CK3 game/ folder (containing common/, events/, etc.)"
    exit 1
fi

# Verify it looks like a CK3 game folder
if [ ! -d "$GAME_PATH/common" ] || [ ! -d "$GAME_PATH/events" ]; then
    echo "Warning: '$GAME_PATH' doesn't look like a CK3 game/ folder."
    echo "Expected to find common/ and events/ subfolders."
    echo "Continuing anyway..."
    echo ""
fi

echo "=== CK3 Vanilla File Index ==="
echo "Game path: $GAME_PATH"
echo ""

# Get unique top-level folders that contain target files
find "$GAME_PATH" -maxdepth 1 -mindepth 1 -type d | sort | while read -r dir; do
    folder_name=$(basename "$dir")

    # Count files of each type
    file_count=$(find "$dir" -type f \( -name "*.txt" -o -name "*.gui" -o -name "*.gfx" -o -name "*.asset" \) 2>/dev/null | wc -l)

    if [ "$file_count" -gt 0 ]; then
        echo "--- $folder_name/ ($file_count files) ---"
        find "$dir" -type f \( -name "*.txt" -o -name "*.gui" -o -name "*.gfx" -o -name "*.asset" \) 2>/dev/null | sort | while read -r file; do
            rel_path="${file#$GAME_PATH/}"
            size=$(du -h "$file" 2>/dev/null | cut -f1)
            lines=$(wc -l < "$file" 2>/dev/null || echo "?")
            printf "  %-60s %8s %6s lines\n" "$rel_path" "$size" "$lines"
        done
        echo ""
    fi
done

echo "=== Done ==="
