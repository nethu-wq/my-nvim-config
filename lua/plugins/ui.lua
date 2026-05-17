return {
  -- 1. Theme & Core LazyVim
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine-moon",
    },
  },
  { "rose-pine/neovim", name = "rose-pine" },

  -- 2. Language Support (Extras)
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.java" },

  -- 3. Treesitter (Syntax Highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      })
    end,
  },

  -- 4. Mason (LSP/Linter/Formatter Manager)
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "stylua", "shellcheck", "shfmt", "flake8", "black" },
    },
  },

  -- 5. Transparency
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        extra_groups = { "NormalFloat", "NvimTreeNormal" },
      })
    end,
  },

  -- 6. UI Elements (Zen Mode, Rainbow Brackets)
  {
    "folke/zen-mode.nvim",
    opts = {
      window = { width = 0.85 },
      plugins = { twilight = { enabled = true } },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
  {
    "folke/twilight.nvim",
    opts = {
      dimming = { alpha = 0.25 },
      context = 10,
    },
    keys = { { "<leader>tw", "<cmd>Twilight<cr>", desc = "Twilight" } },
  },
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        render = function(props)
          local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if fname == "" then
            fname = "[No Name]"
          end
          local icon, color = devicons.get_icon_color(fname)
          return {
            icon and { icon, guifg = color } or "",
            icon and " " or "",
            { fname, guifg = "#cba6f7" },
          }
        end,
        window = {
          padding = { left = 1, right = 1 },
          margin = { horizontal = 1, vertical = 1 },
          placement = { horizontal = "right", vertical = "top" },
          winhighlight = { Normal = "NormalFloat" },
        },
      })
    end,
  },
  { "hiphish/rainbow-delimiters.nvim", event = "VeryLazy" },

  -- 7. Cursor Effects
  {
    -- Smear trail when cursor moves
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = true,
      smear_rainbow = false,
    },
  },
  {
    -- Cursor flashes when jumping to a new location
    "DanilaMihailov/beacon.nvim",
    event = "VeryLazy",
  },

  -- 8. Animation
  {
    "nvim-mini/mini.animate",
    event = "VeryLazy",
    opts = {
      resize = { enable = true },
      -- scroll disabled: neoscroll handles it (fixes gg/f bugs)
      scroll = { enable = false },
    },
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = false,
        stop_eof = true,
        cursor_scrolls_alone = true,
        easing_function = "quadratic",
      })
    end,
  },

  -- 9. Utilities
  {
    "NvChad/nvim-colorizer.lua",
    opts = { user_default_options = { names = true, mode = "virtualtext", virtualtext = "■" } },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = { bottom_search = true, command_palette = true, long_message_to_split = true, inc_rename = true },
    },
  },

  -- 9. Snacks Dashboard
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
        preset = {
          header = [[
 ███╗  ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
 ████╗ ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
      },
    },
    config = function(_, opts)
      vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#f38ba8" })
      require("snacks").setup(opts)
    end,
  },

  -- 10. Fun Stuff (Duck & Snow)
  {
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>dd",
        function()
          require("duck").hatch("🐧", 5)
        end,
        desc = "Hatch",
      },
      {
        "<leader>dk",
        function()
          require("duck").cook()
        end,
        desc = "Cook",
      },
      {
        "<leader>da",
        function()
          require("duck").cook_all()
        end,
        desc = "Cook All",
      },
    },
  },
  { "folke/drop.nvim", lazy = true },

  -- 11. Helper Tools
  { "stevearc/dressing.nvim", opts = { input = { enabled = true, border = "rounded" } } },
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_maps = { ["Find Under"] = "<C-d>", ["Add Cursor Up"] = "<C-Up>", ["Add Cursor Down"] = "<C-Down>" }
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    opts = { highlighter = { auto_enable = true, lsp = true } },
    keys = { { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color Picker" } },
  },

  -- 12. Lualine (cycle color + harpoon slot)
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local function harpoon_slot()
        local ok, harpoon = pcall(require, "harpoon")
        if not ok then
          return ""
        end
        local list = harpoon:list()
        if not list or not list.items then
          return ""
        end
        local current = vim.fn.expand("%:p")
        for i, item in ipairs(list.items) do
          if item and vim.fn.fnamemodify(item.value, ":p") == current then
            return "  " .. i
          end
        end
        return ""
      end

      return {
        options = {
          theme = "rose-pine",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              "mode",
              color = function()
                return { bg = _G.lualine_cycle_color or "#cba6f7", fg = "#1e1e2e", gui = "bold" }
              end,
            },
          },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 }, harpoon_slot },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      }
    end,
  },

  -- 13. Bufferline (styled tabs)
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "slant",
        show_close_icon = true,
        show_buffer_close_icons = true,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = { error = " ", warning = " " }
          local s = ""
          for key, n in pairs(diag) do
            if icons[key] then
              s = s .. icons[key] .. n
            end
          end
          return s
        end,
        offsets = {
          { filetype = "neo-tree", text = "Explorer", highlight = "Directory", text_align = "center" },
        },
      },
    },
  },

  -- 14. Headlines (markdown heading backgrounds)
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "markdown", "norg" },
    config = function()
      vim.api.nvim_set_hl(0, "Headline1", { bg = "#2a1a3e", fg = "#cba6f7", bold = true })
      vim.api.nvim_set_hl(0, "Headline2", { bg = "#1a2a3e", fg = "#89b4fa", bold = true })
      vim.api.nvim_set_hl(0, "Headline3", { bg = "#1a3e2a", fg = "#a6e3a1", bold = true })
      vim.api.nvim_set_hl(0, "CodeBlock", { bg = "#1e1e2e" })
      vim.api.nvim_set_hl(0, "Dash", { fg = "#f38ba8", bold = true })
      require("headlines").setup({
        markdown = {
          headline_highlights = { "Headline1", "Headline2", "Headline3" },
          codeblock_highlight = "CodeBlock",
          dash_highlight = "Dash",
          fat_headlines = true,
        },
      })
    end,
  },
}
