return {
  -- Harpoon2: pin files and jump instantly
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon Add" })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })

      vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
      vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
      vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
      vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
    end,
  },

  -- smart-splits: Ctrl+Alt+h/j/k/l crosses vim splits and, at the edge, hands off
  -- to WezTerm panes (pairs with the matching bindings in .wezterm.lua)
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {
      multiplexer_integration = "wezterm",
    },
    config = function(_, opts)
      local smart_splits = require("smart-splits")
      smart_splits.setup(opts)

      vim.keymap.set("n", "<C-M-h>", smart_splits.move_cursor_left, { desc = "Move to left split/pane" })
      vim.keymap.set("n", "<C-M-j>", smart_splits.move_cursor_down, { desc = "Move to lower split/pane" })
      vim.keymap.set("n", "<C-M-k>", smart_splits.move_cursor_up, { desc = "Move to upper split/pane" })
      vim.keymap.set("n", "<C-M-l>", smart_splits.move_cursor_right, { desc = "Move to right split/pane" })
    end,
  },
}
