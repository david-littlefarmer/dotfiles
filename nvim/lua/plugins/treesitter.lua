local ensure_installed = {
    'bash', 'c', 'cpp', 'css', 'dockerfile', 'go', 'gomod', 'gosum', 'gowork', 'gotmpl',
    'html', 'javascript', 'json', 'lua', 'python', 'rust', 'sql', 'svelte', 'toml',
    'typescript', 'vim', 'yaml',
}

require('nvim-treesitter').setup()
require('nvim-treesitter').install(ensure_installed)

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('TreesitterStart', { clear = true }),
    callback = function(ev)
        if not pcall(vim.treesitter.start, ev.buf) then return end
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

vim.g.no_plugin_maps = true
require('nvim-treesitter-textobjects').setup({
    select = { lookahead = true },
    move = { set_jumps = true },
})

local select = require('nvim-treesitter-textobjects.select')
local move = require('nvim-treesitter-textobjects.move')
local swap = require('nvim-treesitter-textobjects.swap')
local map = vim.keymap.set

map({ 'x', 'o' }, 'aa', function() select.select_textobject('@parameter.outer', 'textobjects') end)
map({ 'x', 'o' }, 'ia', function() select.select_textobject('@parameter.inner', 'textobjects') end)
map({ 'x', 'o' }, 'af', function() select.select_textobject('@function.outer', 'textobjects') end)
map({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end)
map({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end)
map({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end)

map({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer', 'textobjects') end)
map({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer', 'textobjects') end)
map({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer', 'textobjects') end)
map({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer', 'textobjects') end)
map({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer', 'textobjects') end)
map({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer', 'textobjects') end)
map({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer', 'textobjects') end)
map({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer', 'textobjects') end)

map('n', '<leader>a', function() swap.swap_next('@parameter.inner') end)
map('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end)
