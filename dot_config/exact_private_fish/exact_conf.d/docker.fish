# Rebuild docker compose
abbr -a dcbd "docker compose up -d --build"

# Stop docker compose
abbr -a dcd "docker compose down"

# Restart docker compose
abbr -a dcr "docker compose restart"

# Remove docker volumes
abbr -a dcdv "docker compose down -v"

# Exec command to complete with container name
abbr -a dce "docker compose exec"

# Logs command to complete with container name
abbr -a dcl "docker compose logs"

# Start docker compose
abbr -a dcu "docker compose up -d"

# List docker compose containers
abbr -a dcps "docker compose ps"

# List all docker containers
abbr -a dpsa "docker ps -a"
