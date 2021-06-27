local colors = {
  black = {gui = '#fbfbfb', cterm = '236'},
  blue = {gui = '#94aadb', cterm = '39'},
  cyan = { gui = '#89bdff', cterm = '38'},
  green = {gui = '#babb63', cterm = '113'},
  grey_comment = {gui = "#a8a8a8", cterm = "59"},
  grey_cursor = {gui = "#bdbdbd", cterm = "236"},
  grey_menu = {gui = "#d5d5d5", cterm = "237"},
  purple = {gui = '#675e6e', cterm = '163'},
  red = {gui = '#a03b1e', cterm = '166'},
  white = {gui = '#f2f2f2', cterm = '251'},
  yellow = {gui = '#c59820', cterm = '178'},
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
      guibg = colors.blue.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.blue.cterm,
    },
    insert = {
      guifg = colors.black.gui,
      guibg = colors.green.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.green.cterm,
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
      guibg = colors.blue.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.blue.cterm,
    },
    current_modified = {
      guifg = colors.black.gui,
      guibg = colors.green.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.green.cterm,
    },
    background = {
      guifg = colors.blue.gui,
      guibg = colors.black.gui,
      ctermfg = colors.blue.cterm,
      ctermbg = colors.black.cterm,
    },
    background_modified = {
      guifg = colors.yellow.gui,
      guibg = colors.black.gui,
      ctermfg = colors.yellow.cterm,
      ctermbg = colors.black.cterm,
    },
  },
}
