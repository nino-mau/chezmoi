function chezmoisave
    # Re-add all managed files to capture changes
    echo "📝 Re-adding all managed files..."
    chezmoi re-add

    # Stage all changes
    chezmoi git -- add -A

    # Check if there are changes to commit
    if chezmoi git -- diff --cached --quiet
        echo "✅ No changes to commit."
    else
        # Create commit with timestamp and hostname
        set -l timestamp (date '+%Y-%m-%d %H:%M:%S')
        set -l machine (hostname)
        chezmoi git -- commit -m "chore: auto commit on $timestamp from $machine"
        and chezmoi git -- push
        and echo "✅ Changes committed and pushed."
        or echo "❌ Failed to push changes."
    end
end
