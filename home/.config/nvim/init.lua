-- Language servers
local servers = {
    'clangd',
    'rust_analyzer',
    'csharp_ls',
    'jdtls',
    'pyright',
    'lua_ls',
    'bashls',
    'html',
    'cssls',
    'tsserver',
    'phpactor',
    'emmet_language_server'
}

local servers_opts = {
    clangd = {cmd = {'clangd', '--header-insertion=never'}},
    lua_ls = {settings = {Lua = {diagnostics = {globals = {'vim'}}}}},
    phpactor = {init_options = {
        ['language_server_phpstan'] = true,
        ['language_server_psalm'] = true
    }}
}

-- Leader
vim.g.mapleader = ' '

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Cursorline
vim.o.cursorline = true

-- Columns
vim.o.signcolumn = 'yes'
vim.o.colorcolumn = '80'

-- System clipboard
vim.o.clipboard = 'unnamedplus'

-- Autochange directory
vim.o.autochdir = true

-- Wrap lines
vim.o.wrap = false

-- Search mode
vim.o.ignorecase = true
vim.o.smartcase = true

-- Split
vim.o.splitright = true
vim.o.splitbelow = true

-- Exit terminal
vim.keymap.set('t', '<esc>', '<C-\\><C-n>')

-- Update time
vim.o.updatetime = 1000

-- Disable mouse
vim.o.mouse = "";

-- Move lines
vim.keymap.set('v', '<C-down>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<C-up>', ":m '<-2<CR>gv=gv")

-- No highlight
vim.keymap.set('n', '<leader>h', ":nohl\n", {silent = true})

-- Fix files
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function(opts)
        vim.cmd('silent! retab')
        if vim.bo[opts.buf].fileformat == 'dos'
        then
            vim.cmd('silent! %s/\r//g')
            vim.bo.fileformat = 'unix'
        end
    end
})

-- Plugin manager
if vim.fn.isdirectory(vim.fn.stdpath('data') .. '/lazy/lazy.nvim')
then
    vim.fn.system({
        'git',
        'clone',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    })
end

vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/lazy/lazy.nvim')

-- Install plugins
require('lazy').setup(
    {
        {
            'nvim-lua/plenary.nvim'
        },
        {
            'nvimdev/dashboard-nvim',
            'nvim-lualine/lualine.nvim',
            'romgrk/barbar.nvim',
            'shortcuts/no-neck-pain.nvim',
            'lukas-reineke/indent-blankline.nvim',
            'folke/tokyonight.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        {
            'arnamak/stay-centered.nvim',
            'windwp/nvim-autopairs',
            'kylechui/nvim-surround',
            'numToStr/Comment.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'lewis6991/gitsigns.nvim'
        },
        {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            'ray-x/lsp_signature.nvim'
        },
        {
            'tpope/vim-dadbod',
            'kristijanhusak/vim-dadbod-ui',
            'kristijanhusak/vim-dadbod-completion'
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
            'Exafunction/codeium.nvim'
        }
    },
    {
        ui = {border = 'rounded'}
    }
)

