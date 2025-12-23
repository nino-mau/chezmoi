#!/usr/bin/env bash
# Chezmoi hook: deploy system configs after update
# Only runs if earlyoom or keyd configs changed

set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# Check if relevant configs exist and might need deployment
needs_deploy=false

if [[ -f "$CONFIG_DIR/earlyoom/earlyoom" ]]; then
    if ! diff -q "$CONFIG_DIR/earlyoom/earlyoom" /etc/default/earlyoom &>/dev/null; then
        needs_deploy=true
    fi
fi

if [[ -d "$CONFIG_DIR/keyd" ]]; then
    for f in "$CONFIG_DIR/keyd"/*.conf; do
        [[ -f "$f" ]] || continue
        dest="/etc/keyd/$(basename "$f")"
        if ! diff -q "$f" "$dest" &>/dev/null; then
            needs_deploy=true
            break
        fi
    done
fi

if $needs_deploy; then
    echo "System configs changed, deploying to /etc..."
    if command -v deploy-system-configs &>/dev/null; then
        deploy-system-configs --reload
    else
        echo "deploy-system-configs not found in PATH"
        exit 1
    fi
else
    echo "System configs unchanged, skipping deployment."
fi
