local map = vim.keymap.set

map('x', '<leader>p', [["_dP]])
map({ 'n', 'v' }, '<leader>y', [["+y]])
map('n', '<leader>Y', [["+Y]])
map({ 'n', 'v' }, '<leader>d', [["_d]])

map('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map('n', '<leader>tn', ':tabnew<CR>', { desc = 'Open New Tab' })
map('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close Current Tab' })
map('n', '<leader>l', ':tabnext<CR>', { desc = 'Next Tab' })
map('n', '<leader>h', ':tabprev<CR>', { desc = 'Previous Tab' })
map('n', '<leader>sph', ':split<CR>', { desc = 'Split Window Horizontally' })
map('n', '<leader>spv', ':vsplit<CR>', { desc = 'Split Window Vertically' })

map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move lines down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move lines up' })
map('n', 'J', 'mzJ`z', { desc = 'Join line below, keep cursor' })

map('n', 'n', 'nzzzv', { desc = 'Next search, centered' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search, centered' })
map('n', '<C-k>', '<cmd>cnext<CR>zz')
map('n', '<C-j>', '<cmd>cprev<CR>zz')
map('n', '<leader>k', '<cmd>lnext<CR>zz')
map('n', '<leader>j', '<cmd>lprev<CR>zz')

map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Substitute current word' })
map('n', '<leader>x', '<cmd>!chmod +x %<CR>', { desc = 'chmod +x current file' })

map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Diagnostic float' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics to loclist' })

map('n', '<leader>tt', ':Neotree<CR>', { desc = 'Neotree' })
map('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = 'Git blame line' })

map('n', '<F5>', function() require('dap').continue() end, { desc = 'DAP continue' })
map('n', '<S-F5>', function() require('dap').restart() end, { desc = 'DAP restart' })
map('n', '<C-S-F5>', function() require('dap').terminate() end, { desc = 'DAP terminate' })
map('n', '<F10>', function() require('dap').step_over() end, { desc = 'DAP step over' })
map('n', '<F11>', function() require('dap').step_into() end, { desc = 'DAP step into' })
map('n', '<S-F11>', function() require('dap').step_out() end, { desc = 'DAP step out' })
map('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'DAP toggle breakpoint' })
map('n', '<leader>B', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'DAP conditional breakpoint' })
map('n', '<leader>dT', function() require('dap-go').debug_test() end, { desc = 'DAP debug Go test' })
map('n', '<leader>dt', function() require('dapui').toggle() end, { desc = 'DAP UI toggle' })
map('n', '<leader>dl', function() require('dap').run_last() end, { desc = 'DAP run last' })
map('n', '<leader>dr', function() require('dap').repl.open() end, { desc = 'DAP REPL' })
