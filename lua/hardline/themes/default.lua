local colors = {
  black = {gui = '#181A1F'},
  blue = {gui = '#61AFEF'},
  cyan = { gui = '#56B6C2'},
  green = {gui = '#98C379'},
  grey = {gui = '#5C6370'},
  grey_light = {gui = '#31353F'},
  purple = {gui = '#C678DD'},
  red = {gui = '#E86671'},
  white = {gui = '#ABB2BF'},
  yellow = {gui = '#E5C07B'},
}

local inactive = {guifg = colors.grey.gui, guibg = colors.grey_light.gui}

return {
  mode = {
    normal = {guifg = colors.black.gui, guibg = colors.green.gui},
    insert = {guifg = colors.black.gui, guibg = colors.blue.gui},
    command = {guifg = colors.black.gui, guibg = colors.red.gui},
    visual = {guifg = colors.black.gui, guibg = colors.purple.gui},
    replace = {guifg = colors.black.gui, guibg = colors.cyan.gui},
    inactive = inactive,
  },
  low = {
    active = {guifg = colors.white.gui, guibg = colors.grey_light.gui},
    inactive = inactive,
  },
  med = {
    active = {guifg = colors.yellow.gui, guibg = colors.grey_light.gui},
    inactive = inactive,
  },
  high = {
    active = {guifg = colors.white.gui, guibg = colors.grey.gui},
    inactive = inactive,
  },
  error = {
    active = {guifg = colors.black.gui, guibg = colors.red.gui},
    inactive = inactive,
  },
  warning = {
    active = {guifg = colors.black.gui, guibg = colors.yellow.gui},
    inactive = inactive,
  },
}
