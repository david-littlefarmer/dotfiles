-- https://github.com/mrjones2014/legendary.nvim
-- Define your keymaps, commands, and autocommands as simple Lua tables, building a legend at the same time (like VS Code's Command Palette).
return {
    'mrjones2014/legendary.nvim',
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    opts = {
        extensions = {
            lazy_nvim = {
                auto_register = true
            },
        }
    },
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
}
