local colors = {
  base00 = {gui = '#2E3440', cterm = '0'},
  base01 = {gui = '#282828', cterm = '18'},
  base02 = {gui = '#383838', cterm = '19'},
  base03 = {gui = '#585858', cterm = '8'},
  base04 = {gui = '#B8B8B8', cterm = '20'},
  base05 = {gui = '#D8D8D8', cterm = '7'},
  base06 = {gui = '#E8E8E8', cterm = '21'},
  base07 = {gui = '#F8F8F8', cterm = '15'},
  base08 = {gui = '#AB4642', cterm = '1'},
  base09 = {gui = '#DC9656', cterm = '16'},
  base0A = {gui = '#F7CA88', cterm = '3'},
  base0B = {gui = '#A1B56C', cterm = '2'},
  base0C = {gui = '#86C1B9', cterm = '6'},
  base0D = {gui = '#7CAFC2', cterm = '4'},
  base0E = {gui = '#BA8BAF', cterm = '5'},
  base0F = {gui = '#A16946', cterm = '17'},
}

local inactive = {
    guifg = colors.base06.gui,
    guibg = colors.base01.gui,
  ctermfg = colors.base06.cterm,
  ctermbg = colors.base01.cterm,
}

return {
  mode = {
    inactive = inactive,
    normal = {
        guifg = colors.base00.gui,
        guibg = colors.base0D.gui,
      ctermfg = colors.base00.cterm,
      ctermbg = colors.base0D.cterm,
    },
    insert = {
        guifg = colors.base01.gui,
        guibg = colors.base0D.gui,
      ctermfg = colors.base01.cterm,
      ctermbg = colors.base0D.cterm,
    },
    replace = {
        guifg = colors.base00.gui,
        guibg = colors.base08.gui,
      ctermfg = colors.base00.cterm,
      ctermbg = colors.base08.cterm,
    },
    visual = {
        guifg = colors.base00.gui,
        guibg = colors.base08.gui,
      ctermfg = colors.base00.cterm,
      ctermbg = colors.base08.cterm,
    },
    command = {
        guifg = colors.base00.gui,
        guibg = colors.base08.gui,
      ctermfg = colors.base00.cterm,
      ctermbg = colors.base08.cterm,
    },
  },
  low = { --TODO
    active = {
        guifg = colors.base01.gui,
        guibg = colors.base00.gui,
      ctermfg = colors.base01.cterm,
      ctermbg = colors.base00.cterm,
    },
    inactive = inactive,
  },
  med = {
    active = {
        guifg = colors.base04.gui,
        guibg = colors.base01.gui,
      ctermfg = colors.base04.cterm,
      ctermbg = colors.base01.cterm,
    },
    inactive = inactive,
  },
  high = {
    active = {
        guifg = colors.base01.gui,
        guibg = colors.base0D.gui,
      ctermfg = colors.base01.cterm,
      ctermbg = colors.base0D.cterm,
    },
    inactive = inactive,
  },
  error = {
    active = {
        guifg = colors.base00.gui,
        guibg = colors.base08.gui,
      ctermfg = colors.base00.cterm,
      ctermbg = colors.base08.cterm,
    },
    inactive = inactive,
  },
  warning = {
    active = {
        guifg = colors.base00.gui,
        guibg = colors.base0B.gui,
      ctermfg = colors.base00.cterm,
      ctermbg = colors.base0B.cterm,
    },
    inactive = inactive,
  },
  bufferline = {
    separator = inactive,
    current = {
        guifg = colors.base00.gui,
        guibg = colors.base0D.gui,
      ctermfg = colors.base00.cterm,
      ctermbg = colors.base0D.cterm,
    },
    current_modified = {
        guifg = colors.base00.gui,
        guibg = colors.base0E.gui,
      ctermfg = colors.base00.cterm,
      ctermbg = colors.base0E.cterm,
    },
    background = {
        guifg = colors.base04.gui,
        guibg = colors.base01.gui,
      ctermfg = colors.base04.cterm,
      ctermbg = colors.base01.cterm,
    },
    background_modified = {
        guifg = colors.base0E.gui,
        guibg = colors.base01.gui,
      ctermfg = colors.base0E.cterm,
      ctermbg = colors.base01.cterm,
    },
  },
}
