-- Line numbers

vim.o.number = true

-- Indentation width

vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Border column

vim.o.colorcolumn = '80'

-- Hook system clipboard

vim.api.nvim_set_option('clipboard', 'unnamedplus')

-- Autosave

vim.go.autosave = true

-- Activate LSP on insert

vim.diagnostic.config({
	update_in_insert = true
})

-- Install plugins

require('lazy').setup({
	{
		'windwp/nvim-autopairs'
	},
	{
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig',
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
	},
	{
		'Mofiqul/vscode.nvim'
	}
})

-- Start nvim-autopairs

require('nvim-autopairs').setup()

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
		['<Up>'] = require('cmp').mapping.select_prev_item(),
		['<Down>'] = require('cmp').mapping.select_next_item(),
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

-- Documentation popup

vim.o.updatetime = 1000

vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
	callback = function()
		if not require('cmp').visible() then
			vim.lsp.buf.hover()
		end
	end
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
	vim.lsp.handlers.hover, {
		border = 'rounded'
	}
)


-- Start LSPs

require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').clangd.setup({
	capabilities = require('cmp_nvim_lsp').default_capabilities()
})
require('lspconfig').csharp_ls.setup({
	capabilities = require('cmp_nvim_lsp').default_capabilities()
})
require('lspconfig').jdtls.setup({
	capabilities = require('cmp_nvim_lsp').default_capabilities()
})
require('lspconfig').pyright.setup({
	capabilities = require('cmp_nvim_lsp').default_capabilities()
})
require('lspconfig').intelephense.setup({
	capabilities = require('cmp_nvim_lsp').default_capabilities()
})

-- Start codeium

require('codeium').setup()

-- Theme

require('vscode').load('dark')
