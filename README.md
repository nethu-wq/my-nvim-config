# My Neovim Config

A personal Neovim setup built on [LazyVim](https://github.com/LazyVim/LazyVim) with a focus on Java development, a heavily animated UI, and a bunch of quality-of-life tools.

---

## Features

**UI & Visuals**
- Rose Pine Moon colorscheme with full transparency support
- Animated wave gradient on the dashboard header
- Cycling cursorline color that syncs with the statusline and cursor trail
- Smear cursor trail, beacon flash on jump, animated scrolling
- Colored snow effect on the dashboard
- Rainbow brackets, indent guides, floating filename labels per window

**Development**
- Full Java setup via `nvim-jdtls` with LSP, autocompletion, and diagnostics
- TypeScript, Python, JSON, Tailwind, Markdown language support
- Maven workflow built in — create, build, run, and test Java projects without leaving Neovim
- Aerial symbol outline sidebar
- Refactoring tools (extract function/variable, inline variable)
- Git diff viewer and file history via Diffview

**Navigation**
- Harpoon2 for pinning and instantly jumping between files
- Flash.nvim for fast cursor jumping
- Multi-cursor editing with vim-visual-multi

**AI**
- Claude Code integration (`<leader>ac`) via the official claudecode.nvim plugin

**Fun**
- Walking penguin on your screen (`<leader>dd`)
- Make it rain / Game of Life on your buffer (`<leader>fml` / `<leader>fmg`)

---

## Setup

See [INSTALL.md](INSTALL.md) for a full list of prerequisites and install instructions.

---

## Keybinds

See [vim-shorts.md](vim-shorts.md) for a full keybind reference.

---

## Plugin Manager

Uses [lazy.nvim](https://github.com/folke/lazy.nvim). All plugins install automatically on first launch.
