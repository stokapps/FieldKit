#!/usr/bin/env bash
#
# Package a skill directory into a distributable .zip.
#
# claude.ai and the Claude API accept skills as a zip archive that contains the
# skill folder (with SKILL.md inside it). This produces exactly that.
#
# Usage:
#   scripts/package-skill.sh skills/conventional-commits          # -> dist/conventional-commits.zip
#   scripts/package-skill.sh skills/conventional-commits build    # -> build/conventional-commits.zip
#
# Requires: zip
set -euo pipefail

SKILL_DIR="${1:-}"
OUT_DIR="${2:-dist}"

if [[ -z "$SKILL_DIR" ]]; then
  echo "Usage: $0 <path/to/skill-dir> [output-dir]" >&2
  exit 1
fi

# Normalize a possible trailing slash.
SKILL_DIR="${SKILL_DIR%/}"

if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
  echo "Error: '$SKILL_DIR/SKILL.md' not found. Point this at a skill directory." >&2
  exit 1
fi

if ! command -v zip >/dev/null 2>&1; then
  echo "Error: 'zip' is not installed. Install it and try again." >&2
  exit 1
fi

NAME="$(basename "$SKILL_DIR")"
PARENT="$(dirname "$SKILL_DIR")"

mkdir -p "$OUT_DIR"
OUT_ZIP="$(cd "$OUT_DIR" && pwd)/$NAME.zip"
rm -f "$OUT_ZIP"

# Zip from the parent directory so the archive contains "<name>/SKILL.md",
# excluding common junk files.
(
  cd "$PARENT"
  zip -r -q "$OUT_ZIP" "$NAME" \
    -x "*/.DS_Store" \
    -x "*/__pycache__/*" \
    -x "*.pyc"
)

echo "Packaged '$SKILL_DIR' -> '$OUT_ZIP'"
