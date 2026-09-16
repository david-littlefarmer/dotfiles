-- https://github.com/folke/lazydev.nvim
-- Faster LuaLS setup for Neovim (replaces neodev.nvim)
return {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
        library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
    },
}
