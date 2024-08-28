-- External dependencies: luarocks, ripgrep, npm, composer

-- Neovim options
vim.g.mapleader = ' '
vim.o.autochdir = true
vim.o.clipboard = 'unnamedplus'
vim.o.colorcolumn = '80'
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.mouse = '';
vim.o.number = true
vim.o.pumheight = 10
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 4
vim.o.updatetime = 1000
vim.o.wrap = false

-- Neovim keymaps
vim.keymap.set('v', '<c-up>', ':m \'<-2\ngv=gv')
vim.keymap.set('v', '<c-down>', ':m \'>+1\ngv=gv')
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')

-- File formatter
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        vim.cmd('silent! %s/\r//g')
        vim.bo.fileformat = 'unix'
        vim.cmd('silent! retab')
    end
})

-- Auto highlight
vim.api.nvim_create_autocmd('InsertEnter', {
    callback = function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(
            '<cmd>silent! nohlsearch\n', true, true, true), 'n', true)
    end
})

-- Language servers
local servers = {
    'bashls',
    'clangd',
    'cmake',
    'cssls',
    'emmet_language_server',
    'html',
    'jdtls',
    'lua_ls',
    'omnisharp',
    'phpactor',
    'pyright',
    'rust_analyzer',
    'tsserver'
}

-- Language servers options
local servers_opts = {
    clangd = { cmd = { 'clangd', '--header-insertion=never' } },
    lua_ls = { settings = { Lua = { diagnostics = { globals = { 'vim' } } } } }
}

-- Diagnostics options
vim.diagnostic.config({
    update_in_insert = true,
    float = { border = 'rounded' }
})
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    focusable = false,
    border = 'rounded'
})

-- Hover diagnostics
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    callback = function()
        if not require('cmp').visible() and
            not vim.diagnostic.open_float({ focusable = false }) then
            vim.lsp.buf.hover()
        end
    end
})

-- folke/lazy.nvim
if vim.fn.isdirectory(vim.fn.stdpath('data') .. '/lazy/lazy.nvim') then
    vim.fn.system({
        'git',
        'clone',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    })
end
vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/lazy/lazy.nvim')

require('lazy').setup(
    {
        {
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim'
        },
        {
            'folke/tokyonight.nvim',
            'nvimdev/dashboard-nvim',
            'nvim-lualine/lualine.nvim',
            'romgrk/barbar.nvim',
            'shortcuts/no-neck-pain.nvim',
            'arnamak/stay-centered.nvim',
            'lukas-reineke/indent-blankline.nvim'
        },
        {
            'windwp/nvim-autopairs',
            'kylechui/nvim-surround',
            'numToStr/Comment.nvim'
        },
        {
            'nvim-telescope/telescope.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'lewis6991/gitsigns.nvim'
        },
        {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'ray-x/lsp_signature.nvim'
        },
        {
            'L3MON4D3/LuaSnip',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-path'
        },
        {
            'tpope/vim-dadbod',
            'kristijanhusak/vim-dadbod-ui',
            'kristijanhusak/vim-dadbod-completion'
        },
        {
            'folke/which-key.nvim'
        }
    },
    {
        ui = { border = 'rounded' }
    }
)

-- folke/tokyonight.nvim
require('tokyonight').setup({ style = 'night', transparent = true })
vim.cmd('colorscheme tokyonight')

-- nvimdev/dashboard-nvim
require('dashboard').setup({
    config = {
        header = {
            ' ██████   █████                   █████   █████  ███                 ',
            '░░██████ ░░███                   ░░███   ░░███  ░░░                  ',
            ' ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████  ',
            ' ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███ ',
            ' ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███ ',
            ' ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███ ',
            ' █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████',
            '░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ ',
            '                                                                     '
        },
        shortcut = {
            {
                icon = ' ',
                desc = 'New',
                key = 'n',
                action = 'enew'
            },
            {
                icon = ' ',
                desc = 'Open',
                key = 'o',
                action = 'Telescope file_browser'
            },
            {
                icon = ' ',
                desc = 'DB',
                key = 'd',
                action = 'bdelete | DBUI'
            },
            {
                icon = ' ',
                desc = 'Update',
                key = 'u',
                action = 'Lazy update | MasonUpdate'
            },
            {
                icon = ' ',
                desc = 'Config',
                key = 'c',
                action = 'edit ' .. vim.fn.stdpath('config') .. '/init.lua'
            },
            {
                icon = '󰩈 ',
                desc = 'Quit',
                key = 'q',
                action = 'quit'
            }
        },
        packages = { enable = false },
        project = { limit = 10 },
        mru = { limit = 10 },
        footer = {
            '                         ',
            '"Keep it simple, stupid!"'
        }
    }
})