-- Startup screen
require('dashboard').setup({
    shortcut_type = 'number',
    config = {
        header = {
            '                                                                     ',
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
        packages = {enable = false},
        project = {enable = false},
        mru = {limit = 20},
        footer = {
            '                         ',
            '"Keep it simple, stupid!"'
        }
    }
})

-- Statusline
require('lualine').setup({
    options = {
        disabled_filetypes = {'dashboard'},
        globalstatus = true
    }
})

vim.o.showmode = false

-- Bufferline
require('barbar').setup({
    animation = false,
    tabpages = false,
    focus_on_close = 'previous',
    icons = {
        buffer_index = true,
        button = '',
        diagnostics = {
            [vim.diagnostic.severity.ERROR] = {enabled = true},
            [vim.diagnostic.severity.WARN] = {enabled = true},
            [vim.diagnostic.severity.INFO] = {enabled = true},
            [vim.diagnostic.severity.HINT] = {enabled = true}
        },
        gitsigns = {
            added = {enabled = true},
            changed = {enabled = true},
            deleted = {enabled = true}
        },
        separator = {left = '[', right = ']'},
        separator_at_end = false,
        modified = {button = ''}
    },
    insert_at_end = true
})

vim.keymap.set('n', '<A-,>', ':BufferPrevious\n', {silent = true})
vim.keymap.set('n', '<A-.>', ':BufferNext\n', {silent = true})
vim.keymap.set('n', '<A-c>', ':BufferWipeout!\n', {silent = true})
vim.keymap.set('n', '<A-1>', ':BufferGoto 1\n', {silent = true})
vim.keymap.set('n', '<A-2>', ':BufferGoto 2\n', {silent = true})
vim.keymap.set('n', '<A-3>', ':BufferGoto 3\n', {silent = true})
vim.keymap.set('n', '<A-4>', ':BufferGoto 4\n', {silent = true})
vim.keymap.set('n', '<A-5>', ':BufferGoto 5\n', {silent = true})
vim.keymap.set('n', '<A-6>', ':BufferGoto 6\n', {silent = true})
vim.keymap.set('n', '<A-7>', ':BufferGoto 7\n', {silent = true})
vim.keymap.set('n', '<A-8>', ':BufferGoto 8\n', {silent = true})
vim.keymap.set('n', '<A-9>', ':BufferGoto 9\n', {silent = true})
vim.keymap.set('n', '<A-0>', ':BufferGoto 10\n', {silent = true})

-- Center buffer
require('no-neck-pain').setup({autocmds = {enableOnVimEnter = true}})
vim.keymap.set('n', '<leader>z', ':NoNeckPain\n', {silent = true})

-- Indentation indicator
require('ibl').setup({
    indent = {char = '.'},
    scope = {enabled = false},
    exclude = {filetypes = {'dashboard'}}
})

-- Theme
require('tokyonight').setup({style = 'night', transparent = true})
vim.cmd('colorscheme tokyonight')
vim.cmd('highlight BufferScrollArrow guibg=#15161e guifg=#0cb0cc')
vim.cmd('highlight BufferTabpageFill guibg=#15161e guifg=#15161e')
vim.cmd('highlight BufferAlternate guibg=#15161e guifg=#565f89')
vim.cmd('highlight BufferAlternateADDED guibg=#15161e guifg=#246865')
vim.cmd('highlight BufferAlternateCHANGED guibg=#15161e guifg=#4f6796')
vim.cmd('highlight BufferAlternateDELETED guibg=#15161e guifg=#a95156')
vim.cmd('highlight BufferAlternateERROR guibg=#15161e guifg=#d04747')
vim.cmd('highlight BufferAlternateHINT guibg=#15161e guifg=#19b394')
vim.cmd('highlight BufferAlternateIndex guibg=#15161e guifg=#0cb0cc')
vim.cmd('highlight BufferAlternateINFO guibg=#15161e guifg=#10b2d7')
vim.cmd('highlight BufferAlternateMod guibg=#15161e guifg=#d5a86c')
vim.cmd('highlight BufferAlternateSign guibg=#15161e guifg=#15161e')
vim.cmd('highlight BufferAlternateSignRight guibg=#15161e guifg=#15161e')
vim.cmd('highlight BufferAlternateWARN guibg=#15161e guifg=#d5a663')
vim.cmd('highlight BufferCurrent guibg=#15161e guifg=#b4c0e7')
vim.cmd('highlight BufferCurrentADDED guibg=#15161e guifg=#246865')
vim.cmd('highlight BufferCurrentCHANGED guibg=#15161e guifg=#4f6796')
vim.cmd('highlight BufferCurrentDELETED guibg=#15161e guifg=#a95156')
vim.cmd('highlight BufferCurrentERROR guibg=#15161e guifg=#d04747')
vim.cmd('highlight BufferCurrentHINT guibg=#15161e guifg=#19b394')
vim.cmd('highlight BufferCurrentIndex guibg=#15161e guifg=#0cb0cc')
vim.cmd('highlight BufferCurrentINFO guibg=#15161e guifg=#10b2d7')
vim.cmd('highlight BufferCurrentMod guibg=#15161e guifg=#d5a86c')
vim.cmd('highlight BufferCurrentSign guibg=#15161e guifg=#0cb0cc')
vim.cmd('highlight BufferCurrentSignRight guibg=#15161e guifg=#0cb0cc')
vim.cmd('highlight BufferCurrentWARN guibg=#15161e guifg=#d5a663')
vim.cmd('highlight BufferInactive guibg=#15161e guifg=#565f89')
vim.cmd('highlight BufferInactiveADDED guibg=#15161e guifg=#246865')
vim.cmd('highlight BufferInactiveCHANGED guibg=#15161e guifg=#4f6796')
vim.cmd('highlight BufferInactiveDELETED guibg=#15161e guifg=#a95156')
vim.cmd('highlight BufferInactiveERROR guibg=#15161e guifg=#d04747')
vim.cmd('highlight BufferInactiveHINT guibg=#15161e guifg=#19b394')
vim.cmd('highlight BufferInactiveIndex guibg=#15161e guifg=#0cb0cc')
vim.cmd('highlight BufferInactiveINFO guibg=#15161e guifg=#10b2d7')
vim.cmd('highlight BufferInactiveMod guibg=#15161e guifg=#d5a86c')
vim.cmd('highlight BufferInactiveSign guibg=#15161e guifg=#15161e')
vim.cmd('highlight BufferInactiveSignRight guibg=#15161e guifg=#15161e')
vim.cmd('highlight BufferInactiveWARN guibg=#15161e guifg=#d5a663')
vim.cmd('highlight BufferVisible guibg=#15161e guifg=#b4c0e7')
vim.cmd('highlight BufferVisibleADDED guibg=#15161e guifg=#246865')
vim.cmd('highlight BufferVisibleCHANGED guibg=#15161e guifg=#4f6796')
vim.cmd('highlight BufferVisibleDELETED guibg=#15161e guifg=#a95156')
vim.cmd('highlight BufferVisibleERROR guibg=#15161e guifg=#d04747')
vim.cmd('highlight BufferVisibleHINT guibg=#15161e guifg=#19b394')
vim.cmd('highlight BufferVisibleIndex guibg=#15161e guifg=#0cb0cc')
vim.cmd('highlight BufferVisibleINFO guibg=#15161e guifg=#10b2d7')
vim.cmd('highlight BufferVisibleMod guibg=#15161e guifg=#d5a86c')
vim.cmd('highlight BufferVisibleSign guibg=#15161e guifg=#0cb0cc')
vim.cmd('highlight BufferVisibleSignRight guibg=#15161e guifg=#0cb0cc')
vim.cmd('highlight BufferVisibleWARN guibg=#15161e guifg=#d5a663')

-- Center cursorline
require('stay-centered').setup({skip_filetypes = {'dashboard'}})

-- Bracket autocompletion
require('nvim-autopairs').setup()

-- Surround tool
require('nvim-surround').setup()

-- Bulk commenter
require('Comment').setup()
require('Comment.ft').set('plsql', '--%s')

--Fuzzy finder
require('telescope').setup()
vim.keymap.set('n', '<leader>f', ':Telescope\n', {silent = true})
vim.keymap.set('n', '<leader>ff', ':Telescope file_browser\n', {silent = true})
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep\n', {silent = true})
vim.keymap.set('n', '<leader>fb', ':Telescope buffers\n', {silent = true})

-- Git integration
require('gitsigns').setup({
    on_attach = function()
        vim.keymap.set('n', '<leader>g', ':Gitsigns\n', {silent = true})
        vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk_inline\n', {silent = true})
        vim.keymap.set('n', '<leader>gs', ':Gitsigns stage_hunk\n', {silent = true})
        vim.keymap.set('n', '<leader>gu', ':Gitsigns undo_stage_hunk\n', {silent = true})
        vim.keymap.set('n', '<leader>gr', ':Gitsigns reset_hunk\n', {silent = true})
        vim.keymap.set('n', '<leader>gS', ':Gitsigns stage_buffer\n', {silent = true})
        vim.keymap.set('n', '<leader>gR', ':Gitsigns reset_buffer\n', {silent = true})
        vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame\n', {silent = true})
    end
})

-- Install servers
require('mason').setup({ui = {border = 'rounded'}})
require('mason-lspconfig').setup({ensure_installed = servers})

vim.keymap.set('n', '<leader>l', ':LspInfo\n', {silent = true})
vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, {silent = true})
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, {silent = true,})
vim.keymap.set('n', '<leader>ld', require('telescope.builtin').lsp_definitions, {silent = true})
vim.keymap.set('n', '<leader>lr', require('telescope.builtin').lsp_references, {silent = true})
vim.keymap.set('n', '<leader>ll', require('telescope.builtin').diagnostics, {silent = true})

