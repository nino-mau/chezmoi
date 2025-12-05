function syncwatch --description 'Watch a directory and rsync on changes'
    if test (count $argv) -ne 2
        echo "Usage: syncwatch <source> <destination>"
        return 1
    end
    set src $argv[1]
    set dst $argv[2]
    # initial sync
    rsync -avu --delete $src/ $dst/
    fswatch -o $src \
        | xargs -n1 -I{} rsync -avu --delete $src/ $dst/
end
