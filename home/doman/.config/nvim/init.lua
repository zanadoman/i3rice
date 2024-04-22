-- Language servers
local servers = {
    'clangd',
    'csharp_ls',
    'jdtls',
    'pyright',
    'bashls',
    'html',
    'cssls',
    'quick_lint_js',
    'intelephense',
    'sqlls'
}

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Indentation width
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        vim.cmd('silent! retab')
    end
})

-- Cursorline
vim.o.cursorline = true

-- Scrolloff
vim.o.scrolloff = 64

-- Border column
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

-- Update time
vim.o.updatetime = 1000

-- Disable mouse
vim.o.mouse = nil

-- Plugin manager
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
            'folke/which-key.nvim'
        },
        {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig'
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
require('lualine').setup({
    options = {globalstatus = true},
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
            [vim.diagnostic.severity.WARN] = {enabled = true}
        },
        gitsigns = {
            added = {enabled = true},
            changed = {enabled = true},
            deleted = {enabled = true}
        },
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

-- Indentation indicator
require('ibl').setup({
    indent = {char = '.'},
    scope = {enabled = false},
    exclude = {filetypes = {'dashboard'}}
})

-- Theme
require('tokyonight').setup({transparent = true})
vim.cmd('colorscheme tokyonight-night')

-- Movement
require('leap').create_default_mappings()

-- Bracket autocompletion
require('nvim-autopairs').setup()

-- Surround tool
require('nvim-surround').setup()

-- Bulk commenter
require('Comment').setup()

--Fuzzy finder
require('telescope').setup()

vim.keymap.set('n', ' f', ':Telescope\n', {
    silent = true,
    desc = 'Telescope'
})

vim.keymap.set('n', ' ff', ':Telescope file_browser\n', {
    silent = true,
    desc = 'Telescope file browser'
})

vim.keymap.set('n', ' fg', ':Telescope live_grep\n', {
    silent = true,
    desc = 'Telescope live grep'
})

vim.keymap.set('n', ' fb', ':Telescope buffers\n', {
    silent = true,
    desc = 'Telescope buffers'
})

-- Git integration
require('gitsigns').setup({
    on_attach = function()
        vim.keymap.set('n', ' h', ':Gitsigns\n', {
            silent = true,
            desc = 'Gitsigns'
        })

        vim.keymap.set('n', ' hp', ':Gitsigns preview_hunk_inline\n', {
            silent = true,
            desc = 'Gitsigns preview hunk'
        })

        vim.keymap.set('n', ' hs', ':Gitsigns stage_hunk\n', {
            silent = true,
            desc = 'Gitsigns stage hunk'
        })

        vim.keymap.set('n', ' hu', ':Gitsigns undo_stage_hunk\n', {
            silent = true,
            desc = 'Gitsigns unstage hunk'
        })

        vim.keymap.set('n', ' hr', ':Gitsigns reset_hunk\n', {
            silent = true,
            desc = 'Gitsigns reset hunk'
        })

        vim.keymap.set('n', ' hS', ':Gitsigns stage_buffer\n', {
            silent = true,
            desc = 'Gitsigns stage buffer'
        })

        vim.keymap.set('n', ' hR', ':Gitsigns reset_buffer\n', {
            silent = true,
            desc = 'Gitsigns reset buffer'
        })

        vim.keymap.set('n', ' hb', ':Gitsigns toggle_current_line_blame\n', {
            silent = true,
            desc = 'Gitsigns toggle blame'
        })
    end
})

-- Code runner
vim.api.nvim_create_autocmd('BufEnter', {
    callback = function(opts)
        if vim.bo[opts.buf].filetype == 'c' then
            if vim.fn.filereadable('compile_flags.txt') then
                vim.keymap.set('n', ' r', ':terminal gcc % ' ..
                               '$(cat compile_flags.txt) && ./a.out\n', {
                    silent = true,
                    desc = 'Run 󰙱 '
                })
            else
                vim.keymap.set('n', ' r', ':terminal gcc -std=c99 -O3 ' ..
                               '-Werror -Wall -Wextra -Wpedantic % && ./a.out\n', {
                    silent = true,
                    desc = 'Run 󰙱 '
                })
            end
        elseif vim.bo[opts.buf].filetype == 'cpp' then
            if vim.fn.filereadable('compile_flags.txt') then
                vim.keymap.set('n', ' r', ':terminal g++ % ' ..
                               '$(cat compile_flags.txt) && ./a.out\n', {
                    silent = true,
                    desc = 'Run 󰙲 '
                })
            else
                vim.keymap.set('n', ' r', ':terminal g++ -std=c++11 -O3 ' ..
                               '-Werror -Wall -Wextra -Wpedantic % && ./a.out\n', {
                    silent = true,
                    desc = 'Run 󰙲 '
                })
            end
        elseif vim.bo[opts.buf].filetype == 'cs' then
            vim.keymap.set('n', ' r', ':terminal dotnet run\n', {
                silent = true,
                desc = 'Run 󰌛 '
            })
        elseif vim.bo[opts.buf].filetype == 'java' then
            vim.keymap.set('n', ' r', ':terminal java %\n', {
                silent = true,
                desc = 'Run  '
            })
        elseif vim.bo[opts.buf].filetype == 'python' then
            vim.keymap.set('n', ' r', ':terminal python3 %\n', {
                silent = true,
                desc = 'Run  '
            })
        elseif vim.bo[opts.buf].filetype == 'sh' then
            vim.keymap.set('n', ' r', ':terminal ./%\n', {
                silent = true,
                desc = 'Run  '
            })
        end
    end
})

-- Key bindings
require('which-key').setup({
    window = {border = 'rounded'}
})

-- Install servers
require('mason').setup({
    ui = {border = 'rounded'}
})

require('mason-lspconfig').setup({
    ensure_installed = servers
})

-- Diagnostic config
vim.diagnostic.config({update_in_insert = true})

vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
    callback = function()
        if vim.lsp.buf.server_ready() and not require('cmp').visible() then
            vim.lsp.buf.hover()
        end
    end
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    focusable = false,
    border = 'rounded'
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
        ['<Up>'] = require('cmp').mapping.select_prev_item(),
        ['<Down>'] = require('cmp').mapping.select_next_item(),
        ['<C-Down>'] = require('cmp').mapping.scroll_docs(1),
        ['<C-Up>'] = require('cmp').mapping.scroll_docs(-1)
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

require('cmp').setup.cmdline(':', {
    sources = {{name = 'cmdline'}}
})

require('cmp').setup.cmdline('/', {
    sources = {{name = 'buffer'}}
})

vim.o.pumheight = 10

-- Start servers
for _, server in ipairs(servers) do
    require('lspconfig')[server].setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities()
    })
end

-- Codeium AI
require('codeium').setup()