-- nvim-lualine/lualine.nvim
require('lualine').setup({
    options = {
        disabled_filetypes = { 'dashboard' },
        globalstatus = true
    }
})

-- romgrk/barbar.nvim
require('barbar').setup({
    animation = false,
    focus_on_close = 'previous',
    icons = {
        buffer_index = true,
        button = '',
        diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = true },
            [vim.diagnostic.severity.WARN] = { enabled = true },
            [vim.diagnostic.severity.INFO] = { enabled = true },
            [vim.diagnostic.severity.HINT] = { enabled = true }
        },
        gitsigns = {
            added = { enabled = true },
            changed = { enabled = true },
            deleted = { enabled = true }
        },
        separator = { left = '[', right = ']' },
        modified = { button = '' }
    }
})

vim.keymap.set('n', '<a-,>', ':BufferPrevious\n', { silent = true })
vim.keymap.set('n', '<a-.>', ':BufferNext\n', { silent = true })
vim.keymap.set('n', '<a-<>', ':BufferMovePrevious\n', { silent = true })
vim.keymap.set('n', '<a->>', ':BufferMoveNext\n', { silent = true })
vim.keymap.set('n', '<a-1>', ':BufferGoto 1\n', { silent = true })
vim.keymap.set('n', '<a-2>', ':BufferGoto 2\n', { silent = true })
vim.keymap.set('n', '<a-3>', ':BufferGoto 3\n', { silent = true })
vim.keymap.set('n', '<a-4>', ':BufferGoto 4\n', { silent = true })
vim.keymap.set('n', '<a-5>', ':BufferGoto 5\n', { silent = true })
vim.keymap.set('n', '<a-6>', ':BufferGoto 6\n', { silent = true })
vim.keymap.set('n', '<a-7>', ':BufferGoto 7\n', { silent = true })
vim.keymap.set('n', '<a-8>', ':BufferGoto 8\n', { silent = true })
vim.keymap.set('n', '<a-9>', ':BufferGoto 9\n', { silent = true })
vim.keymap.set('n', '<a-0>', ':BufferGoto 10\n', { silent = true })
vim.keymap.set('n', '<a-c>', ':BufferWipeout!\n', { silent = true })
vim.api.nvim_set_hl(0, 'BufferAlternate', { bg = '#16161e', fg = '#565f89' })
vim.api.nvim_set_hl(0, 'BufferAlternateADDED', { bg = '#16161e', fg = '#449dab' })
vim.api.nvim_set_hl(0, 'BufferAlternateCHANGED', { bg = '#16161e', fg = '#6183bb' })
vim.api.nvim_set_hl(0, 'BufferAlternateDELETED', { bg = '#16161e', fg = '#914c54' })
vim.api.nvim_set_hl(0, 'BufferAlternateERROR', { bg = '#16161e', fg = '#db4b4b' })
vim.api.nvim_set_hl(0, 'BufferAlternateHINT', { bg = '#16161e', fg = '#1abc9c' })
vim.api.nvim_set_hl(0, 'BufferAlternateIndex', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferAlternateINFO', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferAlternateMod', { bg = '#16161e', fg = '#e0af68' })
vim.api.nvim_set_hl(0, 'BufferAlternateSign', { bg = '#16161e', fg = '#16161e' })
vim.api.nvim_set_hl(0, 'BufferAlternateSignRight', { bg = '#16161e', fg = '#16161e' })
vim.api.nvim_set_hl(0, 'BufferAlternateWARN', { bg = '#16161e', fg = '#e0af68' })
vim.api.nvim_set_hl(0, 'BufferCurrent', { bg = '#16161e', fg = '#c0caf5' })
vim.api.nvim_set_hl(0, 'BufferCurrentADDED', { bg = '#16161e', fg = '#449dab' })
vim.api.nvim_set_hl(0, 'BufferCurrentCHANGED', { bg = '#16161e', fg = '#6183bb' })
vim.api.nvim_set_hl(0, 'BufferCurrentDELETED', { bg = '#16161e', fg = '#914c54' })
vim.api.nvim_set_hl(0, 'BufferCurrentERROR', { bg = '#16161e', fg = '#db4b4b' })
vim.api.nvim_set_hl(0, 'BufferCurrentHINT', { bg = '#16161e', fg = '#1abc9c' })
vim.api.nvim_set_hl(0, 'BufferCurrentIndex', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferCurrentINFO', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferCurrentMod', { bg = '#16161e', fg = '#e0af68' })
vim.api.nvim_set_hl(0, 'BufferCurrentSign', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferCurrentSignRight', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferCurrentWARN', { bg = '#16161e', fg = '#e0af68' })
vim.api.nvim_set_hl(0, 'BufferInactive', { bg = '#16161e', fg = '#565f89' })
vim.api.nvim_set_hl(0, 'BufferInactiveADDED', { bg = '#16161e', fg = '#449dab' })
vim.api.nvim_set_hl(0, 'BufferInactiveCHANGED', { bg = '#16161e', fg = '#6183bb' })
vim.api.nvim_set_hl(0, 'BufferInactiveDELETED', { bg = '#16161e', fg = '#914c54' })
vim.api.nvim_set_hl(0, 'BufferInactiveERROR', { bg = '#16161e', fg = '#db4b4b' })
vim.api.nvim_set_hl(0, 'BufferInactiveHINT', { bg = '#16161e', fg = '#1abc9c' })
vim.api.nvim_set_hl(0, 'BufferInactiveIndex', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferInactiveINFO', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferInactiveMod', { bg = '#16161e', fg = '#e0af68' })
vim.api.nvim_set_hl(0, 'BufferInactiveSign', { bg = '#16161e', fg = '#16161e' })
vim.api.nvim_set_hl(0, 'BufferInactiveSignRight', { bg = '#16161e', fg = '#16161e' })
vim.api.nvim_set_hl(0, 'BufferInactiveWARN', { bg = '#16161e', fg = '#e0af68' })
vim.api.nvim_set_hl(0, 'BufferVisible', { bg = '#16161e', fg = '#c0caf5' })
vim.api.nvim_set_hl(0, 'BufferVisibleADDED', { bg = '#16161e', fg = '#449dab' })
vim.api.nvim_set_hl(0, 'BufferVisibleCHANGED', { bg = '#16161e', fg = '#6183bb' })
vim.api.nvim_set_hl(0, 'BufferVisibleDELETED', { bg = '#16161e', fg = '#914c54' })
vim.api.nvim_set_hl(0, 'BufferVisibleERROR', { bg = '#16161e', fg = '#db4b4b' })
vim.api.nvim_set_hl(0, 'BufferVisibleHINT', { bg = '#16161e', fg = '#1abc9c' })
vim.api.nvim_set_hl(0, 'BufferVisibleIndex', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferVisibleINFO', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferVisibleMod', { bg = '#16161e', fg = '#e0af68' })
vim.api.nvim_set_hl(0, 'BufferVisibleSign', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferVisibleSignRight', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferVisibleWARN', { bg = '#16161e', fg = '#e0af68' })
vim.api.nvim_set_hl(0, 'BufferScrollArrow', { bg = '#16161e', fg = '#0db9d7' })
vim.api.nvim_set_hl(0, 'BufferTabpageFill', { bg = '#16161e', fg = '#16161e' })

