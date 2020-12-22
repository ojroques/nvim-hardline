local fn, vim = vim.fn, vim
local o, bo, wo = vim.o, vim.bo, vim.wo
local modes = {
  ['?'] = '???',
  ['n'] = 'NORMAL',
  ['i'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['v'] = 'VISUAL',
  ['V'] = 'V-LINE',
  [''] = 'V-BLOCK',
  ['c'] = 'COMMAND',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  [''] = 'S-BLOCK',
  ['t'] = 'TERMINAL',
}
local M = {}

function M.get_mode()
  if not modes[fn.mode()] then return modes['?'] end
  return modes[fn.mode()]
end

function M.get_paste()
  if not o.paste then
    return ''
  end
  return 'PASTE'
end

function M.get_spell()
  if not wo.spell then
    return ''
  end
  return string.format('SPELL [%s]', string.upper(bo.spelllang))
end

function M.get_item()
  return table.concat({
    [[%{luaeval('require("hardline.mode").get_mode()')}]], ' ',
    [[%{luaeval('require("hardline.mode").get_paste()')}]], ' ',
    [[%{luaeval('require("hardline.mode").get_spell()')}]], ' '
  })
end

return M
