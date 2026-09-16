-- https://github.com/rebelot/kanagawa.nvim
-- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
return {

	-- "RRethy/base16-nvim",
	--
	-- opts = {
	-- 	telescope = true,
	-- 	indentblankline = true,
	-- 	notify = true,
	-- 	ts_rainbow = true,
	-- 	cmp = true,
	-- 	illuminate = true,
	-- 	dapui = true,
	-- },
	--
	-- config = function()
	--     vim.cmd("colorscheme base16-default-dark")
	-- end,

	"kepano/flexoki-neovim",
	name = "flexoki",

	opts = {},

	config = function()
		require("flexoki").setup(opts)
		vim.cmd("colorscheme flexoki-dark")
	end,

	-- "rebelot/kanagawa.nvim",
	-- opts = {        -- this is equalent to setup({}) function
	--     compile = false, -- enable compiling the colorscheme
	--     undercurl = true, -- enable undercurls
	--     commentStyle = { italic = true },
	--     functionStyle = {},
	--     keywordStyle = { italic = true },
	--     statementStyle = { bold = true },
	--     typeStyle = {},
	--     transparent = false, -- do not set background color
	--     dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	--     terminalColors = true, -- define vim.g.terminal_color_{0,17}
	--     colors = {       -- add/modify theme and palette colors
	--         palette = {},
	--         theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	--     },
	--     overrides = function(colors) -- add/modify highlights
	--         return {}
	--     end,
	--     theme = "wave", -- Load "wave" theme
	--     background = { -- map the value of 'background' option to a theme
	--         dark = "dragon", -- try "dragon" !
	--         light = "lotus",
	--     },
	-- },
	--
	-- config = function()
	--     require("kanagawa").setup(opts)
	--     vim.cmd("colorscheme kanagawa-dragon")
	-- end,
}
