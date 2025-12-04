alias rvenv="source venv/bin/activate.fish" # Start python venv

alias dvenv="deactivate" # deactivate python venv

# Start and run python env
function svenv
    python3 -m venv venv
    source venv/bin/activate.fish
end
