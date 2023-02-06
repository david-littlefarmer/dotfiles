return {
    -- https://github.com/lewis6991/gitsigns.nvim
    -- Super fast git decorations implemented purely in Lua.
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            numhl = true,
            current_line_blame_opts = {
                virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
            },
        },
    },

    -- https://github.com/tpope/vim-fugitive
    -- Fugitive is the premier Vim plugin for Git. Or maybe it's the premier Git plugin for Vim? Either way, it's "so awesome, it should be illegal". That's why it's called Fugitive.
    -- The crown jewel of Fugitive is :Git (or just :G), which calls any arbitrary Git command. If you know how to use Git at the command line, you know how to use :Git. It's vaguely akin to :!git but with numerous improvements:
    'tpope/vim-fugitive',

    -- https://github.com/sindrets/diffview.nvim
    -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
    'sindrets/diffview.nvim',
}
