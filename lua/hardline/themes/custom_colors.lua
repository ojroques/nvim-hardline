-- Custom colorscheme

local M = {}

M.set = function(color_table)
  local inactive = {
    guifg = color_table.inactive_comment.gui,
    guibg = color_table.inactive_cursor.gui,
    ctermfg = color_table.inactive_comment.cterm,
    ctermbg = color_table.inactive_cursor.cterm,
  }

  return {
    mode = {
      inactive = inactive,
      normal = {
        guifg = color_table.text.gui,
        guibg = color_table.normal.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.normal.cterm,
      },
      insert = {
        guifg = color_table.text.gui,
        guibg = color_table.insert.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.insert.cterm,
      },
      replace = {
        guifg = color_table.text.gui,
        guibg = color_table.replace.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.replace.cterm,
      },
      visual = {
        guifg = color_table.text.gui,
        guibg = color_table.visual.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.visual.cterm,
      },
      command = {
        guifg = color_table.text.gui,
        guibg = color_table.command.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.command.cterm,
      },
    },
    low = {
      active = {
        guifg = color_table.alt_text.gui,
        guibg = color_table.inactive_cursor.gui,
        ctermfg = color_table.alt_text.cterm,
        ctermbg = color_table.inactive_cursor.cterm,
      },
      inactive = inactive,
    },
    med = {
      active = {
        guifg = color_table.alt_text.gui,
        guibg = color_table.inactive_cursor.gui,
        ctermfg = color_table.alt_text.cterm,
        ctermbg = color_table.inactive_cursor.cterm,
      },
      inactive = inactive,
    },
    high = {
      active = {
        guifg = color_table.alt_text.gui,
        guibg = color_table.inactive_menu.gui,
        ctermfg = color_table.alt_text.cterm,
        ctermbg = color_table.inactive_menu.cterm,
      },
      inactive = inactive,
    },
    error = {
      active = {
        guifg = color_table.text.gui,
        guibg = color_table.command.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.command.cterm,
      },
      inactive = inactive,
    },
    warning = {
      active = {
        guifg = color_table.text.gui,
        guibg = color_table.warning.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.warning.cterm,
      },
      inactive = inactive,
    },
    bufferline = {
      separator = inactive,
      current = {
        guifg = color_table.text.gui,
        guibg = color_table.normal.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.normal.cterm,
      },
      current_modified = {
        guifg = color_table.text.gui,
        guibg = color_table.insert.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.insert.cterm,
      },
      background = {
        guifg = color_table.normal.gui,
        guibg = color_table.text.gui,
        ctermfg = color_table.normal.cterm,
        ctermbg = color_table.text.cterm,
      },
      background_modified = {
        guifg = color_table.insert.gui,
        guibg = color_table.text.gui,
        ctermfg = color_table.insert.cterm,
        ctermbg = color_table.text.cterm,
      },
    },
  }
end

return M
