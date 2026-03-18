function gh-starred -d 'Fuzzy search your starred GitHub repositories'
    set jq_filter '.[] | [.full_name, (.description // "No description"), .html_url] | @tsv'

    gh api user/starred --paginate --jq "$jq_filter" \
    | fzf --delimiter='\t' \
          --with-nth=1 \
          --preview 'printf "%s\n" {2}' \
          --preview-window=right:50%:wrap \
          --bind 'enter:become(xdg-open {3})'
end
