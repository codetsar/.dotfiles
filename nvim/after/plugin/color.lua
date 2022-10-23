vim.cmd("colorscheme tokyonight")

require("tokyonight").setup({
    -- config
    style = "storm", -- storm, moon, dark
    light_style = "day",
    transparent = false,
    terminal_colors = true,
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
    },
})

vim.opt.colorcolumn = '80'
