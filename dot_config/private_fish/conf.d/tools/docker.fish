# Start docker
abbr -a dcud "docker compose up -d"

# Rebuild docker
abbr -a dcbd "docker compose up -d --build"

# Stop docker
abbr -a dcd "docker compose down"

# Restart docker
abbr -a dcr "docker compose restart"

# Remove docker volumes
abbr -a dcdv "docker compose down -v"

# Exec command to complete with container name
abbr -a dce "docker compose exec"

# Logs command to complete with container name
abbr -a dcl "docker compose logs"
