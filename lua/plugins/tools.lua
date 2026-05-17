return {
  -- Floating terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      shade_terminals = false,
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = { border = "curved" },
    },
  },

  -- Code outline sidebar
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
      { "[a", "<cmd>AerialPrev<cr>", desc = "Prev symbol" },
      { "]a", "<cmd>AerialNext<cr>", desc = "Next symbol" },
    },
    opts = {
      layout = { min_width = 28 },
      show_guides = true,
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Struct",
      },
    },
  },

  -- Git diff viewer
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diff Close" },
    },
  },

  -- Auto close/rename HTML & JSX tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  -- Extract function/variable refactors
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>re",
        function()
          require("refactoring").refactor("Extract Function")
        end,
        mode = "v",
        desc = "Extract Function",
      },
      {
        "<leader>rv",
        function()
          require("refactoring").refactor("Extract Variable")
        end,
        mode = "v",
        desc = "Extract Variable",
      },
      {
        "<leader>ri",
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        mode = { "n", "v" },
        desc = "Inline Variable",
      },
      {
        "<leader>rb",
        function()
          require("refactoring").refactor("Extract Block")
        end,
        desc = "Extract Block",
      },
    },
    opts = {},
  },

  -- Scrollbar with git/diagnostic/search markers
  {
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
    opts = {
      current_only = false,
      winblend = 50,
      handlers = {
        cursor = { enable = true },
        diagnostic = { enable = true },
        gitsigns = { enable = true },
        search = { enable = true },
      },
    },
  },

  -- Make it rain / Game of Life on your buffer
  {
    "Eandrju/cellular-automaton.nvim",
    keys = {
      {
        "<leader>fml",
        function()
          if vim.bo.filetype == "" or vim.bo.filetype:match("dashboard") then
            return
          end
          vim.cmd("CellularAutomaton make_it_rain")
        end,
        desc = "Make it Rain",
      },
      {
        "<leader>fmg",
        function()
          if vim.bo.filetype == "" or vim.bo.filetype:match("dashboard") then
            return
          end
          vim.cmd("CellularAutomaton game_of_life")
        end,
        desc = "Game of Life",
      },
    },
  },
}
