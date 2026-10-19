local null_ls = require('null-ls')

local ridlfmt = {
    name = 'ridlfmt',
    filetypes = { 'ridl' },
    method = null_ls.methods.FORMATTING,
    generator = null_ls.formatter({
        command = 'ridlfmt',
        args = { '-s' },
        to_stdin = true,
        from_stderr = true,
    }),
}

local sources = {
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines.with({ extra_args = { '--max-len=300' } }),
    ridlfmt,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.sqlfmt,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.prettier.with({
        filetypes = {
            'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'css', 'scss', 'less',
            'html', 'json', 'jsonc', 'markdown', 'markdown.mdx', 'graphql', 'handlebars',
        },
    }),
    null_ls.builtins.diagnostics.solhint,
}

if vim.fn.executable('forge') == 1 then
    table.insert(sources, null_ls.builtins.formatting.forge_fmt)
end

null_ls.setup({ sources = sources })

require('dbee').setup({
    sources = {
        require('dbee.sources').MemorySource:new({
            { name = 'devbox', type = 'postgres', url = 'postgres:postgres@localhost:5432' },
        }),
        require('dbee.sources').FileSource:new(vim.fn.stdpath('cache') .. '/dbee/persistence.json'),
    },
})
