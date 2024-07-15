-- https://github.com/iamcco/markdown-preview.nvim
-- Preview Markdown in your modern browser with synchronised scrolling and flexible configuration.
return {
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        build = function() vim.fn['mkdp#util#install']() end,
    },
    {
        "OXY2DEV/markview.nvim",
        ft = { "markdown" },
        dependencies = {
            -- You may not need this if you don't lazy load
            -- Or if the parsers are in your $RUNTIMEPATH
            "nvim-treesitter/nvim-treesitter",

            "nvim-tree/nvim-web-devicons"
        },

        opts = {}
    }
}
