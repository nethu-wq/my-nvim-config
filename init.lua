vim.g.lazyvim_check_order = false
require("config.lazy")
-- Moving gradient wave effect for Snacks Dashboard

vim.opt.termguicolors = true
local wave_colors = {
  "#0a2540",
  "#0f3d66",
  "#145da0",
  "#1e81b0",
  "#2e8bc0",
  "#48cae4",
  "#72efdd",
  "#90e0ef",
  "#ade8f4",
}

local index = 1
local timer = vim.loop.new_timer()

timer:start(
  0,
  120,
  vim.schedule_wrap(function()
    local total = #wave_colors

    vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = wave_colors[(index % total) + 1] })
    vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = wave_colors[((index + 1) % total) + 1] })
    vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = wave_colors[((index + 2) % total) + 1] })
    vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = wave_colors[((index + 3) % total) + 1] })
    vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = wave_colors[((index + 4) % total) + 1] })

    index = (index + 1) % total
  end)
)
