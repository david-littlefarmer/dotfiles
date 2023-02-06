-- https://github.com/echasnovski/mini.base16
-- Fast implementation of chriskempson/base16 theme for manually supplied palette
return
{
    {
        'echasnovski/mini.base16',
        lazy = false,   -- make sure we load this during startup if it is your main colorscheme
        priority = 998, -- make sure to load this before all the other start plugins
        version = '*',
        opts = {
            -- Table with names from `base00` to `base0F` and values being strings of
            -- HEX colors with format "#RRGGBB". NOTE: this should be explicitly
            -- supplied in `setup()`.
            palette = {
                base00 = '#181818',
                base01 = '#282828',
                base02 = '#383838',
                base03 = '#585858',
                base04 = '#b8b8b8',
                base05 = '#d8d8d8',
                base06 = '#e8e8e8',
                base07 = '#f8f8f8',
                base08 = '#ab4642',
                base09 = '#dc9656',
                base0A = '#f7ca88',
                base0B = '#a1b56c',
                base0C = '#86c1b9',
                base0D = '#7cafc2',
                base0E = '#ba8baf',
                base0F = '#a16946'
            },

            -- Whether to support cterm colors. Can be boolean, `nil` (same as
            -- `false`), or table with cterm colors. See `setup()` documentation for
            -- more information.
            use_cterm = true,

            -- Plugin integrations. Use `default = false` to disable all integrations.
            -- Also can be set per plugin (see |MiniBase16.config|).
            plugins = { default = true },
        },

        config = function(_, opts)
            require('mini.base16').setup(opts)
        end,
    },
}
