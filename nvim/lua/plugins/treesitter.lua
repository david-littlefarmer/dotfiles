-- https://github.com/nvim-treesitter/nvim-treesitter
-- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it:
return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                -- Add languages to be installed here that you want installed for treesitter
                ensure_installed = {
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
                },
                highlight = {
                    enable = true
                },
                indent = {
                    enable = true,
                    disable = {
                        'python'
                    },
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-s>',
                        node_incremental = '<c-s>',
                        node_decremental = '<c-b>',
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>a'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>A'] = '@parameter.inner',
                        },
                    },
                },
            }
        end
    },

    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    -- Syntax aware text-objects, select, move, swap, and peek support.
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
    },
}
