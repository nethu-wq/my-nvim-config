return {
  {
    "coder/claudecode.nvim",
    opts = {
      -- Keep the conversation in the terminal's native scrollback instead of
      -- the fullscreen alternate-screen renderer, which nvim's :terminal
      -- can't scroll back through.
      env = { CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN = "1" },
    },
  },
}
