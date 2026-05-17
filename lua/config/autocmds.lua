-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Wave gradient on dashboard header: only runs while the dashboard is visible
local wave_colors = { "#0a2540", "#0f3d66", "#145da0", "#1e81b0", "#2e8bc0", "#48cae4", "#72efdd", "#90e0ef", "#ade8f4" }
local wave_index = 1

-- Snow effect: only initialize once, when the dashboard first opens
vim.api.nvim_create_autocmd("User", {
  pattern = "SnacksDashboardOpened",
  once = true,
  callback = function()
    local drop_colors = { "#ff563d", "#5eb387", "#b652af", "#ffc2a1", "#89b4fa", "#cba6f7" }
    require("drop").setup({
      theme = "snow",
      max = 80,
      interval = 50,
      wind = 2,
      drift = function() return math.random(-1, 1) end,
      color_override = function(x) return drop_colors[(x % #drop_colors) + 1] end,
    })
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "SnacksDashboardOpened",
  callback = function()
    if _G._wave_timer then return end
    _G._wave_timer = vim.uv.new_timer()
    _G._wave_timer:start(0, 120, vim.schedule_wrap(function()
      local total = #wave_colors
      vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = wave_colors[(wave_index % total) + 1] })
      vim.api.nvim_set_hl(0, "SnacksDashboardKey",    { fg = wave_colors[((wave_index + 1) % total) + 1] })
      vim.api.nvim_set_hl(0, "SnacksDashboardDesc",   { fg = wave_colors[((wave_index + 2) % total) + 1] })
      vim.api.nvim_set_hl(0, "SnacksDashboardIcon",   { fg = wave_colors[((wave_index + 3) % total) + 1] })
      vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = wave_colors[((wave_index + 4) % total) + 1] })
      wave_index = (wave_index + 1) % total
    end))
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "SnacksDashboardClosed",
  callback = function()
    if _G._wave_timer then
      _G._wave_timer:stop()
      _G._wave_timer:close()
      _G._wave_timer = nil
    end
  end,
})


-- Cycle cursor line color every 5 seconds
local cycle_colors = {
  "#2a7a6e", -- teal
  "#3a7a4a", -- green
  "#6a4a9a", -- purple
  "#8a3a50", -- pink
  "#8a6a2a", -- peach
  "#2a4a8a", -- blue
  "#8a5a2a", -- orange
}
local color_index = 1

_G._cycle_timer = vim.uv.new_timer()
_G._cycle_timer:start(0, 5000, vim.schedule_wrap(function()
  local color = cycle_colors[color_index]
  vim.api.nvim_set_hl(0, "CursorLine", { bg = color })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = color, bold = true })
  local ok, smear = pcall(require, "smear_cursor")
  if ok and smear.config and type(smear.config) == "table" then
    smear.config.cursor_color = color
  end
  _G.lualine_cycle_color = color
  local lok, lualine = pcall(require, "lualine")
  if lok then lualine.refresh() end
  color_index = (color_index % #cycle_colors) + 1
end))

-- Disable format-on-save for Java (jdtls LSP formatter breaks files)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Exit terminal mode with jk or <Esc><Esc>
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(ev)
    vim.keymap.set("t", "jk", [[<C-\><C-n>]], { buffer = ev.buf, desc = "Exit terminal mode" })
    vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = ev.buf, desc = "Exit terminal mode" })
  end,
})
