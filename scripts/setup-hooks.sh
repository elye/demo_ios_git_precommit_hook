#!/bin/sh
# This script installs the pre-commit hook for the project

HOOK_SRC="$(dirname "$0")/pre-commit"
HOOK_DEST="$(git rev-parse --show-toplevel)/.git/hooks/pre-commit"

if [ ! -f "$HOOK_SRC" ]; then
  echo "Error: pre-commit script not found at $HOOK_SRC"
  exit 1
fi

cp "$HOOK_SRC" "$HOOK_DEST"
chmod +x "$HOOK_DEST"
echo "pre-commit hook installed to $HOOK_DEST"
