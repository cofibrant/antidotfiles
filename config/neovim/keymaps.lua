-- Neovim keymaps

-- Keymapping utility function
local function map(mode, lhs, rhs, desc, opts)
    opts = opts or { silent = true }
    opts.desc = desc
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Window movement
map({'n', 't'}, '<C-h>', '<C-w>h')
map({'n', 't'}, '<C-j>', '<C-w>j')
map({'n', 't'}, '<C-k>', '<C-w>k')
map({'n', 't'}, '<C-l>', '<C-w>l')
