local nnoremap = require("yar.keymap").nnoremap
local nmap = require("yar.keymap").nmap

nnoremap("<leader>pv", "<cmd>Lex<CR>")
nnoremap("<leader>ff", require("telescope.builtin").find_files)
nnoremap("<leader>fg", require("telescope.builtin").live_grep)

nmap("H", "^")
nmap("L", "$")