require('lspconfig.ui.windows').default_options.border = 'rounded'

-- Diagnostic config
vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
    callback = function()
        if not require('cmp').visible() and
           not vim.diagnostic.open_float({focusable = false})
        then
            vim.lsp.buf.hover()
        end
    end
})

vim.diagnostic.config({
    update_in_insert = true,
    float = {border = 'rounded'}
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    focusable = false,
    border = 'rounded'
})

-- LSP hints
require('lsp_signature').setup({
    bind = true,
    handler_opts = {border = 'rounded'},
    hint_prefix = '■ '
})

-- Autocompletion
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
        ['<C-f>'] = require('cmp').mapping.confirm({select = true}),
        ['<C-e>'] = require('cmp').mapping.abort(),
        ['<C-Up>'] = require('cmp').mapping.select_prev_item(),
        ['<C-Down>'] = require('cmp').mapping.select_next_item(),
        ['<A-Down>'] = require('cmp').mapping.scroll_docs(1),
        ['<A-Up>'] = require('cmp').mapping.scroll_docs(-1)
    },
    sources = {
        {name = 'nvim_lsp'},
        {name = 'vim-dadbod-completion'},
        {name = 'codeium'},
        {name = 'buffer'},
        {name = 'path'},
        {name = 'codeium'}
    }
})

require('cmp').setup.cmdline(':', {sources = {{name = 'cmdline'}}})
require('cmp').setup.cmdline('/', {sources = {{name = 'buffer'}}})
vim.o.pumheight = 10

-- Start servers
for _, server in ipairs(servers)
do
    local opts = servers_opts[server] or {}
    opts.capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig')[server].setup(opts)
end

-- Codeium
require('codeium').setup({
    enable_chat = true,
    ignored_errors = {408, 499, 500, 503, 504}
})
