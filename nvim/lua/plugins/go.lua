require('go').setup({
    gopls_cmd = vim.fn.executable('gopls') == 1 and { vim.fn.exepath('gopls') } or nil,
    textobjects = false,
    lsp_keymaps = false,
    lsp_codelens = true,
    lsp_inlay_hints = {
        enable = true,
        style = 'eol',
        other_hints_prefix = '=>',
    },
    lsp_cfg = {
        settings = {
            gopls = {
                analyses = {
                    ST1003 = true,
                    unusedwrite = true,
                    useany = true,
                    unusedparams = true,
                    loopclosure = true,
                    shadow = false,
                    fieldalignment = false,
                },
                staticcheck = true,
                env = { GOTOOLCHAIN = 'auto' },
                codelenses = {
                    gc_details = true,
                    generate = true,
                    test = true,
                    tidy = true,
                    upgrade_dependency = true,
                },
            },
        },
    },
    diagnostic = {
        underline = true,
        update_in_insert = true,
    },
    dap_debug = true,
    dap_debug_ui = {
        defaults = {
            fallback = {
                external_terminal = {
                    command = '/usr/bin/alacritty',
                    args = { '-e' },
                },
            },
        },
    },
})

require('dap-go').setup()
require('nvim-dap-virtual-text').setup()

require('goplay').setup({})
local map = vim.keymap.set
map('n', '<leader>gpt', '<cmd>GPToggle<cr>', { desc = 'Go playground toggle' })
map('n', '<leader>gpo', '<cmd>GPOpen<cr>', { desc = 'Go playground open' })
map('n', '<leader>gpc', '<cmd>GPClose<cr>', { desc = 'Go playground close' })
map('n', '<leader>gpe', '<cmd>GPExec<cr>', { desc = 'Go playground exec' })
map('n', '<leader>gpf', '<cmd>GPExecFile<cr>', { desc = 'Go playground exec file' })
map('n', '<leader>gpC', '<cmd>GPClear<cr>', { desc = 'Go playground clear' })
