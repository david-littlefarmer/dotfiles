-- https://github.com/nvim-treesitter/nvim-treesitter
-- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it:
local ensure_installed = {
    'c',
    'cpp',
    'bash',
    'go',
    'gomod',
    'gosum',
    'lua',
    'rust',
    'javascript',
    'html',
    'css',
    'typescript',
    'vim',
    'yaml',
    'toml',
    'svelte',
    'sql',
}

return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').setup()
            require('nvim-treesitter').install(ensure_installed)

            vim.api.nvim_create_autocmd('FileType', {
                pattern = ensure_installed,
                callback = function()
                    vim.treesitter.start()
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end
    },

    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    -- Syntax aware text-objects, select, move, swap, and peek support.
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        init = function()
            vim.g.no_plugin_maps = true
        end,
        config = function()
            require('nvim-treesitter-textobjects').setup {
                select = {
                    lookahead = true,
                },
                move = {
                    set_jumps = true,
                },
            }

            local select = require('nvim-treesitter-textobjects.select')
            vim.keymap.set({ 'x', 'o' }, 'aa', function() select.select_textobject('@parameter.outer', 'textobjects') end)
            vim.keymap.set({ 'x', 'o' }, 'ia', function() select.select_textobject('@parameter.inner', 'textobjects') end)
            vim.keymap.set({ 'x', 'o' }, 'af', function() select.select_textobject('@function.outer', 'textobjects') end)
            vim.keymap.set({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end)
            vim.keymap.set({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end)
            vim.keymap.set({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end)

            local move = require('nvim-treesitter-textobjects.move')
            vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer', 'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer', 'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer', 'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer', 'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer', 'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer', 'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer', 'textobjects') end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer', 'textobjects') end)

            local swap = require('nvim-treesitter-textobjects.swap')
            vim.keymap.set('n', '<leader>a', function() swap.swap_next('@parameter.inner') end)
            vim.keymap.set('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end)
        end,
    },
}
