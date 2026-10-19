local telescope = require('telescope')
telescope.setup({})
telescope.load_extension('fzf')

local builtin = require('telescope.builtin')
local map = vim.keymap.set

map('n', '<C-p>', builtin.git_files, { desc = 'Find git files' })
map('n', '<leader>?', builtin.oldfiles, { desc = 'Find recently opened files' })
map('n', '<leader><space>', builtin.buffers, { desc = 'Find existing buffers' })
map('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
map('n', '<leader>sh', builtin.help_tags, { desc = 'Search help' })
map('n', '<leader>sw', builtin.grep_string, { desc = 'Search current word' })
map('n', '<leader>sg', builtin.live_grep, { desc = 'Search by grep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
map('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = 'Fuzzy search current buffer' })
map({ 'n', 'x' }, '<leader>rr', function() require('refactoring').select_refactor() end, { desc = 'Refactor' })
