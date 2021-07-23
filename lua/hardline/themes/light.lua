--[[
let g:airline#themes#light#palette = {}
let s:N1 = [ '#ffffff' , '#005fff' , 255 , 27  ]
let s:N2 = [ '#000087' , '#00dfff' , 18  , 45  ]
let s:N3 = [ '#005fff' , '#afffff' , 27  , 159 ]
let g:airline#themes#light#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#light#palette.normal_modified = {
\ 'airline_c': [ '#df0000' , '#ffdfdf' , 160     , 224     , ''     ] ,
\ }
--]]
local normal = {
  mode     = { guifg = '#ffffff', guibg = '#005fff', ctermfg = '255', ctermbg = '27'},
  high     = { guifg = '#000087', guibg = '#00dfff', ctermfg = '18',  ctermbg = '45'},
  med      = { guifg = '#005fff', guibg = '#afffff', ctermfg = '27',  ctermbg = '159'},
  low      = { guifg = '#0000af', guibg = '#d7ffff', ctermfg = '19',  ctermbg = '195'},
  modified = { guifg = '#df0000', guibg = '#ffdfdf', ctermfg = '160', ctermbg = '224'}
}

--[[
let s:I1 = [ '#ffffff' , '#00875f' , 255 , 29  ]
let s:I2 = [ '#005f00' , '#00df87' , 22  , 42  ]
let s:I3 = [ '#005f5f' , '#afff87' , 23  , 156 ]
let g:airline#themes#light#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#light#palette.insert_modified = {
\ 'airline_c': [ '#df0000' , '#ffdfdf' , 160     , 224     , ''     ] ,
\ }
let g:airline#themes#light#palette.insert_paste = {
\ 'airline_a': [ s:I1[0]   , '#d78700' , s:I1[2] , 172     , ''     ] ,
\ }
--]]
local insert = {
  mode         = { guifg = '#ffffff', guibg = '#00875f', ctermfg = '255', ctermbg = '29'},
  high         = { guifg = '#005f00', guibg = '#00df87', ctermfg = '22',  ctermbg = '42'},
  med          = { guifg = '#005f5f', guibg = '#afff87', ctermfg = '23',  ctermbg = '156'},
  low          = { guifg = '#008700', guibg = '#d7ff87', ctermfg = '28',  ctermbg = '192'},
  modified     = { guifg = '#df0000', guibg = '#ffdfdf', ctermfg = '160', ctermbg = '224'},
  insert_paste = { guifg = '#ffffff', guibg = '#d78700', ctermfg = '255', ctermbg = '172'},
}

--[[
let g:airline#themes#light#palette.replace = copy(g:airline#themes#light#palette.insert)
let g:airline#themes#light#palette.replace.airline_a = [ s:I2[0]   , '#ff0000' , s:I1[2] , 196     , ''     ]
let g:airline#themes#light#palette.replace_modified = g:airline#themes#light#palette.insert_modified
--]]
local replace = {
  mode      = {guifg = insert.med.guifg, guibg = '#ff0000', ctermfg = insert.high.ctermfg, ctermbg = '196'},
  high      = insert.high,
  med       = insert.med,
  low       = insert.low,
  modified  = insert.modified,
}

--[[
let s:V1 = [ '#ffffff' , '#ff5f00' , 255 , 202 ]
let s:V2 = [ '#5f0000' , '#ffaf00' , 52  , 214 ]
let s:V3 = [ '#df5f00' , '#ffff87' , 166 , 228 ]
let g:airline#themes#light#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#light#palette.visual_modified = {
\ 'airline_c': [ '#df0000' , '#ffdfdf' , 160     , 224     , ''     ] ,
\ }
--]]
local visual = {
  mode     = {guifg = '#ffffff', guibg = '#ff5f00', ctermfg = '255', ctermbg = '202'},
  high     = {guifg = '#5f0000', guibg = '#ffaf00', ctermfg = '52',  ctermbg = '214'},
  med      = {guifg = '#df5f00', guibg = '#ffff87', ctermfg = '166', ctermbg = '228'},
  low      = {guifg = '#af5f00', guibg = '#ffffd7', ctermfg = '130', ctermbg = '230'},
  modified = {guifg = '#df0000', guibg = '#ffdfdf', ctermfg = '160', ctermbg = '224'}
}

--[[
let s:IA1 = [ '#666666' , '#b2b2b2' , 242 , 249 , '' ]
let s:IA2 = [ '#8a8a8a' , '#d0d0d0' , 245 , 252 , '' ]
let s:IA3 = [ '#a8a8a8' , '#ffffff' , 255 , 248 , '' ]
let g:airline#themes#light#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
let g:airline#themes#light#palette.inactive_modified = {
\ 'airline_c': [ '#df0000' , ''        , 160     , ''      , ''     ] ,
\ }
--]]
local inactive_ext = {
  mode     = {guifg = '#666666', guibg = '#b2b2b2', ctermfg = '242', ctermbg = '249'},
  high     = {guifg = '#8a8a8a', guibg = '#d0d0d0', ctermfg = '245', ctermbg = '252'},
  med      = {guifg = '#a8a8a8', guibg = '#ffffff', ctermfg = '255', ctermbg = '248'},
  low      = {guifg = '#8a8a8a', guibg = '#d0d0d0', ctermfg = '245', ctermbg = '252'},
  modified = {guifg = '#df0000', guibg = '',        ctermfg = '160', ctermbg = ''},
}

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
    normal = normal.mode,
    normal_modified = normal.modified,
    insert = insert.mode,
    insert_paste = insert.insert_paste,
    insert_modified = insert.modified,
    replace = replace.mode,
    replace_modified = replace.modified,
    visual = visual.mode,
    visual_modified = visual.modified,
    command = {
      guifg = colors.black.gui,
      guibg = colors.red.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.red.cterm,
    },
    inactive = inactive,
    inactive_ext = inactive_ext.mode,
    inactive_ext_modified = inactive_ext.modified,
  },

  low = {
    normal = normal.low,
    insert = insert.low,
    replace = replace.low,
    visual = visual.low,
    command = {
      guifg = colors.black.gui,
      guibg = colors.red.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.red.cterm,
    },
    active = {
      guifg = colors.white.gui,
      guibg = colors.grey_cursor.gui,
      ctermfg = colors.white.cterm,
      ctermbg = colors.grey_cursor.cterm,
    },
    inactive = inactive,
    inactive_ext = inactive_ext.low,
  },

  med = {
    normal = normal.med,
    insert = insert.med,
    replace = replace.med,
    visual = visual.med,
    command = {
      guifg = colors.black.gui,
      guibg = colors.red.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.red.cterm,
    },
    active = {
      guifg = colors.yellow.gui,
      guibg = colors.grey_cursor.gui,
      ctermfg = colors.yellow.cterm,
      ctermbg = colors.grey_cursor.cterm,
    },
    inactive = inactive,
    inactive_ext = inactive_ext.med,
  },

  high = {
    normal = normal.high,
    insert = insert.high,
    replace = replace.high,
    visual = visual.high,
    command = {
      guifg = colors.black.gui,
      guibg = colors.red.gui,
      ctermfg = colors.black.cterm,
      ctermbg = colors.red.cterm,
    },
    active = {
      guifg = colors.white.gui,
      guibg = colors.grey_menu.gui,
      ctermfg = colors.white.cterm,
      ctermbg = colors.grey_menu.cterm,
    },
    inactive = inactive,
    inactive_ext = inactive_ext.high,
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



