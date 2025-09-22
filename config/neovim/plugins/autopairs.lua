require("nvim-autopairs").setup({
    check_ts = true,
    ts_config = {
        rust = {'string'},
        cpp = {'string'},
        lua = {'string'},
    }
})
