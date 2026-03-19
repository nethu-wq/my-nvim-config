return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine-moon",
    },
  },

  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },

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

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "black",
      },
    },
  },

  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        extra_groups = { "NormalFloat", "NvimTreeNormal" },
      })
    end,
  },

  {
    "sphamba/smear-cursor.nvim",
    opts = {
      cursor_color = "#ff0000",
      stiffness = 0.6,
      trailing_stiffness = 0.3,
      distance_stop_animating = 0.1,
      color_levels = 4,
      gamma = 1.0,
      volume_reduction_exponent = 0.3,
      minimum_volume_factor = 0.3,
      trailing_exponent = 0,
      hide_target_hack = true,
    },
    config = function(_, opts)
      local smear = require("smear_cursor")
      local colors = {
        "#ff0000",
        "#ff7700",
        "#ffff00",
        "#00ff00",
        "#0000ff",
        "#8b00ff",
      }
      local index = 1
      vim.loop.new_timer():start(
        0,
        200,
        vim.schedule_wrap(function()
          opts.cursor_color = colors[index]
          smear.setup(opts)
          index = index % #colors + 1
        end)
      )
      smear.setup(opts)
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = { window = { width = 0.85 } },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true, show_start = true },
    },
  },

  { "hiphish/rainbow-delimiters.nvim", event = "VeryLazy" },

  {
    "nvim-mini/mini.animate",
    event = "VeryLazy",
    opts = {
      resize = { enable = true },
      scroll = { enable = true },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = { border = "curved" },
    },
  },

  { "NvChad/nvim-colorizer.lua", opts = {
    user_default_options = { names = false },
  } },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
  },
  {
    "folke/snacks.nvim",
    config = function(_, opts)
      vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#f38ba8" })
      require("snacks").setup(opts)
    end,
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
 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
      },
    },
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true,
        stop_eof = true,
        cursor_scrolls_alone = true,
        easing_function = "quadratic",
      })
    end,
  },
  {
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>dd",
        function()
          require("duck").hatch("🐧", 5)
        end,
        desc = "Hatch Penguin",
      },
      {
        "<leader>dk",
        function()
          require("duck").cook()
        end,
        desc = "Cook Penguin",
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
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        enabled = true,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
      },
      select = {
        enabled = true,
        backend = { "telescope", "builtin" },
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
        ["Add Cursor Up"] = "<C-Up>",
        ["Add Cursor Down"] = "<C-Down>",
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        java = { "string", "source" },
        html = { "string", "source" },
      },
    },
  },
  { "rose-pine/neovim", name = "rose-pine" },
  -- Add this to your Lazy plugins list
  {
    "folke/drop.nvim",
    config = function()
      -- defer until the dashboard buffer is ready
      vim.defer_fn(function()
        local status, drop = pcall(require, "drop")
        if not status then
          vim.notify("drop.nvim not loaded!", vim.log.levels.WARN)
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()

        drop.setup({
          theme = "snow",
          max = 80, -- number of snowflakes
          interval = 50, -- lower = faster falling
          wind = 2, -- horizontal drift
          buffer = bufnr, -- attach to dashboard
          color_override = function(x)
            local total_cols = #wave_colors
            return wave_colors[(x % total_cols) + 1] or "#ffffff"
          end,
          drift = function()
            return math.random(-1, 1)
          end,
        })
      end, 150)
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        user_default_options = {
          names = true, -- enables color names like 'blue'
          mode = "background", -- or "foreground"
        },
      })
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
    keys = {
      -- Press Leader + c + p to open the Color Picker
      { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color Picker" },
    },
  },
}
