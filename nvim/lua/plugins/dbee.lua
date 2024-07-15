-- https://github.com/kndndrj/nvim-dbee
-- Database Client for NeoVim!
return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require("dbee").install()
  end,
  config = function()
    require("dbee").setup {
    sources = {
      require("dbee.sources").MemorySource:new({
        {
          name = "devbox",
          type = "postgres",
          url = "postgres:postgres@localhost:5432",
        },
        -- ...
      }),
      require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
    },
    -- ...
  }
  end,
}
