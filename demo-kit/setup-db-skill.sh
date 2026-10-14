#!/usr/bin/env bash
# Installs the postgresql-table-design skill into ./.claude/skills/ of the current project.
# Run from your project folder:   bash setup-db-skill.sh
#
# A skill is a FOLDER, not just a file: this one ships a references/ folder next to
# SKILL.md, so this downloads the complete folder.
set -euo pipefail

command -v git >/dev/null || { echo "git is not installed. macOS: run  xcode-select --install   WSL/Ubuntu: sudo apt install git"; exit 1; }

DEST=".claude/skills"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
mkdir -p "$DEST"

REPO=wshobson/agents
SRC=plugins/database-design/skills/postgresql-table-design
NAME=postgresql-table-design

echo "→ $NAME  ($REPO/$SRC)"
# Download only the skill's folder (plain clone + path checkout works on old and new git alike)
git clone --quiet --depth 1 --filter=blob:none --no-checkout "https://github.com/$REPO.git" "$TMP/repo"
git -C "$TMP/repo" checkout --quiet HEAD -- "$SRC"
rm -rf "$DEST/$NAME"
cp -R "$TMP/repo/$SRC" "$DEST/$NAME"
test -f "$DEST/$NAME/SKILL.md" || { echo "   ✗ SKILL.md missing for $NAME"; exit 1; }

printf '  ✓ %-28s %s files\n' "$NAME" "$(find "$DEST/$NAME" -type f | wc -l | tr -d ' ')"
echo
echo "Now start Claude Code in this folder and run /skills to confirm it loaded."
