-- https://github.com/williamboman/mason.nvim
-- Portable package manager for Neovim that runs everywhere Neovim runs.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters.
return {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'stevearc/dressing.nvim'
    },
    config = function()
        local mason = require('mason')
        local mason_lspconfig = require('mason-lspconfig')
        local mason_tool_installer = require('mason-tool-installer')

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = 'I',
                    package_pending = 'P',
                    package_uninstalled = 'X',
                },
            },
        })


        local on_attach = function(_, bufnr)
            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        local servers = {
            sqlls = {},
            bashls = {},
            clangd = {},
            -- jsonls = {},
            cssls = {},
            html = {},
            -- tsserver = {},
            pyright = {},
            taplo = {},
            yamlls = {},
            lua_ls = {
                Lua = {
                    workspace = {
                        checkThirdParty = false
                    },
                    telemetry = {
                        enable = false
                    },
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {
                            'vim',
                            'require'
                        },
                    },
                },
            },
            rust_analyzer = {},
        }

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true, -- not the same as ensure_installed
        }

        mason_tool_installer.setup({
            ensure_installed = {
                'prettier', -- prettier formatter
                'stylua',   -- lua formatter
                'isort',    -- python formatter
                'black',    -- python formatter
                'pylint',   -- python linter
                'eslint_d', -- js linter
            },
        })

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                }
            end,
        }
    end,
}
