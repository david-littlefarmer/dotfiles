require('mini.pairs').setup()
require('mini.cursorword').setup()

require('nvim-surround').setup({})

require('flash').setup({})
local map = vim.keymap.set
map({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash' })
map({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash treesitter' })
map('o', 'r', function() require('flash').remote() end, { desc = 'Remote flash' })
map({ 'o', 'x' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Treesitter search' })
map('c', '<c-s>', function() require('flash').toggle() end, { desc = 'Toggle flash search' })

require('textcase').setup({})

require('tmux').setup({
    copy_sync = { sync_clipboard = false },
})

require('refactoring').setup({})

require('lazydev').setup({
    library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
})

require('claude-code').setup()
