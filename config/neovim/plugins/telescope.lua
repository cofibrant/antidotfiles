local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

require('telescope').setup({
    defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        border = true;
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
        },
        mappings = {
            n = { 
              ["q"] = actions.close,
              ["<C-t>"] = open_with_trouble,
            },
            i = {
              ["<C-t>"] = open_with_trouble,
            },
        },
    },
    extensions = {},
})
