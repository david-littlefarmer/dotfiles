-- Local checkout of https://github.com/david-littlefarmer/ridl.nvim, being
-- reworked to bundle :syntax highlighting + a managed ridl-lsp client, in the
-- same shape as https://github.com/webrpc/ridl-vscode. `dir` points at the
-- local checkout (instead of a GitHub url) so it can be tried here before
-- anything is pushed/published.
return {
    dir = '/home/dsedlacek/dev/david-littlefarmer/ridl.nvim',
    name = 'ridl.nvim',
    config = function()
        -- cmp_nvim_lsp.default_capabilities() returns its own table rather than
        -- merging into the one passed in, so deep-merge explicitly (see plugins/mason.lua).
        local capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
        )

        require('ridl').setup({
            capabilities = capabilities,
            on_attach = function(_, bufnr)
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
            end,
        })
    end,
}
