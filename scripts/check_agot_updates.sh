#!/usr/bin/env bash
# check_agot_updates.sh — Check for AGOT mod updates from r/CK3AGOT
#
# Fetches the latest [Release] posts from Reddit and shows changelogs.
#
# Usage:
#   ./scripts/check_agot_updates.sh              # Show latest releases
#   ./scripts/check_agot_updates.sh --changelog   # Show full changelog body
#   ./scripts/check_agot_updates.sh --check        # Compare with installed version
#
# Source: https://www.reddit.com/r/CK3AGOT/

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
REDDIT_URL="https://old.reddit.com/r/CK3AGOT/search.json?q=%5BRelease%5D+flair%3AOfficial&restrict_sr=on&sort=new&limit=5&t=year"
UA="claudaser-ck3-skill/1.0"
MODE="${1:---brief}"

# Fetch JSON from Reddit
TMPFILE=$(mktemp)
trap "rm -f $TMPFILE" EXIT

echo "Fetching latest AGOT releases from r/CK3AGOT..."
echo ""

curl -s -L -H "User-Agent: $UA" "$REDDIT_URL" > "$TMPFILE" 2>/dev/null

if [ ! -s "$TMPFILE" ]; then
    echo "Error: Could not fetch from Reddit."
    exit 1
fi

# Use PowerShell to parse (available on all Windows installs)
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$SCRIPT_DIR/parse_reddit.ps1" -JsonPath "$(cygpath -w "$TMPFILE")" -Mode "$MODE" -SkillDir "$(cygpath -w "$SKILL_DIR")"
