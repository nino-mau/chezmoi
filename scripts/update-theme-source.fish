#!/usr/bin/env fish

set -l source_root (chezmoi source-path); or exit 1
set -l themes \
    "$HOME/.config/eza/theme.yml" "dot_config/eza/theme.yml" \
    "$HOME/.config/fzf/fzfrc" "dot_config/fzf/fzfrc" \
    "$HOME/.config/lazygit/theme.yml" "dot_config/lazygit/theme.yml"

for index in (seq 1 2 (count $themes))
    set -l live_path $themes[$index]

    test -f "$live_path"; or begin
        echo "Missing theme: $live_path" >&2
        exit 1
    end
end

for index in (seq 1 2 (count $themes))
    set -l destination_index (math $index + 1)
    set -l live_path $themes[$index]
    set -l source_path "$source_root/$themes[$destination_index]"

    mkdir -p (path dirname "$source_path"); or exit 1
    cp -- "$live_path" "$source_path"; or exit 1
end

echo "Theme sources updated."
