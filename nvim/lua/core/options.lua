local o          = vim.o

o.number         = true
o.relativenumber = true
o.tabstop        = 4
o.softtabstop    = 4
o.shiftwidth     = 4
o.expandtab      = true
o.smartindent    = true
o.hlsearch       = false
o.incsearch      = true
o.bomb           = false
o.termguicolors  = true
o.scrolloff      = 8
o.signcolumn     = 'yes'
o.updatetime     = 50
o.colorcolumn    = '200'
o.clipboard      = "unnamed,unnamedplus"
o.mouse          = 'a'
o.breakindent    = true
o.undofile       = true
o.ignorecase     = true
o.smartcase      = true
o.completeopt    = 'menuone,noselect'

o.syntax = 'enable'
o.compatible = false
vim.cmd('filetype plugin on')


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    pattern = '*',
})

vim.cmd('autocmd User TelescopePreviewerLoaded setlocal number')
