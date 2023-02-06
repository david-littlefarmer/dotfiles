-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
-- null-ls is now archived and will no longer receive updates. Please see this issue for details.
return {
    'nvimtools/none-ls.nvim',
    config = function()
        local null_ls = require('null-ls')
        local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
        local opts = {
            sources = {
                -- Go
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.formatting.goimports_reviser,
                null_ls.builtins.formatting.golines.with({
                    extra_args = {
                        '--max-len=300',
                    },
                }),
                -- null_ls.builtins.diagnostics.revive,

                -- Bash
                null_ls.builtins.formatting.shfmt,

                -- SQL
                null_ls.builtins.formatting.sqlfmt,

                -- Git
                null_ls.builtins.code_actions.gitsigns,

                -- Yaml
                -- null_ls.builtins.diagnostics.yamllint,

                -- JS, TS
                null_ls.builtins.formatting.prettier.with({
                    extra_args = function(_)
                        if vim.fs.dirname(vim.fs.find({ '.prettierrc', '.prettierrc.js' }, { upward = true })[1]) then
                            return nil
                        end

                        return {} -- your extra args
                    end,

                    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "json", "jsonc", "markdown", "markdown.mdx", "graphql", "handlebars" }
                }),

                -- null_ls.builtins.code_actions.eslint_d,

                -- null_ls.builtins.diagnostics.jsonlint,

                null_ls.builtins.formatting.tidy,
            },

            on_attach = function(client, bufnr)
                if client.supports_method('textDocument/formatting') then
                    vim.api.nvim_clear_autocmds({
                        group = augroup,
                        buffer = bufnr,
                    })
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            -- vim.lsp.buf.format({ bufnr = bufnr })
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end
        }

        null_ls.setup(opts)
    end
}
