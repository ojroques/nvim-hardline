local colors = {
  black = {gui = '#2E3440', cterm = '235', cterm16 = '0'},
  blue = { gui = '#5E81AC', cterm = '110', cterm16 = '14'},
  bluegreen = { gui = '#8FBCBB', cterm = '115', cterm = '14'},
  cyan = {gui = '#88C0D0', cterm = '67', cterm16 = '12'},
  green = {gui = '#A3BE8C', cterm = '108', cterm16 = '4'},
  grey_comment = {gui = "#616E88", cterm = "59", cterm16 = "8"},
  grey_cursor = {gui = "#3B4252", cterm = "59", cterm16 = "8"},
  grey_menu = {gui = "#4C566A", cterm = "59", cterm16 = "8"},
  purple = {gui = '#B48EAD', cterm = '139', cterm16 = '5'},
  red = {gui = '#BF616A', cterm = '131', cterm16 = '1'},
  white = {gui = '#E5E9F0', cterm = '188', cterm16 = '7'},
  yellow = {gui = '#EBCB8B', cterm = '222', cterm16 = '3'},
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
      guibg = colors.cyan.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.cyan.cterm,
    },
    insert = {
      guifg = colors.black.gui,
      guibg = colors.white.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.white.cterm,
    },
    replace = {
      guifg = colors.black.gui,
      guibg = colors.yellow.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.yellow.cterm,
    },
    visual = {
      guifg = colors.black.gui,
      guibg = colors.bluegreen.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.bluegreen.cterm,
    },
    command = {
      guifg = colors.black.gui,
      guibg = colors.cyan.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.cyan.cterm,
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
      guifg = colors.white.gui,
      guibg = colors.grey_cursor.gui,
      ctermfg = colors.white.cterm,
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
      guibg = colors.cyan.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.cyan.cterm,
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
