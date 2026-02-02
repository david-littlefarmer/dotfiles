-- https://github.com/greggh/claude-code.nvim
-- A seamless integration between Claude Code AI assistant and Neovim
return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    require("claude-code").setup()
  end
}
