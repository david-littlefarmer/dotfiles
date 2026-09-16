-- https://github.com/ThePrimeagen/refactoring.nvim
-- The Refactoring library based off the Refactoring book by Martin Fowler
return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "lewis6991/async.nvim",
    },
    config = function()
        require("refactoring").setup()
    end,
}
