-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local is_windows = vim.loop.os_uname().version:find("Windows")

--------------------------------------------------
-- UTILITY: STABLE FLOATING TERMINAL
--------------------------------------------------
local function float_terminal(cmd, cwd)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  })

  -- On Windows, wrap in shell to ensure Maven (mvn) is found in PATH correctly
  local final_cmd = is_windows and { "cmd.exe", "/c", cmd } or cmd

  vim.fn.termopen(final_cmd, { cwd = cwd })
  vim.cmd("startinsert")
end

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert mode" })
local is_win = vim.loop.os_uname().version:match("Windows")

-------------------------------------------------
-- Cursor Line Highlight
-------------------------------------------------

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable cursor line
vim.opt.cursorline = true

-- Highlight the current line background
vim.api.nvim_set_hl(0, "CursorLine", {
  bg = "#94e2d5",
})

-- Highlight the current line number
vim.api.nvim_set_hl(0, "CursorLineNr", {
  fg = "#f38ba8",
  bold = true,
})

-- Dim other line numbers
vim.api.nvim_set_hl(0, "LineNr", {
  fg = "#b4befe",
})

-------------------------------------------------
-- Disable cursorline while typing
-------------------------------------------------

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.cursorline = false
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.cursorline = true
  end,
})
vim.keymap.set("v", "<leader>XX", "<Plug>(nvim-surround-visual)", { desc = "Surround Selection (Leader XX)" })
