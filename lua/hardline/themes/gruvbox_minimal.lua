local colors = {
  grey_dark = {gui = '#3b3836', cterm = '240', cterm16 = '0'},
  grey_medium = {gui = '#4f4945', cterm = '245', cterm16 = '0'},
  grey_inactive = {gui = '#897e70', cterm = '247', cterm16 = '8'},
  grey_light = {gui = '#beb297', cterm = '250', cterm16 = '8'},
  black = {gui = '#1d2021', cterm = '234', cterm16 = '0'},
  white = {gui = '#fbf1c7', cterm = '228', cterm16 = '15'},
  red = {gui = '#fb4934', cterm = '167', cterm16 = '9'},
  yellow = {gui = '#fabd2f', cterm = '214', cterm16 = '11'},
}

local inactive = {
  guifg = colors.grey_inactive.gui,
  guibg = colors.grey_dark.gui,
  ctermfg = colors.grey_inactive.cterm,
  ctermbg = colors.grey_dark.cterm,
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
    background = common_dark,
    background_modified = common_dark,
  },
}
