-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- Neo-tree is a Neovim plugin to browse the file system and other tree like structures in whatever style suits you, including sidebars, floating windows, netrw split style, or all of them at once!
return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    opts = {
        default_component_configs = {
            git_status = {
                symbols = {
                    -- Change type
                    added     = 'A', -- or '✚', but this is redundant info if you use git_status_colors on the name
                    modified  = 'M', -- or '', but this is redundant info if you use git_status_colors on the name
                    deleted   = 'D', -- this can only be used in the git_status source
                    renamed   = 'R', -- this can only be used in the git_status source
                    -- Status type
                    untracked = '?',
                    ignored   = 'I',
                    unstaged  = 'U',
                    staged    = 'S',
                    conflict  = 'C',
                }
            },
        },
        window = {
            mappings = {
                ['<tab>'] = { 'toggle_preview', config = { use_float = false } },
            }
        },
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
            }
        },
    },
}
