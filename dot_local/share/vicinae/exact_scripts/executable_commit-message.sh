#!/usr/bin/env bash
# @vicinae.schemaVersion 1
# @vicinae.title Commit Message
# @vicinae.description Insert conventional commit template
# @vicinae.mode silent
# @vicinae.icon https://api.iconify.design/carbon/letter-cc.svg?color=%23ccd5f3
selection="$(
  printf '%s\n' \
    '✨ feat: ' \
    '🐛 fix: ' \
    '📚 docs: ' \
    '🎨 style: ' \
    '🛠️ refactor: ' \
    '🚀 perf: ' \
    '🚨 test: ' \
    '📦 build: ' \
    '⚙️ ci: ' \
    '🔧 chore: ' \
    '🗑 revert: ' \
    '🎉 Initialization' |
    vicinae dmenu \
      --navigation-title "Commit Messages" \
      --placeholder "Search commit template"
)"
[ -n "$selection" ] && wtype "$selection"
