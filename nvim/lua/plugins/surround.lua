-- https://github.com/kylechui/nvim-surround
-- Surround selections, stylishly 😎
return {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function()
        require('nvim-surround').setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
}
