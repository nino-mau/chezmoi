# Custom ls: reverse sort
abbr -a ls "lsd -t --reverse"

# Custom ls: just names
abbr -a lss "lsd -l -t --reverse --blocks=name"

# Custom ls: with permissions
abbr -a lsp "lsd --blocks=user,group,permission,name"

# Custom ls: full listing
abbr -a lsl "lsd -latr --blocks=date,user,group,permission,name"
