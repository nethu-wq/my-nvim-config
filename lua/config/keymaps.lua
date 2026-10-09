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

-- Open current file in its default Windows app (e.g. a PDF in your PDF viewer)
vim.keymap.set("n", "<leader>fo", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("Buffer has no file", vim.log.levels.WARN)
    return
  end
  vim.ui.open(file)
end, { desc = "Open File in Default App" })

-- Line numbers
vim.api.nvim_set_hl(0, "LineNr", { fg = "#b4befe" })
