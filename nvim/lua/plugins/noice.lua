-- https://github.com/folke/noice.nvim
-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
return {
    'folke/noice.nvim',
    -- event = 'VeryLazy',
    opts = {
        lsp = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
        },
        presets = {
            bottom_search = true,
        },
        routes = {
            {
                view = 'mini',
                filter = { event = 'msg_showmode' },
            },
        },
        views = {
            cmdline_popup = {
                position = {
                    row = 5,
                    col = '50%',
                },
                size = {
                    width = 60,
                    height = 'auto',
                },
            },
            popupmenu = {
                relative = 'editor',
                position = {
                    row = 8,
                    col = '50%',
                },
                size = {
                    width = 60,
                    height = 10,
                },
                border = {
                    style = 'rounded',
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
                },
            },
        },
    },
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
        'nvim-lualine/lualine.nvim',
    }
}
