---
name: neovim
description: skill for neovim
---

My neovim configuration is located at: ~/.config/nvim

It's built around snacks plugins and nvchad ui plugins

## Useful Commands

nvim --headless "+help nvui" "+lua io.stdout:write(table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n') .. '\n')" +qa

## Useful Links

https://nvchad.com/docs/features
https://www.lazyvim.org/extras
https://github.com/folke/snacks.nvim
https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
