	-- Line numbers

vim.o.number = true

-- Indentation width

vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Autosave

vim.o.autowriteall = true

-- Activate LSP on insert

vim.diagnostic.config({
	update_in_insert = true
})

vim.lsp.buf.hover()

-- Install plugins

require('lazy').setup({
    {
		'm4xshen/autoclose.nvim'
    },
    {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig'
    },
    {
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer'
    },
    {
		'L3MON4D3/LuaSnip'
    },
    {
		'Exafunction/codeium.nvim',
		'nvim-lua/plenary.nvim'
    }
})

-- Start autoclose

require('autoclose').setup()

-- Start mason

require('mason').setup()

-- Start mason-lspconfig and install LSPs

require('mason-lspconfig').setup({
    ensure_installed = {
		'clangd',
		'csharp_ls',
		'jdtls',
		'pyright',
		'intelephense'
    }
})

-- Start cmp and configure luasnip

require('cmp').setup({
    snippet = {
		expand = function(args)
		require('luasnip').lsp_expand(args.body)
    end},
    sources = {
		{name = 'nvim_lsp'},
		{name = 'codeium'},
		{name = 'buffer'}
    },
    mapping = {
		['<Up>'] = require('cmp').mapping.select_prev_item(select_opts),
		['<Down>'] = require('cmp').mapping.select_next_item(select_opts),
		['<Tab>'] = require('cmp').mapping.confirm({select = true}),
		['<Escape>'] = require('cmp').mapping.abort(),
		['<C-Up>'] = require('cmp').mapping.scroll_docs(-1),
		['<C-Down>'] = require('cmp').mapping.scroll_docs(1)
    },
    window = {
		completion = require('cmp').config.window.bordered(),
		documentation = require('cmp').config.window.bordered()
    }
})

-- Start LSPs

require('lspconfig').clangd.setup({})
require('lspconfig').csharp_ls.setup({})
require('lspconfig').jdtls.setup({})
require('lspconfig').pyright.setup({})
require('lspconfig').intelephense.setup({})

-- Start codeium

require('codeium').setup()
