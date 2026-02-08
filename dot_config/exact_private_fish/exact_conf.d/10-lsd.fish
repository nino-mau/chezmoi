# lsd (ls replacement)

alias ls="lsd -t --reverse"
abbr -a lss "lsd -l -t --reverse --blocks=name"
abbr -a lsp "lsd --blocks=user,group,permission,name"
abbr -a lsl "lsd -latr --blocks=date,user,group,permission,name"
