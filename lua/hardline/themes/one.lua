local colors = {
  red = {gui = '#E06C75', cterm = '204', cterm16 = '1'},
  green = {gui = '#98C379', cterm = '114', cterm16 = '2'},
  yellow = {gui = '#E5C07B', cterm = '180', cterm16 = '3'},
  blue = {gui = '#61AFEF', cterm = '39', cterm16 = '4'},
  purple = {gui = '#C678DD', cterm = '170', cterm16 = '5'},
  white = {gui = '#ABB2BF', cterm = '145', cterm16 = '7'},
  black = {gui = '#282C34', cterm = '235', cterm16 = '0'},
  comment_grey = {gui = "#5C6370", cterm = "59", cterm16 = "15"},
  cursor_grey = {gui = "#2C323C", cterm = "236", cterm16 = "8"},
  menu_grey = {gui = "#3E4452", cterm = "237", cterm16 = "8"},
}

local inactive = {
  guifg = colors.comment_grey.gui,
  guibg = colors.cursor_grey.gui,
  ctermfg = colors.comment_grey.cterm,
  ctermbg = colors.cursor_grey.cterm,
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
      guibg = colors.red.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.red.cterm,
    },
    visual = {
      guifg = colors.black.gui,
      guibg = colors.purple.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.purple.cterm,
    },
  },
  low = {
    active = inactive,
    inactive = inactive,
  },
  med = {
    active = {
      guifg = colors.white.gui,
      guibg = colors.cursor_grey.gui,
      ctermfg = colors.white.cterm,
      ctermbg = colors.cursor_grey.cterm,
    },
    inactive = inactive,
  },
  high = {
    active = {
      guifg = colors.white.gui,
      guibg = colors.menu_grey.gui,
      ctermfg = colors.white.cterm,
      ctermbg = colors.menu_grey.cterm,
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
}
