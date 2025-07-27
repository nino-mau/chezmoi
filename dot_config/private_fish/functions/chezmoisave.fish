function chezmoisave
    set -l chezdir (chezmoi source-path)
    if test -d "$chezdir"
        cd $chezdir

        git add -A

        if git diff --cached --quiet
            echo "✅ No changes to commit."
        else
            set -l msg "chore: auto commit on (date '+%Y-%m-%d %H:%M:%S')"
            git commit -m $msg
            git push origin HEAD
            echo "✅ Changes committed and pushed."
        end
    else
        echo "❌ chezmoi source directory not found."
    end
end
