return {
  {
    "Anthropic/claudecode.nvim",
    keys = {
      { "<leader>ac", function() require("claudecode").toggle() end, desc = "Claude Code" },
    },
  },
}
