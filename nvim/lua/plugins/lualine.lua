-- https://github.com/nvim-lualine/lualine.nvim
-- A blazing fast and easy to configure Neovim statusline written in Lua.

local colors = {
    black     = '#181818',
    darkgray  = '#282828',
    gray      = '#383838',
    lightgray = '#b8b8b8',
    white     = '#d8d8d8',
    red       = '#ab4642',
    green     = '#a1b56c',
    yellow    = '#f7ca88',
    blue      = '#7cafc2',
    magenta   = '#ba8baf',
    cyan      = '#86c1b9',
    orange    = '#dc9656',
    brown     = '#a16946',
}

local theme = {
    normal = {
        a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.white }
    },
    insert = {
        a = { bg = colors.green, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.white }
    },
    visual = {
        a = { bg = colors.magenta, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.white }
    },
    replace = {
        a = { bg = colors.orange, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.white }
    },
    command = {
        a = { bg = colors.green, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.white }
    },
    inactive = {
        a = { bg = colors.darkgray, fg = colors.gray, gui = 'bold' },
        b = { bg = colors.gray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.white }
    }
}

return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = theme,
            component_separators = '|',
            section_separators = '',
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                'branch',
                {
                    'diff',
                    colored    = true,
                    diff_color = {
                        added    = 'DiffAdd',    -- Changes the diff's added color
                        modified = 'DiffChange', -- Changes the diff's modified color
                        removed  = 'DiffDelete', -- Changes the diff's removed color you
                    },
                },
                'diagnostics',
            },
            lualine_c = { 'filename', 'filesize' },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location', 'selectioncount', }
        },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    priority = 999,
    config = function(_, opts)
        require('lualine').setup(opts)
    end,
}
