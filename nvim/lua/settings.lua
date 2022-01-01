local cmd = vim.cmd
local exec = vim.api.nvim_exec
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<Space>', '')
g.mapleader = ' '             -- change leader to a comma
opt.mouse = 'a'               -- enable mouse support
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.swapfile = false          -- don't use swapfile
opt.backup = false            -- dont use backup

g.python3_host_prog = '/home/yar/venv/bin/python3.10'

opt.encoding = 'utf-8'
opt.keymap = 'russian-dvorak'
opt.iminsert = 0
opt.imsearch = 0

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true             -- show line number
opt.relativenumber = true
opt.showmatch = true          -- highlight matching parenthesis
opt.foldmethod = 'marker'     -- enable folding (default 'foldmarker')
opt.colorcolumn = '80'        -- line lenght marker at 80 columns
opt.splitright = true         -- vertical split to the right
opt.splitbelow = true         -- horizontal split to the bottom
opt.ignorecase = true         -- ignore case letters when search
opt.joinspaces = false
opt.smartcase = true          -- ignore lowercase for the whole pattern
opt.linebreak = true          -- wrap on word boundary
opt.wrap = false              -- Disable line wrap
opt.scrolloff = 20            -- Lines of context
opt.incsearch = true          -- Show the pattern while typing search command
opt.signcolumn = 'yes'        -- Always show signcolumn
opt.list = true               -- Show some invisible characters
opt.cmdheight = 2             -- Command-line height
opt.wildmode = {'list', 'longest'} -- Command-line completion mode
opt.wildignore:append({ '*.pyc', '*_build/*', '**/coverage/*',
                        '**/node_modules/*', '**/android/*',
                        '**/ios/*', '**/.git/*', })
opt.splitbelow = true                 -- Put new windows below current
opt.splitright = true                 -- Put new windows right of current

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]


-- highlight on yank
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]], false)

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true         -- enable background buffers
opt.history = 100         -- remember n lines in history
opt.lazyredraw = true     -- faster scrolling
opt.synmaxcol = 240       -- max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
opt.termguicolors = true      -- enable 24-bit RGB colors

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
-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
-- insert mode completion options
opt.completeopt = 'menu,menuone,noselect'

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------
-- open a terminal pane on the right using :Term
cmd [[command Term :botright vsplit term://$SHELL]]

-- Terminal visual tweaks
--- enter insert mode when switching to terminal
--- close terminal buffer on process exit
cmd [[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]]

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- disable builtins plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

-- disable nvim intro
opt.shortmess:append "sI"

---- MAPINGS -------------------------------------------------------------------
map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
map('n', '<leader>e','<cmd>e $MYVIMRC<CR>', {noremap=true, silent=true}) -- Edit config
map('n', '<leader>R','<cmd>luafile $MYVIMRC<CR>', {noremap=true, silent=true}) -- Edit config
map('v', '<', '<gv',{noremap = true, silent = true})
map('v', '>', '>gv',{noremap = true, silent = true})
map('v', 'J', ":m '>+1<CR>gv=gv", {noremap=true})
map('v', 'K', ":m '<-2<CR>gv=gv", {noremap=true})