-- shortcuts/no-neck-pain.nvim, arnamak/stay-centered.nvim
require('no-neck-pain').setup({ autocmds = { enableOnVimEnter = true } })
require('stay-centered').setup({ skip_filetypes = { 'dashboard' } })
vim.keymap.set('n', '<leader>z', ':NoNeckPain\n', {
    silent = true,
    desc = '󰘞 Zen mode'
})

-- lukas-reineke/indent-blankline.nvim
require('ibl').setup({
    indent = { char = '.' },
    scope = { enabled = false },
    exclude = { filetypes = { 'dashboard' } }
})

-- windwp/nvim-autopairs, kylechui/nvim-surround, numToStr/Comment.nvim
require('nvim-autopairs').setup()
require('nvim-surround').setup()
require('Comment').setup()
require('Comment.ft').set('plsql', '--%s')

-- nvim-telescope/telescope.nvim, nvim-telescope/telescope-file-browser.nvim
require('telescope').setup()
require('telescope').load_extension('file_browser')
vim.keymap.set('n', '<leader>f', ':Telescope\n', {
    silent = true,
    desc = '󰭎 Telescope'
})
vim.keymap.set('n', '<leader>ff', require('telescope').extensions.file_browser.file_browser, {
    silent = true,
    desc = '󰭎 File browser'
})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {
    silent = true,
    desc = '󰭎 Live grep'
})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {
    silent = true,
    desc = '󰭎 Buffers'
})

