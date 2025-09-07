function chezmoisave
    set -l chezdir (chezmoi source-path)
    set -l machine (hostname)

    chezmoi add --recursive ~/.config/ghostty
    chezmoi add --recursive ~/.config/fish
    chezmoi add --recursive ~/.config/lsd
    chezmoi add --recursive ~/.config/tmux/tmux.conf
    chezmoi add --recursive ~/.config/fastfetch
    chezmoi add --recursive ~/Documents/dev/scripts

    if test -d "$chezdir"
        cd $chezdir

        git add -A

        if git diff --cached --quiet
            echo "✅ No changes to commit."
        else
            set -l msg "chore: auto commit on (date '+%Y-%m-%d %H:%M:%S') from $machine"
            git commit -m $msg
            git push origin HEAD
            echo "✅ Changes committed and pushed."
        end
    else
        echo "❌ chezmoi source directory not found."
    end
end
