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
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        local servers = {
            sqlls = {},
            bashls = {},
            clangd = {},
            cssls = {},
            html = {},
            pyright = {},
            taplo = {},
            yamlls = {
                yaml = {
                    -- suppresses the harmless "registerCapability despite dynamicRegistration=false" warning
                    schemaStore = { enable = true },
                },
            },
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    runtime = { version = 'LuaJIT' },
                    diagnostics = {
                        globals = { 'vim', 'require' },
                    },
                },
            },
            rust_analyzer = {},
        }

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        mason_tool_installer.setup({
            ensure_installed = {
                'prettier',  -- prettier formatter
                'stylua',    -- lua formatter
                'isort',     -- python formatter
                'black',     -- python formatter
                'pylint',    -- python linter
                'eslint_d',  -- js linter
                'shellcheck', -- bash linter (required by bash-language-server)
            },
        })

        -- cmp_nvim_lsp.default_capabilities() returns its own table rather than
        -- merging into the one passed in, so deep-merge explicitly or fields
        -- like `workspace` from make_client_capabilities() get dropped.
        local capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
        )
        -- suppress yamlls registerCapability warning
        capabilities.workspace.didChangeConfiguration = { dynamicRegistration = true }

        -- mason-lspconfig v2 dropped setup_handlers()/handlers in favor of the
        -- native vim.lsp.config() API; mason's `automatic_enable` (on by default)
        -- then calls vim.lsp.enable() for whatever's installed.
        for server_name, settings in pairs(servers) do
            vim.lsp.config(server_name, {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = settings,
            })
        end

        -- ridl_lsp is started by the ridl.nvim plugin itself (see plugins/ridl.lua),
        -- not through Mason/lspconfig.

        -- taplo (TOML) ships with align_entries/indent_entries off by default,
        -- so `key = value` pairs land unaligned and unindented under a table
        -- header. -c pins a personal default (nvim/taplo.toml, next to this
        -- file) so every TOML buffer formats consistently regardless of
        -- whether the project ships its own .taplo.toml — an explicit -c wins
        -- outright over taplo's own auto-discovery, so a project's own config
        -- would need this override dropped to take effect instead.
        local taplo_config = vim.fs.joinpath(vim.fn.stdpath('config'), 'taplo.toml')
        vim.lsp.config('taplo', {
            cmd = { 'taplo', 'lsp', '-c', taplo_config, 'stdio' },
        })

        -- Format-on-save for TOML specifically (taplo's LSP formatter is
        -- otherwise only reachable via the :Format command from on_attach
        -- above; none-ls's own BufWritePre hook doesn't cover TOML).
        local toml_format_augroup = vim.api.nvim_create_augroup('TaploFormatting', {})
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = toml_format_augroup,
            pattern = '*',
            callback = function(args)
                -- filetype-based, not '*.toml' pattern-based: TOML-shaped
                -- files without a .toml extension (e.g. bpn-api's etc/*.conf,
                -- see core/filetype.lua) still get formatted.
                if vim.bo[args.buf].filetype ~= 'toml' then
                    return
                end
                vim.lsp.buf.format({ bufnr = args.buf, async = false, timeout_ms = 2000 })
            end,
        })
    end,
}
