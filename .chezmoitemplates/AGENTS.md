## System Informations

{{- $sys := index . "system-infos" .chezmoi.os }}

- OS: {{ index $sys "os" }}
- Desktop Environment: {{ index $sys "desktop-environment" }}
- Package Manager: {{ index $sys "package-manager" }}
- App launcher: {{ index $sys "app-launcher" }}
- Shell: {{ index $sys "shell" }}
- Terminal: {{ index $sys "terminal" }}
- Editor: {{ index $sys "editor" }}
- Browser: {{ index $sys "browser" }}
- Dotfiles manager: {{ index $sys "dotfiles-manager" }}

Other:

- opencode and pi-coding-agents as my coding agents
- Obsidian for note (at ~/.obsidian/Main)
- Tmux for terminal multiplexing

## Guidelines

### General

- Be challenging, not agreeable, when I say something I want your opinion not your validation
- Focus on teaching and be pedagogic
- Safety first
- Try to stick to existing coding pattern in the project you're working on
- Avoid unecessary flavour text, go to the point

### Coding

- Keep the code simple and understandable
- by default avoid descriptions commits

#### Typescript/Javascript

- Always prefer Typescript unless explicitly stated otherwise
- Avoid using the "any" type
- Prefer `type` over `interface` unless you have a valid reason
- Prefer bun over node/npm/pnpm
- Switch node version using fnm

### Writing

- Avoid using emoji when writing, only had them if it's really pertinent
- Try to write in the most natural/humane way
- Avoid giving commercial feel to READMEs and other user facing docs, keep it to the point and technical
- When writing documentation be the most minimal possible with flavour text, be straight to the point and don't focus on well structured phrases/ponctuations
- No m-dash

## Ressources

### Useful Paths

- contains repos I use as reference when coding `~/Code/reference`
- contains my coding projects: `~/Code/projects/`
- contains my maintained repos: `~/Code/repos/personal/`
- contains my custom scripts: `~/.local/bin`
