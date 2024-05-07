-- Language servers
local servers = {
    'clangd',
    'rust_analyzer',
    'csharp_ls',
    'jdtls',
    'pyright',
    'bashls',
    'html',
    'cssls',
    'tsserver',
    'phpactor'
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

-- Scrolloff
vim.o.scrolloff = 64

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
vim.o.mouse = nil

-- Move lines
vim.keymap.set('v', '<C-down>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<C-up>', ":m '<-2<CR>gv=gv")

-- Fix files
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function(opts)
        vim.cmd('silent! retab')
        if vim.bo[opts.buf].fileformat == 'dos'
        then
            vim.bo.fileformat = 'unix'
            vim.cmd('silent! %s/\r//g')
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
            'ggandor/leap.nvim',
            'windwp/nvim-autopairs',
            'kylechui/nvim-surround',
            'numToStr/Comment.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'lewis6991/gitsigns.nvim',
            'zanadoman/speedrun.nvim',
            'folke/which-key.nvim'
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
            'dcampos/cmp-emmet-vim',
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
            '                                                                   ',
            '      ████ ██████           █████      ██                    ',
            '     ███████████             █████                            ',
            '     █████████ ███████████████████ ███   ███████████  ',
            '    █████████  ███    █████████████ █████ ██████████████  ',
            '   █████████ ██████████ █████████ █████ █████ ████ █████  ',
            ' ███████████ ███    ███ █████████ █████ █████ ████ █████ ',
            '██████  █████████████████████ ████ █████ █████ ████ ██████',
            '                                                                     ',
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
            '"Keep it simple, stupid!"',
        }
    }
})

-- Statusline
require('lualine').setup({options = {globalstatus = true}})
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
            [vim.diagnostic.severity.WARN] = {enabled = true}
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

-- Center buffer
require('no-neck-pain').setup({autocmds = {enableOnVimEnter = true}})

vim.keymap.set('n', '<leader>z', ':NoNeckPain\n', {
    silent = true,
    desc = 'Zen mode'
})

-- Indentation indicator
require('ibl').setup({
    indent = {char = '.'},
    scope = {enabled = false},
    exclude = {filetypes = {'dashboard'}}
})

-- Theme
require('tokyonight').setup({transparent = true})
vim.cmd('colorscheme tokyonight-night')

vim.cmd('highlight BufferTabpageFill guibg=#15161e')
vim.cmd('highlight BufferCurrent guibg=#15161e')
vim.cmd('highlight BufferCurrentSign guibg=#15161e guifg=#0cb0cc')
vim.cmd('highlight BufferCurrentADDED guibg=None')
vim.cmd('highlight BufferCurrentCHANGED guibg=None')
vim.cmd('highlight BufferCurrentDELETED guibg=None')
vim.cmd('highlight BufferInactive guibg=#15161e')
vim.cmd('highlight BufferInactiveSign guibg=#15161e')
vim.cmd('highlight BufferInactiveIndex guibg=#15161e')
vim.cmd('highlight BufferInactiveADDED guibg=#202331')
vim.cmd('highlight BufferInactiveCHANGED guibg=#202331')
vim.cmd('highlight BufferInactiveDELETED guibg=#202331')

-- Movement
require('leap').create_default_mappings()

-- Bracket autocompletion
require('nvim-autopairs').setup()

-- Surround tool
require('nvim-surround').setup()

-- Bulk commenter
require('Comment').setup()
require('Comment.ft').set('plsql', '--%s')

--Fuzzy finder
require('telescope').setup()

vim.keymap.set('n', '<leader>f', ':Telescope\n', {
    silent = true,
    desc = 'Telescope'
})

vim.keymap.set('n', '<leader>ff', ':Telescope file_browser\n', {
    silent = true,
    desc = 'Telescope file browser'
})

vim.keymap.set('n', '<leader>fg', ':Telescope live_grep\n', {
    silent = true,
    desc = 'Telescope live grep'
})

vim.keymap.set('n', '<leader>fb', ':Telescope buffers\n', {
    silent = true,
    desc = 'Telescope buffers'
})

-- Git integration
require('gitsigns').setup({
    on_attach = function()
        vim.keymap.set('n', '<leader>h', ':Gitsigns\n', {
            silent = true,
            desc = 'Gitsigns'
        })

        vim.keymap.set('n', '<leader>hp', ':Gitsigns preview_hunk_inline\n', {
            silent = true,
            desc = 'Gitsigns preview hunk'
        })

        vim.keymap.set('n', '<leader>hs', ':Gitsigns stage_hunk\n', {
            silent = true,
            desc = 'Gitsigns stage hunk'
        })

        vim.keymap.set('n', '<leader>hu', ':Gitsigns undo_stage_hunk\n', {
            silent = true,
            desc = 'Gitsigns unstage hunk'
        })

        vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk\n', {
            silent = true,
            desc = 'Gitsigns reset hunk'
        })

        vim.keymap.set('n', '<leader>hS', ':Gitsigns stage_buffer\n', {
            silent = true,
            desc = 'Gitsigns stage buffer'
        })

        vim.keymap.set('n', '<leader>hR', ':Gitsigns reset_buffer\n', {
            silent = true,
            desc = 'Gitsigns reset buffer'
        })

        vim.keymap.set('n', '<leader>hb', ':Gitsigns toggle_current_line_blame\n', {
            silent = true,
            desc = 'Gitsigns toggle blame'
        })
    end
})

-- Speedrun
require('speedrun').setup({
    keymap = '<leader>r',
    mode = 'buffer',
    langs = {
        c = {
            cmd = 'gcc -std=c99 -O3 -Werror -Wall -Wextra -Wpedantic % && ./a.out',
            icon = '󰙱 '
        },
        cpp = {
            cmd = 'g++ -std=c++11 -O3 -Werror -Wall -Wextra -Wpedantic % && ./a.out',
            icon = '󰙲 '
        },
        rust = {
            cmd = 'cargo run',
            icon = ' '
        },
        cs = {
            cmd = 'dotnet run', 
            icon = '󰌛 '
        },
        java = {
            cmd = 'java %',
            icon = ' '
        },
        python = {
            cmd = 'python3 %',
            icon = ' '
        },
        sh = {
            cmd = './%',
            icon = ' '
        }
    }
})

-- Key bindings
require('which-key').setup({window = {border = 'rounded'}})

-- Install servers
require('mason').setup({ui = {border = 'rounded'}})
require('mason-lspconfig').setup({ensure_installed = servers})

-- Diagnostic config
vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
    callback = function()
        if not require('cmp').visible() and not vim.diagnostic.open_float()
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
        {name = 'emmet_vim', option = {filetypes = {'html', 'css', 'php'}}},
        {name = 'vim-dadbod-completion'},
        {name = 'codeium'},
        {name = 'buffer'},
        {name = 'path'}
    },
    experimental = {ghost_text = true}
})

require('cmp').setup.cmdline(':', {sources = {{name = 'cmdline'}}})
require('cmp').setup.cmdline('/', {sources = {{name = 'buffer'}}})
vim.o.pumheight = 10

-- Start servers
for _, server in ipairs(servers)
do
    require('lspconfig')[server].setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities()
    })
end

-- Codeium AI
require('codeium').setup()
