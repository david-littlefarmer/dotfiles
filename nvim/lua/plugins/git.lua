require('gitsigns').setup({
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
    numhl = true,
    current_line_blame_opts = {
        virt_text_pos = 'right_align',
        delay = 1000,
    },
})
