function lcm --description "Stage all, commit and push"
    # Check if in git repo
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "Error: Not a git repository" >&2
        return 1
    end

    # Check for changes
    if test -z (git status --porcelain 2>/dev/null)
        echo "Nothing to commit, working tree clean"
        return 0
    end

    git add -A
    git commit -am (test -n "$argv" && echo "$argv" || echo "update")
    git push
end
