-- Basic settings

local opt = vim.opt
local o = vim.o
local g = vim.g

-- base46 cache path
g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- disable `netrw` (for `nvim-tree.lua`)
g.loaded_netrw = true
g.loaded_netrwPlugin = true

opt.ignorecase = true
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
opt.wrap = true
o.laststatus = 3
o.showmode = false
opt.fillchars = { eob = " " }

-- mouse input in all modes
o.mouse = "a"
-- makes directional keys wrap lines
opt.whichwrap:append("<>[]hl")

-- numbers
opt.number = true
o.numberwidth = 2
o.ruler = false
opt.relativenumber = true
opt.cursorline = true
o.cursorlineopt = "both"

-- indentation
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.smarttab = true

-- continue comments when going down a line, hit C-u to remove the added comment prefix
opt.formatoptions:append("cro")
-- don't save keymaps and local options
opt.sessionoptions:remove("options")
-- no auto folding
opt.foldlevelstart = 99

-- Keybinds

-- keymapping utility function
local function map(mode, lhs, rhs, desc, opts)
	opts = opts or { silent = true }
	opts.desc = desc
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- rebind leader to <Space>
g.mapleader = " "

-- insert mode movement
map("i", "<C-h>", "<Left>", "move left")
map("i", "<C-l>", "<Right>", "move right")
map("i", "<C-j>", "<Down>", "move down")
map("i", "<C-k>", "<Up>", "move up")

-- window movement
map({ "n", "t" }, "<C-h>", "<Cmd>wincmd h<CR>")
map({ "n", "t" }, "<C-j>", "<Cmd>wincmd j<CR>")
map({ "n", "t" }, "<C-k>", "<Cmd>wincmd k<CR>")
map({ "n", "t" }, "<C-l>", "<Cmd>wincmd l<CR>")

-- comments
map("n", "<leader>/", "gcc", "toggle comment", { remap = true })
map("v", "<leader>/", "gc", "toggle comment", { remap = true })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", "escape terminal mode")

-- file tree
map({ "n", "t" }, "<leader>e", "<cmd>NvimTreeToggle<CR>", "toggle file tree")

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", "telescope find files")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", "telescope live grep")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", "telescope search buffers")
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", "telescope search help info")
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", "telescope search current buffer")

-- misc
map("n", "<Esc>", "<cmd>noh<CR>", "clear highlights")

-- vsnip movement
map({ "i", "s" }, "<Tab>", function()
	return vim.fn["vsnip#jumpable"](1) == 1 and "<Plug>(vsnip-jump-next)" or "<Tab>"
end, "vsnip jump to next", { expr = true })
map({ "i", "s" }, "<S-Tab>", function()
	return vim.fn["vsnip#jumpable"](-1) == 1 and "<Plug>(vsnip-jump-prev)" or "<S-Tab>"
end, "vsnip jump to previous", { expr = true })

-- trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", "trouble toggle global diagnostics")
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "trouble toggle buffer diagnostics")
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", "trouble toggle symbols")
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "trouble toggle lsp")
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", "trouble toggle location list")
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", "trouble toggle quickfix list")

-- repeatable movement
local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move, "repeat last move")
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite, "oppose last move")
map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, "find forward", { expr = true })
map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, "find backward", { expr = true })
map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, "'til forward", { expr = true })
map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, "'til backward", { expr = true })

local gs = require("gitsigns")
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)

map({ "n", "x", "o" }, "]h", next_hunk_repeat, "next hunk")
map({ "n", "x", "o" }, "[h", prev_hunk_repeat, "previous hunk")

-- disable splash nonsense
vim.cmd("set shortmess+=I")

-- diagnostic icons
local symbols = { Error = "", Info = "", Hint = "", Warn = "" }

for name, icon in pairs(symbols) do
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

-- base46 eager setup
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end
