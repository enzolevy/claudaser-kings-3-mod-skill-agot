#!/bin/bash
# find_examples.sh — Search for examples of a term in vanilla CK3 files
# Usage: ./scripts/find_examples.sh /path/to/CK3/game "search_term" [max_results]
#
# Searches .txt files for the given term with 3 lines of context.
# Default: 20 results. Pass a third argument to change.

set -euo pipefail

if [ $# -lt 2 ]; then
    echo "Usage: $0 /path/to/CK3/game \"search_term\" [max_results]"
    echo ""
    echo "Searches vanilla CK3 .txt files for the given term."
    echo "Shows each match with 3 lines of context before and after."
    echo ""
    echo "Examples:"
    echo "  $0 /path/to/game \"add_trait\"        # Search for add_trait"
    echo "  $0 /path/to/game \"on_death\" 50      # Show up to 50 results"
    exit 1
fi

GAME_PATH="$1"
SEARCH_TERM="$2"
MAX_RESULTS="${3:-20}"

if [ ! -d "$GAME_PATH" ]; then
    echo "Error: '$GAME_PATH' is not a valid directory."
    exit 1
fi

echo "=== Searching for '$SEARCH_TERM' in $GAME_PATH ==="
echo "Max results: $MAX_RESULTS"
echo ""

grep -rn "$SEARCH_TERM" "$GAME_PATH" \
    --include="*.txt" \
    -B 3 -A 3 \
    -m "$MAX_RESULTS" \
    2>/dev/null || echo "No results found for '$SEARCH_TERM'."

echo ""
echo "=== Done ==="
