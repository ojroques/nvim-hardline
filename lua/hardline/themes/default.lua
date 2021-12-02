local colors = {
  black = {gui = '#282C34', cterm = '235', cterm16 = '0'},
  blue = {gui = '#61AFEF', cterm = '39', cterm16 = '4'},
  cyan = { gui = '#56B6C2', cterm = '38', cterm16 = '6'},
  green = {gui = '#98C379', cterm = '114', cterm16 = '2'},
  grey_comment = {gui = "#5C6370", cterm = "59", cterm16 = "15"},
  grey_cursor = {gui = "#2C323C", cterm = "236", cterm16 = "8"},
  grey_menu = {gui = "#3E4452", cterm = "237", cterm16 = "8"},
  purple = {gui = '#C678DD', cterm = '170', cterm16 = '5'},
  red = {gui = '#E06C75', cterm = '204', cterm16 = '1'},
  white = {gui = '#ABB2BF', cterm = '145', cterm16 = '7'},
  yellow = {gui = '#E5C07B', cterm = '180', cterm16 = '3'},
}

local inactive = {
  guifg = colors.grey_comment.gui,
  guibg = colors.grey_cursor.gui,
  ctermfg = colors.grey_comment.cterm,
  ctermbg = colors.grey_cursor.cterm,
}

return {
  mode = {
    inactive = inactive,
    normal = {
      guifg = colors.black.gui,
      guibg = colors.green.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.green.cterm,
    },
    insert = {
      guifg = colors.black.gui,
      guibg = colors.blue.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.blue.cterm,
    },
    replace = {
      guifg = colors.black.gui,
      guibg = colors.cyan.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.cyan.cterm,
    },
    visual = {
      guifg = colors.black.gui,
      guibg = colors.purple.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.purple.cterm,
    },
    command = {
      guifg = colors.black.gui,
      guibg = colors.red.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.red.cterm,
    },
  },
  low = {
    active = {
      guifg = colors.white.gui,
      guibg = colors.grey_cursor.gui,
      ctermfg = colors.white.cterm,
      ctermbg = colors.grey_cursor.cterm,
    },
    inactive = inactive,
  },
  med = {
    active = {
      guifg = colors.yellow.gui,
      guibg = colors.grey_cursor.gui,
      ctermfg = colors.yellow.cterm,
      ctermbg = colors.grey_cursor.cterm,
    },
    inactive = inactive,
  },
  high = {
    active = {
      guifg = colors.white.gui,
      guibg = colors.grey_menu.gui,
      ctermfg = colors.white.cterm,
      ctermbg = colors.grey_menu.cterm,
    },
    inactive = inactive,
  },
  error = {
    active = {
      guifg = colors.black.gui,
      guibg = colors.red.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.red.cterm,
    },
    inactive = inactive,
  },
  warning = {
    active = {
      guifg = colors.black.gui,
      guibg = colors.yellow.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.yellow.cterm,
    },
    inactive = inactive,
  },
  bufferline = {
    separator = inactive,
    current = {
      guifg = colors.black.gui,
      guibg = colors.green.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.green.cterm,
    },
    current_modified = {
      guifg = colors.black.gui,
      guibg = colors.blue.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.blue.cterm,
    },
    background = {
      guifg = colors.green.gui,
      guibg = colors.black.gui,
      ctermfg = colors.green.cterm,
      ctermbg = colors.black.cterm,
    },
    background_modified = {
      guifg = colors.blue.gui,
      guibg = colors.black.gui,
      ctermfg = colors.blue.cterm,
      ctermbg = colors.black.cterm,
    },
  },
}
