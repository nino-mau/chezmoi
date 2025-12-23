function dirdiff
    if count $argv != 2
        echo "Usage: filetree_diff <repo1> <repo2>"
        return 1
    end

    set repo1 $argv[1]
    set repo2 $argv[2]

    diff -y --color=always \
        (cd $repo1; git ls-files -co --exclude-standard | sort | psub) \
        (cd $repo2; git ls-files -co --exclude-standard | sort | psub) \
        | bat --paging=always --wrap=never
end
