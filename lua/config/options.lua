-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Enable the cursor line
vim.opt.cursorline = true

-- Make the active line number "Glow" Peach
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#fab387", bold = true })

-- Give the line background a subtle, techy "lift"
-- This makes the line look like it's slightly lit up
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2e2e3e" })
vim.opt.cursorlineopt = "both" -- Highlights both the line and the number
