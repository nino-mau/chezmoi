## System Informations

Information about the system you're running on:

{{- $sys := index . "system-infos" .chezmoi.os }}

- OS: {{ index $sys "os" }}
- Desktop Environment: {{ index $sys "desktop-environment" }}
- Package Manager: {{ index $sys "package-manager" }}
- App launcher: {{ index $sys "app-launcher" }}
- Shell: {{ index $sys "shell" }}
- Terminal: {{ index $sys "terminal" }}
- Editor: {{ index $sys "editor" }}
- Browser: {{ index $sys "browser" }}
- dotfiles manager: {{ index $sys "dotfiles-manager" }}
- Keyboard re-mapper: {{ index $sys "keyboard-mapper" }}

Other:

- Opencode and pi-coding-agents as my coding agents
- Obsidian for note (at ~/.obsidian/Main)
- Tmux for terminal multiplexing

## Guidelines

### General

- NO GLAZING
- KEEP IT SIMPLE
- Be challenging, not agreeable, when the user say something the user wants your opinion not your validation
- When the user asks a question (or anything that sounds like a question), answer it first before making edits or running implementation commands.
- Keep answers short and concise
- No fluff or cheerful filler text (e.g., "Thanks @user" not "Thanks so much @user!")

### Coding

- KEEP IT SIMPLE
- Try to stick to existing coding pattern in the project you're working on

### Writing

- Avoid using emoji
- Write in a natural/humane way
- No m-dash

## Resources

### Useful Paths

- contains repos I use as reference when coding `~/Code/references`
- contains my coding projects: `~/Code/projects/`
- contains my maintained repos: `~/Code/repos/personal/`
- contains my custom scripts: `~/.local/bin`
