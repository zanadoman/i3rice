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
	'intelephense'
}

-- Line numbers

vim.o.number = true
vim.o.relativenumber = true

-- Indentation width

vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Border column

vim.o.colorcolumn = '80'

-- System clipboard

vim.o.clipboard = 'unnamedplus'

-- Auto change directory

vim.o.autochdir = true

-- Update time

vim.o.updatetime = 1000

-- Disable mouse

vim.o.mouse = nil

-- Plugin manager

if not vim.loop.fs_stat(vim.fn.stdpath('data') .. '/lazy/lazy.nvim') then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
	})
end

vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/lazy/lazy.nvim')

-- Install plugins

require('lazy').setup({
	{
		'nvimdev/dashboard-nvim',
		'nvim-lualine/lualine.nvim',
		'romgrk/barbar.nvim',
		'Mofiqul/vscode.nvim',
		'nvim-tree/nvim-web-devicons'
	},
	{
		'windwp/nvim-autopairs',
		'lewis6991/gitsigns.nvim',
		'nvim-telescope/telescope.nvim',
		'folke/which-key.nvim'
	},
	{
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig'
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
		'Exafunction/codeium.nvim',
		'nvim-lua/plenary.nvim'
	}
})

-- Startup screen

require('dashboard').setup({
	shortcut_type = 'number',
	config = {
		disable_move = true,
		header = {
			' ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓',
			' ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒',
			'▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░',
			'▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ',
			'▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒',
			'░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░',
			'░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░',
			'   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ',
			'         ░    ░  ░    ░ ░        ░   ░         ░   ',
			'                    ░                              ',
			'                                                   '
		},
		shortcut = {
			{
				icon = ' ',
				desc = 'New',
				key = 'n',
				action = 'enew'
			},
			{
				icon = ' ',
				desc = 'Files',
				key = 'f',
				action = 'Telescope find_files'
			},
			{
				icon = ' ',
				desc = 'Explorer',
				key = 'e',
				action = 'Explore'
			},
			{
				icon = ' ',
				desc = 'Update',
				key = 'u',
				action = 'Lazy update | MasonUpdate'
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
		mru = {limit = 9},
		footer = {}
	}
})

-- Status line

require('lualine').setup()

vim.o.showmode = false

-- Buffer line

require('barbar').setup({
	animation = false,
	icons = {
		buffer_number = true,
		diagnostics = {
			[vim.diagnostic.severity.ERROR] = {enabled = true},
			[vim.diagnostic.severity.WARN] = {enabled = true}
		},
		gitsigns = {
			added = {enabled = true},
			changed = {enabled = true},
			deleted = {enabled = true}
		}
	}
})

-- Theme

require('vscode').load('dark')

-- Bracket autocompletion

require('nvim-autopairs').setup()

-- Git integration

require('gitsigns').setup({
	on_attach = function()
		vim.api.nvim_create_autocmd('CursorHold', {
			callback = function()
				require('gitsigns').preview_hunk()
			end
		})
	end,
	preview_config = {
		focusable = false,
		border = 'rounded'
	}
})

-- Help

require('which-key').setup()

-- Install servers

require('mason').setup()

require('mason-lspconfig').setup({ensure_installed = servers})

-- Diagnostic config

vim.diagnostic.config({update_in_insert = true})

-- Autocompletion

require('cmp').setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end
	},
    sources = {
		{name = 'nvim_lsp'},
		{name = 'codeium'},
		{name = 'buffer'},
		{name = 'path'}
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

require('cmp').setup.cmdline(':', {
	sources = {
		{name = 'cmdline'}
	},
})

require('cmp').setup.cmdline('/', {
	sources = {
		{name = 'buffer'}
	},
})

require('cmp').setup.cmdline('!', {
	sources = {
		{name = 'path'}
	},
})

vim.o.pumheight = 10

-- Enable info popup

function info_popup()
	vim.api.nvim_create_autocmd('CursorHoldI', {
		callback = function()
			if vim.lsp.buf.server_ready() and not require('cmp').visible() then
				vim.lsp.buf.hover()
			end
		end
	})
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
	vim.lsp.handlers.hover, {
		focusable = false,
		border = 'rounded'
	}
)

-- Start servers

for _, server in ipairs(servers) do
	require('lspconfig')[server].setup({
		capabilities = require('cmp_nvim_lsp').default_capabilities(),
		on_attach = function()
			info_popup()
		end
	})
end

-- Codeium AI

require('codeium').setup()
