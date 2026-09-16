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

vim.cmd('filetype plugin on')


vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local gobin = vim.fn.trim(vim.fn.system('go env GOBIN 2>/dev/null'))
if gobin ~= '' and not vim.tbl_contains(vim.split(vim.env.PATH or '', ':'), gobin) then
    vim.env.PATH = gobin .. ':' .. vim.env.PATH
end

-- [[ Highlight on yank ]]
-- See `:help vim.hl.hl_op()`
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.hl_op()
    end,
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    pattern = '*',
})

vim.cmd('autocmd User TelescopePreviewerLoaded setlocal number')
