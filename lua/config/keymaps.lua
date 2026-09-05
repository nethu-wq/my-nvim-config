-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert mode" })

-- Run current Python file in floating terminal
vim.keymap.set("n", "<leader>r", function()
  if vim.bo.filetype == "python" then
    require("toggleterm.terminal").Terminal
      :new({ cmd = "python " .. vim.fn.expand("%:p"), direction = "float", close_on_exit = false })
      :toggle()
  end
end, { desc = "Run Python file" })
vim.keymap.set("v", "<leader>XX", "<Plug>(nvim-surround-visual)", { desc = "Surround Selection (Leader XX)" })

-- Line numbers
vim.api.nvim_set_hl(0, "LineNr", { fg = "#b4befe" })
