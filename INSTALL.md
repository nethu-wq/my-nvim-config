# Setup Guide

Everything you need to install before cloning and running this Neovim config.

---

## 1. Neovim (0.9 or later)

```
winget install Neovim.Neovim
```

Or download the latest release from https://github.com/neovim/neovim/releases

---

## 2. Git

```
winget install Git.Git
```

---

## 3. A Nerd Font

Icons and symbols won't render without one.

1. Go to https://www.nerdfonts.com/font-downloads
2. Download any font you like (JetBrainsMono or CascadiaCode are good picks)
3. Extract and install the font files (right-click → Install)
4. Set the font in your terminal (Windows Terminal: Settings → your profile → Font face)

---

## 4. A C Compiler (for Treesitter)

Treesitter needs to compile parsers. Install LLVM:

```
winget install LLVM.LLVM
```

After installing, make sure `clang` is on your PATH by restarting your terminal and running:

```
clang --version
```

---

## 5. ripgrep and fd (for search)

Used by the fuzzy finder and grep features.

```
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd
```

---

## 6. Node.js (for TypeScript/JavaScript LSP)

Required for the TypeScript and JavaScript language server to work (autocompletion, errors, go-to-definition in JS/TS files).

```
winget install OpenJS.NodeJS
```

---

## 7. Java JDK + Maven (for the Java workflow)

Required for Java autocompletion, error checking, and the built-in Maven commands (`<leader>mb`, `<leader>mn` etc). Skip this if you're not doing Java development.

```
winget install Microsoft.OpenJDK.21
winget install Apache.Maven
```

After installing, verify both are on your PATH:

```
java --version
mvn --version
```

---

## 8. Python (for Python LSP and linting)

```
winget install Python.Python.3.12
```

---

## 9. Claude CLI (for `<leader>ac` Claude Code integration)

Follow the install instructions at https://claude.ai/code

After installing, make sure `claude` works in your terminal:

```
claude --version
```

---

## Installing the Config

Once everything above is installed, restart your terminal, then:

```
git clone https://github.com/nethu-wq/my-nvim-config.git "%LOCALAPPDATA%\nvim"
nvim
```

On first launch, lazy.nvim will automatically download and install all plugins. This takes a minute or two. After it finishes, restart Neovim and everything should be working.

Mason will also install LSP servers, linters, and formatters automatically in the background on first launch.

---

## Keybinds

Check `vim-shorts.md` in this repo for a full list of keybinds and shortcuts.
