function lg --description "Live ripgrep search with fzf + bat preview + open in nvim"
    fzf --bind "change:reload:rg --line-number --color=always {q} || true" \
        --ansi --disabled \
        --preview "bat --style=numbers --color=always --line-range :200 {1}" \
        --delimiter ":" \
        --bind "enter:become(nvim {1} +{2})"
end
