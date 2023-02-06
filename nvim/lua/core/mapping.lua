vim.g.mapleader = ' '

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local keymaps = function(_, bufnr)
    local nmap = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    local vmap = function(keys, func, desc)
        vim.keymap.set('v', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>f', vim.lsp.buf.format, '[F]ormat document')

    vmap('J', ":m '>+1<CR>gv=gv", 'Move lines up')
    vmap('K', ":m '<-2<CR>gv=gv", 'Move lines down')

    nmap('J', 'mzJ`z', 'Append bellow line to EOL')


    nmap('<C-d>', '<C-d>zz')
    nmap('<C-u>', '<C-u>zz')
    nmap('n', 'nzzzv', 'Next search with centering')
    nmap('N', 'Nzzzv', 'Previous search with centering')
    nmap('<C-k>', '<cmd>cnext<CR>zz')
    nmap('<C-j>', '<cmd>cprev<CR>zz')
    nmap('<leader>k', '<cmd>lnext<CR>zz')
    nmap('<leader>j', '<cmd>lprev<CR>zz')

    nmap('<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], 'Substitute for current word')
    nmap('<leader>x', '<cmd>!chmod +x %<CR>', 'chmod +x for current file')

    nmap('<leader>tt', ':Neotree<CR>', 'Neotree')


    nmap('<leader>vwm', function()
        require('vim-with-me').StartVimWithMe()
    end)

    nmap('<leader>svwm', function()
        require('vim-with-me').StopVimWithMe()
    end)

    nmap('<F5>', ':lua require"dap".continue()<CR>')
    nmap('<S-F5>', ':lua require"dap".restart()<CR>')
    nmap('<C-S-F5>', ':lua require"dap".terminate()<CR>')
    nmap('<F10>', ':lua require"dap".step_over()<CR>')
    nmap('<F11>', ':lua require"dap".step_into()<CR>')
    nmap('<S-F11>', ':lua require"dap".step_out()<CR>')
    nmap('<leader>b', ':lua require"dap".toggle_breakpoint()<CR>')
    nmap('<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
    nmap('<leader>dT', ':lua require("dap-go").debug_test()<CR>')
    nmap('<leader>dt', ':lua require("dapui").toggle()<CR>')
    nmap('<leader>dl', ':lua require"dap".run_last()<CR>')
    nmap('<leader>dr', ':lua require"dap".repl.open()<CR>')
    nmap('<leader>hb', ':Gitsigns blame_line<CR>')


    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<leader>K', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    nmap('[d', vim.diagnostic.goto_prev)
    nmap(']d', vim.diagnostic.goto_next)
    nmap('<leader>e', vim.diagnostic.open_float)
    nmap('<leader>q', vim.diagnostic.setloclist)
end

keymaps()
