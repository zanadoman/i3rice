-- Line numbers

vim.o.number = true
vim.o.relativenumber = true

-- Indentation width

vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Border column

vim.o.colorcolumn = '80'

-- Hook system clipboard

vim.o.clipboard = 'unnamedplus'

-- Set update time

vim.o.updatetime = 1000

-- Change directory to file location

vim.o.autochdir = true

-- Install plugins

require('lazy').setup({
	{
		'windwp/nvim-autopairs',
	},
	{
		'nvim-telescope/telescope.nvim'
	},
	{
		'lewis6991/gitsigns.nvim'
	},
	{
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig',
	},
	{
		'L3MON4D3/LuaSnip'
	},
	{
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-path'
	},
	{
		'nvim-lualine/lualine.nvim',
		'romgrk/barbar.nvim',
		'nvim-tree/nvim-web-devicons'
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
local gitsigns = require('gitsigns')
local mason = require('mason')
local mason_lsp = require('mason-lspconfig')
local lspconfig = require('lspconfig')
local luasnip = require('luasnip')
local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')
local lualine = require('lualine')
local codeium = require('codeium')
local vscode = require('vscode')

-- Enable bracket completion

autopairs.setup()

-- Git integration

gitsigns.setup({
	on_attach = function()
		vim.api.nvim_create_autocmd('CursorHold', {
        	callback = function()
				if not cmp.visible() then
            		gitsigns.preview_hunk()
				end
       		end
		})
	end,
	preview_config = {
		focusable = false,
		border = 'rounded'
	}
})

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

vim.o.pumheight = 10

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
    sources = {
		{name = 'nvim_lsp'},
		{name = 'codeium'},
		{name = 'buffer'},
		{name = 'path'}
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

cmp.setup.cmdline(':', {
	sources = {
		{name = 'cmdline'}
	},
})

cmp.setup.cmdline('/', {
	sources = {
		{name = 'buffer'}
	},
})

cmp.setup.cmdline('!', {
	sources = {
		{name = 'path'}
	},
})

-- Enable info popup

vim.api.nvim_create_autocmd('CursorHoldI', {
	callback = function()
		if vim.lsp.buf.server_ready() and not cmp.visible() then
			vim.lsp.buf.hover()
		end
	end
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
	vim.lsp.handlers.hover, {
		focusable = false,
		border = 'rounded'
	}
)

-- Start servers

local capabilities = cmp_lsp.default_capabilities()

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		capabilities = capabilities
	})
end

-- Status line

vim.o.showmode = false

lualine.setup({})

-- Start codeium

codeium.setup()

-- Set theme

vscode.load('dark')