-- lewis6991/gitsigns.nvim
require('gitsigns').setup({
    on_attach = function()
        vim.keymap.set('n', '<leader>g', ':Gitsigns\n', {
            silent = true,
            desc = ' Git'
        })
        vim.keymap.set('n', '<leader>gs', require('gitsigns').stage_hunk, {
            silent = true,
            desc = ' Stage hunk'
        })
        vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk, {
            silent = true,
            desc = ' Reset hunk'
        })
        vim.keymap.set('n', '<leader>gS', require('gitsigns').stage_buffer, {
            silent = true,
            desc = ' Stage buffer'
        })
        vim.keymap.set('n', '<leader>gu', require('gitsigns').undo_stage_hunk, {
            silent = true,
            desc = ' Unstage hunk'
        })
        vim.keymap.set('n', '<leader>gR', require('gitsigns').reset_buffer, {
            silent = true,
            desc = ' Reset buffer'
        })
        vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk_inline, {
            silent = true,
            desc = ' Preview hunk'
        })
        vim.keymap.set('n', '<leader>gb', require('gitsigns').toggle_current_line_blame, {
            silent = true,
            desc = ' Toggle blame'
        })
        vim.keymap.set('n', '<leader>gd', require('gitsigns').diffthis, {
            silent = true,
            desc = ' Toggle diff'
        })
    end
})

-- neovim/nvim-lspconfig, williamboman/mason.nvim, williamboman/mason-lspconfig.nvim
require('lspconfig.ui.windows').default_options.border = 'rounded'
require('mason').setup({ ui = { border = 'rounded' } })
require('mason-lspconfig').setup({ ensure_installed = servers })

vim.keymap.set('n', '<leader>l', ':LspInfo\n', {
    silent = true,
    desc = ' LSP'
})
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, {
    silent = true,
    desc = ' Format'
})
vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, {
    silent = true,
    desc = ' Rename'
})
vim.keymap.set('n', '<leader>ll', require('telescope.builtin').diagnostics, {
    silent = true,
    desc = ' Diagnostics'
})
vim.keymap.set('n', '<leader>ld', require('telescope.builtin').lsp_definitions, {
    silent = true,
    desc = ' Definitions'
})
vim.keymap.set('n', '<leader>lr', require('telescope.builtin').lsp_references, {
    silent = true,
    desc = ' References'
})

for _, server in ipairs(servers) do
    local opts = servers_opts[server] or {}
    opts.capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig')[server].setup(opts)
end

-- ray-x/lsp_signature.nvim
require('lsp_signature').setup({
    bind = true,
    hint_prefix = '■ ',
    handler_opts = { border = 'rounded' }
})

-- L3MON4D3/LuaSnip, hrsh7th/nvim-cmp
require('cmp').setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    window = {
        completion = require('cmp').config.window.bordered(),
        documentation = require('cmp').config.window.bordered()
    },
    mapping = {
        ['<c-u>'] = require('cmp').mapping.scroll_docs(-1),
        ['<c-d>'] = require('cmp').mapping.scroll_docs(1),
        ['<c-f>'] = require('cmp').mapping.confirm({ select = true }),
        ['<c-e>'] = require('cmp').mapping.abort(),
        ['<c-up>'] = require('cmp').mapping.select_prev_item(),
        ['<c-down>'] = require('cmp').mapping.select_next_item()
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'vim-dadbod-completion' }
    }
})
require('cmp').setup.cmdline(':', { sources = { { name = 'cmdline' } } })
require('cmp').setup.cmdline('/', { sources = { { name = 'buffer' } } })

-- folke/which-key.nvim
require('which-key').setup({
    win = { border = 'rounded' },
    icons = {
        group = '',
        mappings = false
    }
})
