local nnoremap = require("yar.keymap").nnoremap

nnoremap("<leader>pv", "<cmd>Lex<CR>")
nnoremap("<leader>f", require("telescope.builtin").find_files)

