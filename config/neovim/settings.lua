-- Neovim settings

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.autoindent = true
opt.cursorline = true
opt.ignorecase = true
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
opt.wrap = true
-- continue comments when going down a line, hit C-u to remove the added comment prefix
opt.formatoptions:append('cro')
-- don't save keymaps and local options
opt.sessionoptions:remove('options')
-- no auto folding
opt.foldlevelstart = 99
