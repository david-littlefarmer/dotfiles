return {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    {
        'leoluz/nvim-dap-go',
        ft = 'go',
        dependencies = 'mfussenegger/nvim-dap',
        config = function(_, opts)
            require('dap-go').setup(opts)
        end
    },
}
