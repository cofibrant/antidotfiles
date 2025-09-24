local M = {}

M.base_30 = {
	white = "#f2f3f4",
	darker_black = "#2e3138",
	black = "#32353c",
	black2 = "#373a41",
	one_bg = "#41454d",
	one_bg2 = "#4c515a",
	one_bg3 = "#575c67",
	grey = "#626874",
	grey_fg = "#6d7381",
	grey_fg2 = "#777e8d",
	light_grey = "#8f9fa1",
	red = "#d84321",
	baby_pink = "#f95882",
	pink = "#f94a76",
	line = "#393a3b",
	green = "#78c42d",
	vibrant_green = "#84c940",
	nord_blue = "#1da1f2",
	blue = "#31a9f3",
	yellow = "#fcc01a",
	sun = "#fcba04",
	purple = "#b164ff",
	dark_purple = "#9b56ff",
	teal = "#42d5f3",
	orange = "#fe8019",
	cyan = "#30d1f2",
	statusline_bg = "#35393d",
	lightbg = "#575c67",
	pmenu_bg = "#1da1f2",
	folder_bg = "#1da1f2",
}

M.base_16 = {
	base00 = "#32353c",
	base01 = "#373a41",
	base02 = "#4c515a",
	base03 = "#575c67",
	base04 = "#a8acb6",
	base05 = "#c1c4cb",
	base06 = "#d9dbdf",
	base07 = "#f2f3f4",
	base08 = "#d84231",
	base09 = "#fe8019",
	base0A = "#fcba04",
	base0B = "#78c42d",
	base0C = "#30d1f2",
	base0D = "#1da1f2",
	base0E = "#f94a76",
	base0F = "#fb4934",
}

M.type = "dark"

M = require("base46").override_theme(M, "iro")

M.polish_hl = {
	-- syntax = {},

	treesitter = {
		["@variable"] = { fg = M.base_30.white },
		["@variable.parameter"] = { fg = M.base_30.white },
		["@variable.builtin"] = { fg = M.base_30.pink },
		["@variable.member"] = { fg = M.base_30.blue },
		["@module"] = { fg = M.base_30.cyan },
		["@function"] = { fg = M.base_30.vibrant_green, bold = true },
		["@function.call"] = { fg = M.base_30.vibrant_green, bold = true },
		["@function.macro"] = { fg = M.base_30.cyan },
		["@function.builtin"] = { fg = M.base_30.orange },
		["@keyword.modifier"] = { fg = M.base_30.orange },
		["@keyword"] = { fg = M.base_30.red },
		["@keyword.repeat"] = { fg = M.base_30.red },
		["@keyword.conditional"] = { fg = M.base_30.red },
		["@keyword.function"] = { fg = M.base_30.red },
		["@keyword.return"] = { fg = M.base_30.red },
		["@punctuation.bracket"] = { fg = M.base_30.light_grey },
		["@punctuation.delimiter"] = { fg = M.base_30.red },
		["@operator"] = { fg = M.base_30.orange },
		["@number"] = { fg = M.base_30.purple, bold = true },
		["@boolean"] = { fg = M.base_30.purple, bold = true },
		["@type.builtin"] = { fg = M.base_30.pink },
		["@constant"] = { fg = M.base_30.pink },
		["@constant.builtin"] = { fg = M.base_30.pink },
		["@attribute"] = { fg = M.base_30.pink },
		["@string.special.path"] = { fg = M.base_30.pink, bold = true },
	},
}

return M
