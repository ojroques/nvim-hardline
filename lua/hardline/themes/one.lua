local colors = {
  red = {gui = '#E06C75', cterm = '204', cterm16 = '1'},
  green = {gui = '#98C379', cterm = '114', cterm16 = '2'},
  yellow = {gui = '#E5C07B', cterm = '180', cterm16 = '3'},
  blue = {gui = '#61AFEF', cterm = '39', cterm16 = '4'},
  purple = {gui = '#C678DD', cterm = '170', cterm16 = '5'},
  white = {gui = '#ABB2BF', cterm = '145', cterm16 = '7'},
  black = {gui = '#282C34', cterm = '235', cterm16 = '0'},
  visual_grey = {gui = "#3E4452", cterm = "237", cterm16 = "15"},
  cursor_grey = {gui = "#2C323C", cterm = "236", cterm16 = "8"},
}

return {
  mode = {
    inactive = {
      guifg = colors.white.gui,
      guibg = colors.visual_grey.gui,
      ctermfg = colors.white.cterm,
      ctermbg = colors.visual_grey.cterm,
    },
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
    active = {
      guifg = colors.white.gui,
      guibg = colors.cursor_grey.gui,
      ctermfg = colors.white.cterm,
      ctermbg = colors.cursor_grey.cterm,
    },
    inactive = {
      guifg = colors.visual_grey.gui,
      guibg = colors.black.gui,
      ctermfg = colors.visual_grey.cterm,
      ctermbg = colors.black.cterm,
    },
  },
  med = {
    active = {
      guifg = colors.white.gui,
      guibg = colors.cursor_grey.gui,
      ctermfg = colors.white.cterm,
      ctermbg = colors.cursor_grey.cterm,
    },
    inactive = {
      guifg = colors.visual_grey.gui,
      guibg = colors.black.gui,
      ctermfg = colors.visual_grey.cterm,
      ctermbg = colors.black.cterm,
    },
  },
  high = {
    active = {
      guifg = colors.white.gui,
      guibg = colors.visual_grey.gui,
      ctermfg = colors.white.cterm,
      ctermbg = colors.visual_grey.cterm,
    },
    inactive = {
      guifg = colors.visual_grey.gui,
      guibg = colors.black.gui,
      ctermfg = colors.visual_grey.cterm,
      ctermbg = colors.black.cterm,
    },
  },
  error = {
    active = {
      guifg = colors.black.gui,
      guibg = colors.red.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.red.cterm,
    },
    inactive = {
      guifg = colors.black.gui,
      guibg = colors.white.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.white.cterm,
    },
  },
  warning = {
    active = {
      guifg = colors.black.gui,
      guibg = colors.yellow.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.yellow.cterm,
    },
    inactive = {
      guifg = colors.visual_grey.gui,
      guibg = colors.white.gui,
      ctermfg = colors.visual_grey.cterm,
      ctermbg = colors.white.cterm,
    },
  },
}
