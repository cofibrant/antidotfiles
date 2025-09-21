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
  pmenu_bg = "#8f9fa1",
  folder_bg = "#8f9fa1",
}

M.base_16 = {
  base00 = "#32353c",
  base01 = "#373a41",
  base02 = "#4c515a",
  base03 = "#626874",
  base04 = "#c1c4cb",
  base05 = "#f2f3f4",
  base06 = "#d9dbdf",
  base07 = "#f2f3f4",
  base08 = "#30d1f2",
  base09 = "#f94a76",
  base0A = "#fcba04",
  base0B = "#78c42d",
  base0C = "#1da1f2",
  base0D = "#84c940",
  base0E = "#d84231",
  base0F = "#fe8019",
}

M.type = "dark"

M = require("base46").override_theme(M, "gruvbox")

M.polish_hl = {
  syntax = {
    -- Operator = { fg = M.base_30.nord_blue },
  },

  treesitter = {
    -- ["@operator"] = { fg = M.base_30.nord_blue },
  },
}

return M
