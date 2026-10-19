require('flexoki').setup({})
vim.cmd.colorscheme('flexoki-dark')

local colors = {
    black     = '#181818',
    darkgray  = '#282828',
    gray      = '#383838',
    white     = '#d8d8d8',
    green     = '#a1b56c',
    blue      = '#7cafc2',
    magenta   = '#ba8baf',
    orange    = '#dc9656',
}

local function mode(bg)
    return {
        a = { bg = bg, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.white },
    }
end

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = {
            normal = mode(colors.blue),
            insert = mode(colors.green),
            visual = mode(colors.magenta),
            replace = mode(colors.orange),
            command = mode(colors.green),
            inactive = {
                a = { bg = colors.darkgray, fg = colors.gray, gui = 'bold' },
                b = { bg = colors.gray, fg = colors.white },
                c = { bg = colors.darkgray, fg = colors.white },
            },
        },
        component_separators = '|',
        section_separators = '',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            'branch',
            {
                'diff',
                colored = true,
                diff_color = { added = 'DiffAdd', modified = 'DiffChange', removed = 'DiffDelete' },
            },
            'diagnostics',
        },
        lualine_c = { 'filename', 'filesize' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location', 'selectioncount' },
    },
})

require('noice').setup({
    lsp = {
        override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
        },
    },
    presets = { bottom_search = true },
    routes = {
        { view = 'mini', filter = { event = 'msg_showmode' } },
    },
    views = {
        cmdline_popup = {
            position = { row = 5, col = '50%' },
            size = { width = 60, height = 'auto' },
        },
        popupmenu = {
            relative = 'editor',
            position = { row = 8, col = '50%' },
            size = { width = 60, height = 10 },
            border = { style = 'rounded', padding = { 0, 1 } },
            win_options = { winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' } },
        },
    },
})

require('which-key').setup({})
require('which-key').add({
    { 'gr', group = 'LSP' },
    { '<leader>s', group = 'Search / split' },
    { '<leader>d', group = 'Debug' },
    { '<leader>x', group = 'Trouble' },
    { '<leader>t', group = 'Tabs / tree' },
    { '<leader>gp', group = 'Go playground' },
})

require('ibl').setup()

require('trouble').setup({})
local map = vim.keymap.set
map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
map('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer diagnostics (Trouble)' })
map('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
map('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'LSP (Trouble)' })
map('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location list (Trouble)' })
map('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix list (Trouble)' })

require('todo-comments').setup({
    keywords = {
        FIX = { icon = 'F', color = 'fix', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
        TODO = { icon = 'T', color = 'todo' },
        WARN = { icon = 'W', color = 'warn', alt = { 'WARNING', 'XXX' } },
        NOTE = { icon = 'N', color = 'note', alt = { 'INFO' } },
        PERF = { icon = 'P', color = 'perf', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        TEST = { icon = 't', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
    },
    colors = {
        fix = { '#AB4642' },
        todo = { '#A1B56C' },
        warn = { '#F7CA88' },
        note = { '#7CAFC2' },
        perf = { '#DC9656' },
        test = { '#BA8BAF' },
        default = { '#E8E8E8' },
    },
    gui_style = { fg = 'NONE', bg = 'NONE' },
})

require('neo-tree').setup({
    default_component_configs = {
        git_status = {
            symbols = {
                added = 'A', modified = 'M', deleted = 'D', renamed = 'R',
                untracked = '?', ignored = 'I', unstaged = 'U', staged = 'S', conflict = 'C',
            },
        },
    },
    window = {
        mappings = {
            ['<tab>'] = { 'toggle_preview', config = { use_float = false } },
        },
    },
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
        },
    },
})
