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
vim.o.shortmess = 'I'
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

-- File associations
vim.filetype.add({
    pattern = {
        ['.*.html'] = { 'html', { priority = 10 } },
        ['.*.php'] = { 'php', { priority = 10 } }
    }
})

-- File formatter
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        if vim.bo.modifiable then
            vim.cmd('silent! %s/\r//g')
            vim.bo.fileformat = 'unix'
            vim.cmd('silent! retab')
        end
    end
})

-- Auto highlight
vim.api.nvim_create_autocmd('InsertEnter', {
    callback = function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(
            '<cmd>silent! nohlsearch\n', true, true, true), 'n', true)
    end
})

-- Spell checker
vim.keymap.set('n', '<leader>s', function()
    vim.o.spell = not vim.o.spell
end, {
    silent = true,
    desc = '󰓆 Spelling'
})

-- Diagnostics options
vim.diagnostic.config({
    update_in_insert = true,
    float = { border = 'rounded' }
})
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    focusable = false,
    silent = true,
    border = 'rounded'
})

function SetupTokionightNvim()
    require('tokyonight').setup({ style = 'night', transparent = true })
    vim.cmd('colorscheme tokyonight')
    vim.api.nvim_set_hl(0, 'WinSeparator', { bg = '#16161e', fg = '#16161e' })
end

function SetupLualineNvim()
    require('lualine').setup({ options = { globalstatus = true } })
end

function SetupBarbarNvim()
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
    vim.keymap.set('n', '<a-1>', ':BufferGoto 1\n', { silent = true })
    vim.keymap.set('n', '<a-2>', ':BufferGoto 2\n', { silent = true })
    vim.keymap.set('n', '<a-3>', ':BufferGoto 3\n', { silent = true })
    vim.keymap.set('n', '<a-4>', ':BufferGoto 4\n', { silent = true })
    vim.keymap.set('n', '<a-5>', ':BufferGoto 5\n', { silent = true })
    vim.keymap.set('n', '<a-6>', ':BufferGoto 6\n', { silent = true })
    vim.keymap.set('n', '<a-7>', ':BufferGoto 7\n', { silent = true })
    vim.keymap.set('n', '<a-8>', ':BufferGoto 8\n', { silent = true })
    vim.keymap.set('n', '<a-9>', ':BufferGoto 9\n', { silent = true })
    vim.keymap.set('n', '<a-0>', require('telescope.builtin').buffers, { silent = true })
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
    vim.api.nvim_set_hl(0, 'BufferVisibleSign', { bg = '#16161e', fg = '#565f89' })
    vim.api.nvim_set_hl(0, 'BufferVisibleSignRight', { bg = '#16161e', fg = '#565f89' })
    vim.api.nvim_set_hl(0, 'BufferVisibleWARN', { bg = '#16161e', fg = '#e0af68' })
    vim.api.nvim_set_hl(0, 'BufferScrollArrow', { bg = '#16161e', fg = '#0db9d7' })
    vim.api.nvim_set_hl(0, 'BufferTabpageFill', { bg = '#16161e', fg = '#16161e' })
end

function SetupNoNeckPainNvim()
    require('no-neck-pain').setup({
        autocmds = { enableOnVimEnter = true, skipEnteringNoNeckPainBuffer = true },
        buffers = { right = { enabled = false } }
    })
    vim.keymap.set('n', '<leader>c', ':NoNeckPain\n', {
        silent = true,
        desc = '󰘞 Center'
    })
end

function SetupStayCenteredNvim()
    require('stay-centered').setup()
end

function SetupIndentBlanklineNvim()
    require('ibl').setup({
        indent = { char = '.' },
        scope = { enabled = false }
    })
end

function SetupNvimAutopairs()
    require('nvim-autopairs').setup()
end

function SetupNvimSurround()
    require('nvim-surround').setup()
end

function SetupTelescopeNvim()
    require('telescope').setup()
    require('telescope').load_extension('file_browser')
    vim.keymap.set('n', '<leader>f', require('telescope').extensions.file_browser.file_browser, {
        silent = true,
        desc = ' Files'
    })
    vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep, {
        silent = true,
        desc = '󱡴 Grep'
    })
    vim.keymap.set('n', '<leader>h', require('telescope.builtin').oldfiles, {
        silent = true,
        desc = '󰋚 History'
    })
    require('gitsigns').setup({
        on_attach = function()
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
            vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, {
                silent = true,
                desc = ' Commits'
            })
            vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, {
                silent = true,
                desc = ' Branches'
            })
            vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, {
                silent = true,
                desc = ' Files'
            })
            vim.keymap.set('n', '<leader>gd', require('telescope.builtin').git_status, {
                silent = true,
                desc = ' Diffs'
            })
        end
    })
end

function SetupNvimTreesitter()
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'asm',
            'bash',
            'c',
            'c_sharp',
            'cmake',
            'cpp',
            'css',
            'doxygen',
            'fish',
            'html',
            'java',
            'javascript',
            'latex',
            'lua',
            'make',
            'markdown',
            'php',
            'printf',
            'python',
            'rust',
            'sql',
            'typescript'
        },
        highlight = { enable = true }
    })
end

