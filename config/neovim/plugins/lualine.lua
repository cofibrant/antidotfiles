local colors = require("base46").get_theme_tb("base_30")
local conditions = {}

conditions.buffer_not_empty = function()
  return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
end

conditions.hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local mode_color = {
  n = colors.light_grey,
  i = colors.blue,
  v = colors.yellow,
  [''] = colors.yellow,
  V = colors.yellow,
  c = colors.pink,
  no = colors.red,
  s = colors.orange,
  S = colors.orange,
  [''] = colors.orange,
  ic = colors.blue,
  R = colors.cyan,
  Rv = colors.cyan,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ['r?'] = colors.yellow,
  ['!'] = colors.purple,
  t = colors.purple,
}

local mode_style = function()
  return { fg = colors.black, bg = mode_color[vim.fn.mode()], gui = "bold" }
end

require("lualine").setup({
  options = {
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = string.lower,
        separator = { left = '' },
        color = mode_style,
        right_padding = 2,
      }
    },
    lualine_b = {
      {
        'filename',
        icons_enabled = true,
        color = { fg = colors.pink },
        symbols = {
          modified = '*',
          readonly = '󰌾',
          unnamed = '[no name]',
          newfile = '[new]'
        },
      },
      {
        'branch',
        icon = '',
        color = { fg = colors.blue },
      },
      {
        'diff',
        symbols = { added = '+', modified = '*', removed = '-' },
        cond = conditions.hide_in_width,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
      },
      {
        'filetype',
        color = { fg = colors.grey_fg2 },
      },
      {
        'o:encoding',
        cond = conditions.hide_in_width,
        color = { fg = colors.grey_fg2 },
      },
      {
        'progress',
        color = { fg = colors.grey_fg2 },
      },
    },
    lualine_z = {
      {
        'location',
        separator = { right = '' },
        left_padding = 2,
        color = mode_style,
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
    'trouble',
  },
})
