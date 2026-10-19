local augroup = vim.api.nvim_create_augroup

vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup('YankHighlight', { clear = true }),
    callback = function() vim.hl.hl_op() end,
})

vim.api.nvim_create_autocmd('User', {
    group = augroup('TelescopePreviewNumbers', { clear = true }),
    pattern = 'TelescopePreviewerLoaded',
    command = 'setlocal number',
})
