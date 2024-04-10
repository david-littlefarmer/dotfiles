-- https://github.com/david-littlefarmer/ridl.nvim
-- RIDL highlighting for Neovim
return {
    "david-littlefarmer/ridl.nvim",
    config = function()
        vim.cmd('autocmd BufRead,BufNewFile *.ridl set filetype=ridl')
        vim.cmd('autocmd BufRead,BufNewFile *.ridl lua require("ridl").setup()')
    end,
}
