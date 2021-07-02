-- Setting a custom colorscheme

local M = {}

M.set = function(color_table)
	local inactive = {
	  guifg = color_table.grey_comment.gui,
	  guibg = color_table.grey_cursor.gui,
	  ctermfg = color_table.grey_comment.cterm,
	  ctermbg = color_table.grey_cursor.cterm,
	}

	return {
	  mode = {
	    inactive = inactive,
	    normal = {
	      guifg = color_table.black.gui,
	      guibg = color_table.green.gui,
	      ctermfg = color_table.black.cterm,
	      ctermbg = color_table.green.cterm,
	    },
	    insert = {
	      guifg = color_table.black.gui,
	      guibg = color_table.blue.gui,
	      ctermfg = color_table.black.cterm,
	      ctermbg = color_table.blue.cterm,
	    },
	    replace = {
	      guifg = color_table.black.gui,
	      guibg = color_table.cyan.gui,
	      ctermfg = color_table.black.cterm,
	      ctermbg = color_table.cyan.cterm,
	    },
	    visual = {
	      guifg = color_table.black.gui,
	      guibg = color_table.purple.gui,
	      ctermfg = color_table.black.cterm,
	      ctermbg = color_table.purple.cterm,
	    },
	    command = {
	      guifg = color_table.black.gui,
	      guibg = color_table.red.gui,
	      ctermfg = color_table.black.cterm,
	      ctermbg = color_table.red.cterm,
	    },
	  },
	  low = {
	    active = {
	      guifg = color_table.white.gui,
	      guibg = color_table.grey_cursor.gui,
	      ctermfg = color_table.white.cterm,
	      ctermbg = color_table.grey_cursor.cterm,
	    },
	    inactive = inactive,
	  },
	  med = {
	    active = {
	      guifg = color_table.yellow.gui,
	      guibg = color_table.grey_cursor.gui,
	      ctermfg = color_table.yellow.cterm,
	      ctermbg = color_table.grey_cursor.cterm,
	    },
	    inactive = inactive,
	  },
	  high = {
	    active = {
	      guifg = color_table.white.gui,
	      guibg = color_table.grey_menu.gui,
	      ctermfg = color_table.white.cterm,
	      ctermbg = color_table.grey_menu.cterm,
	    },
	    inactive = inactive,
	  },
	  error = {
	    active = {
	      guifg = color_table.black.gui,
	      guibg = color_table.red.gui,
	      ctermfg = color_table.black.cterm,
	      ctermbg = color_table.red.cterm,
	    },
	    inactive = inactive,
	  },
	  warning = {
	    active = {
	      guifg = color_table.black.gui,
	      guibg = color_table.yellow.gui,
	      ctermfg = color_table.black.cterm,
	      ctermbg = color_table.yellow.cterm,
	    },
	    inactive = inactive,
	  },
	  bufferline = {
	    separator = inactive,
	    current = {
	      guifg = color_table.black.gui,
	      guibg = color_table.green.gui,
	      ctermfg = color_table.black.cterm,
	      ctermbg = color_table.green.cterm,
	    },
	    current_modified = {
	      guifg = color_table.black.gui,
	      guibg = color_table.blue.gui,
	      ctermfg = color_table.black.cterm,
	      ctermbg = color_table.blue.cterm,
	    },
	    background = {
	      guifg = color_table.green.gui,
	      guibg = color_table.black.gui,
	      ctermfg = color_table.green.cterm,
	      ctermbg = color_table.black.cterm,
	    },
	    background_modified = {
	      guifg = color_table.blue.gui,
	      guibg = color_table.black.gui,
	      ctermfg = color_table.blue.cterm,
	      ctermbg = color_table.black.cterm,
	    },
	  },
	}
end

return M
