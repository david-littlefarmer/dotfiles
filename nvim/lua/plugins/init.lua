local function gh(repo) return 'https://github.com/' .. repo end

local builds = {
    ['telescope-fzf-native.nvim'] = function(ev)
        vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    end,
    ['LuaSnip'] = function(ev)
        vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path }):wait()
    end,
    ['nvim-treesitter'] = function(ev)
        if ev.data.kind ~= 'update' then return end
        if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
        require('nvim-treesitter').update():wait(300000)
    end,
    ['markdown-preview.nvim'] = function(ev)
        if not ev.data.active then vim.cmd.packadd('markdown-preview.nvim') end
        vim.fn['mkdp#util#install']()
    end,
    ['nvim-dbee'] = function(ev)
        if not ev.data.active then
            vim.cmd.packadd('nui.nvim')
            vim.cmd.packadd('nvim-dbee')
        end
        require('dbee').install()
    end,
    ['go.nvim'] = function(ev)
        if ev.data.kind ~= 'update' then return end
        if not ev.data.active then vim.cmd.packadd('go.nvim') end
        require('go.install').update_all_sync()
    end,
}

vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('PackBuild', { clear = true }),
    callback = function(ev)
        if ev.data.kind == 'delete' then return end
        local build = builds[ev.data.spec.name]
        if not build then return end
        local ok, err = pcall(build, ev)
        if not ok then vim.notify(('build %s: %s'):format(ev.data.spec.name, err), vim.log.levels.WARN) end
    end,
})

vim.pack.add({
    -- libraries
    gh('nvim-lua/plenary.nvim'),
    gh('MunifTanjim/nui.nvim'),
    gh('nvim-tree/nvim-web-devicons'),
    gh('nvim-neotest/nvim-nio'),
    gh('lewis6991/async.nvim'),

    -- ui
    gh('kepano/flexoki-neovim'),
    gh('nvim-lualine/lualine.nvim'),
    gh('rcarriga/nvim-notify'),
    gh('folke/noice.nvim'),
    gh('folke/which-key.nvim'),
    gh('folke/trouble.nvim'),
    gh('folke/todo-comments.nvim'),
    gh('lukas-reineke/indent-blankline.nvim'),
    { src = gh('nvim-neo-tree/neo-tree.nvim'), version = 'v3.x' },

    -- lsp, completion, formatting
    gh('neovim/nvim-lspconfig'),
    gh('mason-org/mason.nvim'),
    gh('mason-org/mason-lspconfig.nvim'),
    gh('WhoIsSethDaniel/mason-tool-installer.nvim'),
    gh('nvimtools/none-ls.nvim'),
    { src = gh('L3MON4D3/LuaSnip'), version = vim.version.range('2.*') },
    gh('rafamadriz/friendly-snippets'),
    { src = gh('saghen/blink.cmp'), version = vim.version.range('1.*') },
    gh('folke/lazydev.nvim'),

    -- treesitter
    { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },
    { src = gh('nvim-treesitter/nvim-treesitter-textobjects'), version = 'main' },

    -- finder
    gh('nvim-telescope/telescope.nvim'),
    gh('nvim-telescope/telescope-fzf-native.nvim'),
    gh('ThePrimeagen/refactoring.nvim'),

    -- git
    gh('lewis6991/gitsigns.nvim'),
    gh('tpope/vim-fugitive'),
    gh('sindrets/diffview.nvim'),

    -- editing
    { src = gh('echasnovski/mini.nvim'), version = vim.version.range('*') },
    gh('kylechui/nvim-surround'),
    gh('folke/flash.nvim'),
    gh('johmsalas/text-case.nvim'),
    gh('aserowy/tmux.nvim'),

    -- go + dap
    gh('ray-x/guihua.lua'),
    gh('ray-x/go.nvim'),
    gh('jeniasaigak/goplay.nvim'),
    gh('mfussenegger/nvim-dap'),
    gh('rcarriga/nvim-dap-ui'),
    gh('theHamsta/nvim-dap-virtual-text'),
    gh('leoluz/nvim-dap-go'),

    -- tools
    gh('kndndrj/nvim-dbee'),
    gh('iamcco/markdown-preview.nvim'),
    gh('greggh/claude-code.nvim'),
}, { confirm = false })

vim.opt.rtp:prepend('/home/dsedlacek/dev/david-littlefarmer/ridl.nvim')

require('plugins.ui')
require('plugins.completion')
require('plugins.lsp')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.git')
require('plugins.editing')
require('plugins.go')
require('plugins.tools')
