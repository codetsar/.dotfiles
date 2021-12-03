---- HELPERS -------------------------------------------------------------------
local cmd = vim.cmd                --  to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn                  --  to call Vim functions e.g. fn.bufnr()
local g = vim.g                    --  a table to access global variables
local opt = vim.opt                --  to set options

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


map('n', '<Space>', '')
g.mapleader = " "

g.python3_host_prog = '/home/yar/venv/bin/python3.10'

---- PLUGINS -------------------------------------------------------------------
require('packer').startup(function()
	use 'wbthomason/packer.nvim'
    use 'nvim-lua/popup.nvim'
    use { 'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} } }

    use {
        "folke/which-key.nvim",
        config = function ()
            require("which-key").setup {}
        end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use 'rose-pine/neovim'
    use 'projekt0n/github-nvim-theme'

    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
	use 'junegunn/vim-easy-align'

	use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
	use 'ms-jpq/coq_nvim'
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	use {'junegunn/fzf', run = vim.fn['fzf#install']}
	use 'junegunn/fzf.vim'
	use 'ojroques/nvim-lspfuzzy'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup {} end
    }
end)


---- THEME ---------------------------------------------------------------------
require('github-theme').setup({
    comment_style = "NONE",
    keyword_style = "NONE",
    function_style = "bold",
    variable_style = "NONE",
    theme_style = "dimmed", -- dark, dark_default, dimmed, light, light_default
    hide_inactive_statusline=false,
    transparent=false,
    dark_sidebar = true,
    --sidebars = {},
    --colors = {hint = "orange", error = "#ff0000"},
})

---- OPTIONS -------------------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse
opt.encoding = 'utf-8'
opt.keymap = 'russian-dvorak'         -- use dvorak maping ontop russian layout
opt.iminsert = 0                      -- make english default again
opt.imsearch = 0
opt.termguicolors = true              -- True color support
opt.number = true                     -- Show line number
opt.relativenumber = true             -- Relative line number
opt.ignorecase = true                 -- Ignore case
opt.joinspaces = false                -- No double spaces with join
opt.hidden = true                     -- Enable background buffers
opt.wrap = false                      -- Disable line wrap
opt.swapfile = false                  -- Disable swap file
opt.backup = false                    -- Disable backup
opt.tabstop = 4                       -- Number of spaces tabs count for
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true                  -- Use spaces instead of tabs
opt.smartindent = true                -- Smart autoindenting when starting a new line
opt.incsearch = true                  -- Show the pattern while typing search command
opt.scrolloff = 20                    -- Lines of context
opt.signcolumn = 'yes'                -- Always show signcolumn
opt.colorcolumn = '80'                -- PEP8 line length
--opt.cursorline = true                 -- Highlight cursorline
opt.list = true                       -- Show some invisible characters
opt.cmdheight = 2                     -- Command-line height
opt.wildmode = {'list', 'longest'}    -- Command-line completion mode
opt.wildignore:append({ '*.pyc', '*_build/*', '**/coverage/*',
                        '**/node_modules/*', '**/android/*',
                        '**/ios/*', '**/.git/*', })
opt.splitbelow = true                 -- Put new windows below current
opt.splitright = true                 -- Put new windows right of current
opt.clipboard = 'unnamedplus' -- registers

opt.completeopt = "menu,menuone,noselect"

---- MAPINGS -------------------------------------------------------------------
map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
map('n', '<leader>e','<cmd>e $MYVIMRC<CR>', {noremap=true, silent=true}) -- Edit config
map('n', '<leader>R','<cmd>luafile $MYVIMRC<CR>', {noremap=true, silent=true}) -- Edit config
map('v', '<', '<gv',{noremap = true, silent = true})
map('v', '>', '>gv',{noremap = true, silent = true})
map('v', 'J', ":m '>+1<CR>gv=gv", {noremap=true})
map('v', 'K', ":m '<-2<CR>gv=gv", {noremap=true})

---- TREESITTER ----------------------------------------------------------------
require 'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
    highlight = {enable = true}, --TODO try indentation and other mods
}

---- LSP CMP -------------------------------------------------------------------
local cmp = require'cmp'
cmp.setup({
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').pyright.setup {
  capabilities = capabilities
}

local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'
lspfuzzy.setup {}

map('n', '<leader>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<leader>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<leader>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

---- SAGA ----------------------------------------------------------------------
local saga = require 'lspsaga'
saga.init_lsp_saga()

map('n', 'gh', '<cmd>lua require"lspsaga.provider".lsp_finder()<CR>')
map('n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>')
-- Signature
-- Rename
-- float terminal

---- LUALINE -------------------------------------------------------------------
require('lualine').setup()

---- TELESCOPE -----------------------------------------------------------------
require('telescope').setup{}

map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', {noremap=true})
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', {noremap=true})
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', {noremap=true})
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', {noremap=true})
map('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>', {noremap=true})