function SetupMasonLspconfigNvim()
    local servers = {
        clangd = { cmd = { 'clangd', '--header-insertion=never' } },
        csharp_ls = {},
        cssls = { filetypes = { 'html', 'javascript', 'php', 'rust' } },
        emmet_language_server = { filetypes = { '*' } },
        html = {
            filetypes = { 'html', 'javascript', 'php', 'rust' },
            init_options = { provideFormatter = false }
        },
        intelephense = {},
        jdtls = {},
        lua_ls = { settings = { Lua = { diagnostics = { globals = { 'vim' } } } } },
        pyright = {},
        rust_analyzer = {},
        ts_ls = {}
    }
    require('lspconfig.ui.windows').default_options.border = 'rounded'
    require('mason').setup({ ui = { border = 'rounded' } })
    require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = { function(server)
            servers[server].capabilities = require('cmp_nvim_lsp').default_capabilities()
            require('lspconfig')[server].setup(servers[server])
        end }
    })
    vim.keymap.set('n', '<leader>ls', ':LspStart\n', {
        silent = true,
        desc = ' Start'
    })
    vim.keymap.set('n', '<leader>lh', ':LspStop\n', {
        silent = true,
        desc = ' Halt'
    })
    vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, {
        silent = true,
        desc = ' Format'
    })
    vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, {
        silent = true,
        desc = ' Rename'
    })
    vim.keymap.set('n', '<leader>lp', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, {
        silent = true,
        desc = ' Parameters'
    })
    vim.keymap.set('n', '<leader>li', require('telescope.builtin').diagnostics, {
        silent = true,
        desc = ' Issues'
    })
    vim.keymap.set('n', '<leader>ld', require('telescope.builtin').lsp_definitions, {
        silent = true,
        desc = ' Definitions'
    })
    vim.keymap.set('n', '<leader>lr', require('telescope.builtin').lsp_references, {
        silent = true,
        desc = ' References'
    })
    vim.api.nvim_create_autocmd('CursorHold', {
        callback = function()
            if not vim.diagnostic.open_float({ focusable = false }) then
                vim.cmd('silent! lua vim.lsp.buf.hover()')
            end
        end
    })
end

function SetupNvimCmp()
    require('cmp').setup({
        snippet = {
            expand = function(args)
                vim.snippet.expand(args.body)
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
            ['<c-down>'] = require('cmp').mapping.select_next_item(),
            ['<c-k>'] = require('cmp').mapping.select_prev_item(),
            ['<c-j>'] = require('cmp').mapping.select_next_item()
        },
        sources = require('cmp').config.sources(
            { { name = 'nvim_lsp' } },
            { { name = 'nvim_lsp_signature_help' } },
            { { name = 'buffer' } },
            { { name = 'path' } },
            { { name = 'calc' } },
            { { name = 'vim-dadbod-completion' } }
        )
    })
    require('cmp').setup.cmdline({ '/', '?' }, {
        mapping = require('cmp').mapping.preset.cmdline(),
        sources = require('cmp').config.sources(
            { { name = 'buffer' } }
        )
    })
    require('cmp').setup.cmdline(':', {
        mapping = require('cmp').mapping.preset.cmdline(),
        sources = require('cmp').config.sources(
            { { name = 'cmdline' } },
            { { name = 'path' } }
        )
    })
end

function SetupVimtex()
    vim.g.vimtex_view_general_viewer = 'google-chrome-stable'
end

function SetupWhichKeyNvim()
    require('which-key').setup({
        delay = 1000,
        win = { border = 'rounded' },
        icons = {
            group = '',
            mappings = false
        }
    })
end

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
            'folke/tokyonight.nvim',
            lazy = false,
            config = SetupTokionightNvim
        },
        {
            'nvim-lualine/lualine.nvim',
            event = 'BufEnter',
            config = SetupLualineNvim
        },
        {
            'romgrk/barbar.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            event = 'BufEnter',
            config = SetupBarbarNvim
        },
        {
            'shortcuts/no-neck-pain.nvim',
            event = 'BufEnter',
            config = SetupNoNeckPainNvim
        },
        {
            'arnamak/stay-centered.nvim',
            event = 'VeryLazy',
            config = SetupStayCenteredNvim
        },
        {
            'lukas-reineke/indent-blankline.nvim',
            event = 'VeryLazy',
            config = SetupIndentBlanklineNvim
        },
        {
            'windwp/nvim-autopairs',
            event = 'InsertEnter',
            config = SetupNvimAutopairs
        },
        {
            'kylechui/nvim-surround',
            event = 'VeryLazy',
            config = SetupNvimSurround
        },
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-file-browser.nvim',
                'lewis6991/gitsigns.nvim'
            },
            event = 'VeryLazy',
            config = SetupTelescopeNvim
        },
        {
            'nvim-treesitter/nvim-treesitter',
            ft = {
                'asm',
                'sh',
                'c',
                'cs',
                'cmake',
                'cpp',
                'css',
                'fish',
                'html',
                'java',
                'javascript',
                'tex',
                'lua',
                'make',
                'markdown',
                'php',
                'python',
                'rust',
                'sql',
                'typescript'
            },
            config = SetupNvimTreesitter
        },
        {
            'williamboman/mason-lspconfig.nvim',
            dependencies = {
                'williamboman/mason.nvim',
                'neovim/nvim-lspconfig',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-nvim-lsp-signature-help'
            },
            cmd = { 'Mason', 'MasonUpdate' },
            ft = {
                'c',
                'cpp',
                'cs',
                'css',
                'html',
                'java',
                'javascript',
                'lua',
                'php',
                'python',
                'rust',
                'typescript'
            },
            config = SetupMasonLspconfigNvim
        },
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-cmdline',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-calc'
            },
            event = { 'CmdlineEnter', 'InsertEnter' },
            config = SetupNvimCmp
        },
        {
            'lervag/vimtex',
            ft = 'tex',
            config = SetupVimtex
        },
        {
            'kristijanhusak/vim-dadbod-ui',
            dependencies = {
                'tpope/vim-dadbod',
                'kristijanhusak/vim-dadbod-completion'
            },
            cmd = 'DBUI'
        },
        {
            'folke/which-key.nvim',
            event = 'VeryLazy',
            config = SetupWhichKeyNvim
        }
    },
    {
        ui = { border = 'rounded' }
    }
)
