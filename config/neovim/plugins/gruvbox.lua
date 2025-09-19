require("gruvbox").setup({
    italic = {
      strings = false,
    },
    palette_overrides = {
        neutral_red = "#d84231",
        neutral_green = "#78c42d",
        neutral_yellow = "#fcba04",
        neutral_blue = "#1da1f2",
        neutral_purple = "#f94a76",
        neutral_aqua = "#30d1f2",
        neutral_orange = "#fe8019",

        gray = "#777e8d",
        bright_red = "#db5343",
        bright_green = "#84c940",
        bright_yellow = "#fcc01a",
        bright_blue = "#31a9f3",
        bright_purple = "#f95882",
        bright_aqua = "#42d5f3",
        bright_orange = "#fe8b2d",

        dark0 = "#32353c";
        dark1 = "#41454d",
        dark2 = "#4c515a",
        dark3 = "#575c67",
        dark4 = "#626874",

        light0 = "#f2f3f4",
        light1 = "#d9dbdf",
        light2 = "#c1c4cb",
        light3 = "#a8acb6",
        light4 = "#8f9fa1",
    }
})

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
