-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.g.mapleader = " "

vim.opt.keymap = "russian-dvorak"
vim.opt.iminsert = 0
vim.opt.imsearch = 0

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_tutor_mode_plugin = 1
vim.g.logging_level = 'info'
vim.g.vimsyn_embed = '1'
vim.g.python3_host_prog = "/usr/bin/python3.9"

vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'

vim.g.nowritebackup = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.scrolloff = 8
vim.opt.termguicolors = true

-- display chars for tabs and trailing spaces
vim.opt.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·"
vim.opt.list = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
