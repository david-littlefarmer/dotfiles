return {
    -- https://github.com/numToStr/Comment.nvim
    {
        'numToStr/Comment.nvim',
        opts = {},
    },

    -- https://github.com/folke/todo-comments.nvim
    -- odo-comments is a lua plugin for Neovim >= 0.8.0 to highlight and search for todo comments like TODO, HACK, BUG in your code base.
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            keywords = {
                FIX = { icon = 'F', color = 'fix', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, },
                TODO = { icon = 'T', color = 'todo' },
                WARN = { icon = 'W', color = 'warn', alt = { 'WARNING', 'XXX' } },
                NOTE = { icon = 'N', color = 'note', alt = { 'INFO' } },
                PERF = { icon = 'P', color = 'perf', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
                TEST = { icon = 't', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
            },
            colors = {
                fix = { '#AB4642' },
                todo = { '#A1B56C' },
                warn = { '#F7CA88' },
                note = { '#7CAFC2' },
                perf = { '#DC9656' },
                test = { '#BA8BAF' },
                default = { '#E8E8E8' },
            },
            gui_style = {
                fg = 'NONE', -- The gui style to use for the fg highlight group.
                bg = 'NONE', -- The gui style to use for the bg highlight group.
            },
        },
    },
}
