return {
    -- https://github.com/ray-x/go.nvim
    -- A modern go neovim plugin based on treesitter, nvim-lsp and dap debugger. It is written in Lua and async as much as possible. PR & Suggestions are welcome.
    {
        'ray-x/go.nvim',
        dependencies = {
            'ray-x/guihua.lua',
            'neovim/nvim-lspconfig',
            'nvim-treesitter/nvim-treesitter',
        },
        event = { 'CmdlineEnter' },
        ft = { 'go', 'gomod' },
        build = ':lua require("go.install").update_all_sync()',
        opts = {
            -- asdf shim for gopls doesn't resolve inside nvim's env; use GOBIN directly
            gopls_cmd = (function()
                local gobin = vim.fn.trim(vim.fn.system('go env GOBIN 2>/dev/null'))
                local bin = gobin ~= '' and (gobin .. '/gopls') or ''
                return (bin ~= '' and vim.fn.executable(bin) == 1) and { bin } or nil
            end)(),
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
                        -- lets gopls use the right toolchain for Go 1.26 features (new pointer patterns, iter, etc.)
                        env = {
                            GOTOOLCHAIN = 'auto',
                        },
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
            }
        },
    },

    -- https://github.com/jeniasaigak/goplay.nvim
    -- goplay.nvim is a local go playground for Neovim. Goplay.nvim uses locally installed Go tool to prepare and run the code from the playground.
    {
        'jeniasaigak/goplay.nvim',
        opts = {},
        keys = {
            { '<leader>gpt', mode = 'n', function() vim.api.nvim_command(':GPToggle') end,   desc = 'Go Playground Toggle',    noremap = true, silent = true },
            { '<leader>gpo', mode = 'n', function() vim.api.nvim_command(':GPOpen') end,     desc = 'Go Playground Open',      noremap = true, silent = true },
            { '<leader>gpc', mode = 'n', function() vim.api.nvim_command(':GPClose') end,    desc = 'Go Playground Close',     noremap = true, silent = true },
            { '<leader>gpe', mode = 'n', function() vim.api.nvim_command(':GPExec') end,     desc = 'Go Playground Exec',      noremap = true, silent = true },
            { '<leader>gpf', mode = 'n', function() vim.api.nvim_command(':GPExecFile') end, desc = 'Go Playground Exec File', noremap = true, silent = true },
            { '<leader>gpC', mode = 'n', function() vim.api.nvim_command(':GPClear') end,    desc = 'Go Playground Clear',     noremap = true, silent = true },
        },
    }
}
