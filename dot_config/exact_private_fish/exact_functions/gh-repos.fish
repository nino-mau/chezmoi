function gh-repos -d 'Search GitHub repositories with fzf'
    if test (count $argv) -eq 0
        printf 'Usage: gh-repos <search terms>\n'
        printf 'Example: gh-repos neovim plugin\n'
        return 1
    end

    set query (string join ' ' $argv)
    set json_fields fullName,description,url,stargazersCount,language,updatedAt
    set jq_filter '.[] | [.fullName, (.description // "No description"), .url, (.stargazersCount | tostring), (.language // "Unknown"), .updatedAt] | @tsv'

    gh search repos "$query" --limit 100 --json "$json_fields" --jq "$jq_filter" \
    | fzf --delimiter='\t' \
          --with-nth=1 \
          --preview 'printf "Description: %s\n\nStars: %s\nLanguage: %s\nUpdated: %s\nURL: %s\n" {2} {4} {5} {6} {3}' \
          --preview-window=right:50%:wrap \
          --prompt "repos> " \
          --header "Search: $query" \
          --bind 'enter:become(xdg-open {3})'
end
