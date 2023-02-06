local colors = {
  transparent = {gui = 'NONE', cterm = '16', cterm16 = '0'},
  grey_medium = {gui = '#1E1E2E', cterm = '17', cterm16 = '0'},
  grey_inactive = {gui = '#7E84A0', cterm = '61', cterm16 = '8'},
  grey_light = {gui = '#969DBC', cterm = '69', cterm16 = '7'},
  black = {gui = '#07070A', cterm = '16', cterm16 = '0'},
  white = {gui = '#AEB7D9', cterm = '189', cterm16 = '15'},
  red = {gui = '#F38BA8', cterm = '218', cterm16 = '9'},
  yellow = {gui = '#F9E2AF', cterm = '223', cterm16 = '11'},
}

local inactive = {
  guifg = colors.grey_inactive.gui,
  guibg = colors.transparent.gui,
  ctermfg = colors.grey_inactive.cterm,
  ctermbg = colors.transparent.cterm,
}

local common_light = {
  guifg = colors.black.gui,
  guibg = colors.grey_light.gui,
  ctermfg = colors.black.cterm,
  ctermbg = colors.grey_light.cterm,
}

local common_dark = {
  guifg = colors.white.gui,
  guibg = colors.grey_medium.gui,
  ctermfg = colors.white.cterm,
  ctermbg = colors.grey_medium.cterm,
}

return {
  mode = {
    inactive = inactive,
    normal = common_light,
    insert = common_light,
    replace = common_light,
    visual = common_light,
    command = common_light,
  },
  low = {
    active = common_dark,
    inactive = inactive,
  },
  med = {
    active = common_dark,
    inactive = inactive,
  },
  high = {
    active = common_dark,
    inactive = inactive,
  },
  error = {
    active = {
      guifg = colors.red.gui,
      guibg = colors.grey_medium.gui,
      ctermfg = colors.red.cterm,
      ctermbg = colors.grey_medium.cterm,
    },
    inactive = inactive,
  },
  warning = {
    active = {
      guifg = colors.yellow.gui,
      guibg = colors.grey_medium.gui,
      ctermfg = colors.yellow.cterm,
      ctermbg = colors.grey_medium.cterm,
    },
    inactive = inactive,
  },
  bufferline = {
    separator = inactive,
    current = common_light,
    current_modified = common_light,
    background = inactive,
    background_modified = inactive,
  },
}
