#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if ! command -v bun &>/dev/null; then
  echo "Error: bun is not installed"
  echo "Install with: curl -fsSL https://bun.sh/install | bash"
  exit 1
fi

echo "Generating catppuccin_mocha.json..."
bun run generator.ts >catppuccin_mocha.json

echo "✓ Generated catppuccin_mocha.json"
