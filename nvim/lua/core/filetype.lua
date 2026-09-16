-- *.conf files are ambiguous: nginx/ssh-style configs vs TOML (e.g. bpn-api's
-- etc/*.conf, OMSX's omsx.conf). Sniff the content instead of hardcoding paths,
-- so it works across projects. Falls through to Neovim's default "conf" ft
-- when nothing TOML-shaped is found.
vim.filetype.add({
    pattern = {
        ['.*%.conf'] = function(_, bufnr)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, 20, false)) do
                local trimmed = line:match('^%s*(.-)%s*$')
                if trimmed:match('^%[[%w_.%-]+%]$') or trimmed:match('^[%w_.%-]+%s*=%s*%S.*$') then
                    return 'toml'
                end
            end
        end,
    },
})
