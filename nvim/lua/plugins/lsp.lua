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
            schemaStore = { enable = true },
        },
    },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim', 'require' } },
        },
    },
    rust_analyzer = {},
}

require('mason').setup({
    ui = {
        icons = {
            package_installed = 'I',
            package_pending = 'P',
            package_uninstalled = 'X',
        },
    },
})

require('mason-lspconfig').setup({
    ensure_installed = vim.tbl_keys(servers),
    automatic_enable = false,
})

require('mason-tool-installer').setup({
    ensure_installed = {
        'prettier',
        'stylua',
        'isort',
        'black',
        'pylint',
        'eslint_d',
        'shellcheck',
        'tree-sitter-cli',
    },
})

local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('blink.cmp').get_lsp_capabilities({}, false)
)
capabilities.workspace.didChangeConfiguration = { dynamicRegistration = true }

vim.lsp.config('*', { capabilities = capabilities })

for name, settings in pairs(servers) do
    vim.lsp.config(name, { settings = settings })
end

vim.lsp.config('taplo', {
    cmd = { 'taplo', 'lsp', '-c', vim.fs.joinpath(vim.fn.stdpath('config'), 'taplo.toml'), 'stdio' },
})

vim.lsp.enable(vim.tbl_keys(servers))

require('ridl').setup({ capabilities = capabilities })

local format = function(bufnr)
    vim.lsp.buf.format({ bufnr = bufnr, async = false, timeout_ms = 2000 })
end

local format_group = vim.api.nvim_create_augroup('LspFormatOnSave', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspAttachSetup', { clear = true }),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        local bufnr = ev.buf
        local map = function(keys, fn, desc)
            vim.keymap.set('n', keys, fn, { buffer = bufnr, desc = desc })
        end

        map('gd', vim.lsp.buf.definition, 'Goto definition')
        map('grr', require('telescope.builtin').lsp_references, 'References (Telescope)')
        map('<leader>f', function() format(bufnr) end, 'Format buffer')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document symbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')

        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function() format(bufnr) end,
            { desc = 'Format current buffer with LSP' })

        if client:supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = format_group,
                buffer = bufnr,
                callback = function() format(bufnr) end,
            })
        end
    end,
})
