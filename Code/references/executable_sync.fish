#!/usr/bin/env fish

set -l root (path resolve (path dirname (status filename)))
set -l manifest "$root/repos.yml"
set -l tab (printf '\t')
set -l cloned 0
set -l updated 0
set -l skipped 0
set -l failed 0

function usage
    echo "Usage: sync.fish [--diff]"
end

if test (count $argv) -gt 1
    usage >&2
    exit 2
end

if not command -q yq
    echo "Missing dependency: yq" >&2
    exit 1
end

if not test -f "$manifest"
    echo "Missing manifest: $manifest" >&2
    exit 1
end

if not yq -e '.repos | tag == "!!map"' "$manifest" >/dev/null
    echo "Invalid manifest: repos must be a mapping" >&2
    exit 1
end

switch "$argv[1]"
    case -h --help
        usage
        exit
    case -d --diff
        set -l manifest_paths (mktemp)
        set -l current_paths (mktemp)

        yq -r '.repos | .. | select(tag == "!!str") | path | .[1:] | join("/")' "$manifest" |
            sort -u >"$manifest_paths"
        find "$root" -mindepth 2 -name .git -print -prune |
            while read -l git_path
                string replace "$root/" '' (path dirname "$git_path")
            end | sort -u >"$current_paths"

        diff -u --label repos.yml --label current "$manifest_paths" "$current_paths"
        set -l diff_status $status
        rm -f "$manifest_paths" "$current_paths"

        if test $diff_status -eq 0
            echo "No differences."
        end

        exit $diff_status
    case ''
    case '*'
        usage >&2
        exit 2
end

set -l entries (mktemp)
if not yq -r '.repos | .. | select(tag == "!!str") | [(path | .[1:] | join("/")), .] | @tsv' "$manifest" >"$entries"
    echo "Failed to read manifest: $manifest" >&2
    rm -f "$entries"
    exit 1
end

while read -l line
    set -l fields (string split -m 1 "$tab" -- "$line")
    if test (count $fields) -ne 2
        echo "Invalid manifest entry: $line" >&2
        set failed (math $failed + 1)
        continue
    end

    set -l relative_path (string trim -- "$fields[1]")
    set -l url (string trim -- "$fields[2]")

    if test -z "$relative_path"; or test -z "$url"
        echo "Invalid manifest entry: $line" >&2
        set failed (math $failed + 1)
        continue
    end

    if string match -qr '(^/|(^|/)\.\.(/|$))' -- "$relative_path"
        echo "Unsafe repository path: $relative_path" >&2
        set failed (math $failed + 1)
        continue
    end

    set -l target "$root/$relative_path"

    if not test -e "$target"
        echo "Cloning $relative_path"
        mkdir -p (path dirname "$target")
        if git clone -- "$url" "$target"
            set cloned (math $cloned + 1)
        else
            set failed (math $failed + 1)
        end
        continue
    end

    if not git -C "$target" rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "Skipping $relative_path: path exists but is not a Git repository" >&2
        set skipped (math $skipped + 1)
        continue
    end

    set -l origin (git -C "$target" remote get-url origin 2>/dev/null)
    if test "$origin" != "$url"
        echo "Skipping $relative_path: origin differs" >&2
        echo "  manifest: $url" >&2
        echo "  current:  $origin" >&2
        set skipped (math $skipped + 1)
        continue
    end

    echo "Fetching $relative_path"
    if not git -C "$target" fetch --prune origin
        set failed (math $failed + 1)
        continue
    end

    if test -n "$(git -C "$target" status --porcelain)"
        echo "Skipping update for $relative_path: working tree is dirty" >&2
        set skipped (math $skipped + 1)
        continue
    end

    if not git -C "$target" symbolic-ref --quiet HEAD >/dev/null
        echo "Skipping update for $relative_path: detached HEAD" >&2
        set skipped (math $skipped + 1)
        continue
    end

    if not git -C "$target" rev-parse --abbrev-ref '@{upstream}' >/dev/null 2>&1
        echo "Skipping update for $relative_path: branch has no upstream" >&2
        set skipped (math $skipped + 1)
        continue
    end

    if git -C "$target" merge --ff-only '@{upstream}'
        set updated (math $updated + 1)
    else
        set failed (math $failed + 1)
    end
end <"$entries"

rm -f "$entries"

echo
echo "Cloned: $cloned, updated: $updated, skipped: $skipped, failed: $failed"
test $failed -eq 0
