-- Line numbers

vim.o.number = true

-- Indentation width

vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Border column

vim.o.colorcolumn = '80'

-- Hook system clipboard

vim.o.clipboard = 'unnamedplus'

-- Install plugins

require('lazy').setup({
	{
		'windwp/nvim-autopairs'
	},
	{
		'tanvirtin/vgit.nvim'
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

-- Load plugins

local autopairs = require('nvim-autopairs')
local vgit = require('vgit')
local mason = require('mason')
local mason_lsp = require('mason-lspconfig')
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')
local luasnip = require('luasnip')
local codeium = require('codeium')
local vscode = require('vscode')

-- Enable bracket completion

autopairs.setup()

-- Git integration

vgit.setup()

-- Install servers

mason.setup()

local servers = {
	'clangd',
	'csharp_ls',
    'jdtls',
    'pyright',
    'intelephense'
}

mason_lsp.setup({
	ensure_installed = servers
})

-- Diagnostic config

vim.diagnostic.config({
	update_in_insert = true,
})

-- Setup autocompletion

cmp.setup({
    snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
    	end
	},
    sources = {
		{name = 'nvim_lsp'},
		{name = 'codeium'},
		{name = 'buffer'}
    },
    mapping = {
		['<Up>'] = cmp.mapping.select_prev_item(),
		['<Down>'] = cmp.mapping.select_next_item(),
		['<Tab>'] = cmp.mapping.confirm({select = true}),
		['<Escape>'] = cmp.mapping.abort(),
		['<C-Up>'] = cmp.mapping.scroll_docs(-1),
		['<C-Down>'] = cmp.mapping.scroll_docs(1)
    },
    window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
    }
})

-- Enable info popup

function info_popup()
	vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
		callback = function()
			if not cmp.visible() then
				vim.lsp.buf.hover()
			end
		end
	})

	vim.o.updatetime = 1000

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
		vim.lsp.handlers.hover,
		{border = 'rounded'}
	)
end

-- Start servers

local capabilities = cmp_lsp.default_capabilities()

local on_attach = function(client, bufnr)
    info_popup()
end

for _, server in ipairs(servers) do
    lspconfig[server].setup({
		capabilities = capabilities,
		on_attach = on_attach
	})
end

-- Start codeium

codeium.setup()

-- Set theme

vscode.load('dark')
