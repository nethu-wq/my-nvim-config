return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      chunk = {
        enable = true,
        use_treesitter = true,
      },
      indent = {
        enable = true,
        chars = { "│", "¦", "┆", "┊" },
        style = { "#fab387" }, -- Matches your peach cursor
      },
    },
  },
}
