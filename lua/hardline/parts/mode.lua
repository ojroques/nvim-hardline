local M = {}
local modes = {
  ['?'] = {text = '???', color = 'inactive'},
  ['n'] = {text = 'NORMAL', color = 'normal'},
  ['c'] = {text = 'COMMAND', color = 'normal'},
  ['i'] = {text = 'INSERT', color = 'insert'},
  ['R'] = {text = 'REPLACE', color = 'replace'},
  ['v'] = {text = 'VISUAL', color = 'visual'},
  ['V'] = {text = 'V-LINE', color = 'visual'},
  [''] = {text = 'V-BLOCK', color = 'visual'},
  ['s'] = {text = 'SELECT', color = 'visual'},
  ['S'] = {text = 'S-LINE', color = 'visual'},
  [''] = {text = 'S-BLOCK', color = 'visual'},
  ['t'] = {text = 'TERMINAL', color = 'normal'},
}

local function color_item(item)
  local color = modes[vim.fn.mode()].color
  return string.format('%%#HardlineMode%s#%s%%##', color, item)
end

function M.get_mode()
  if not modes[vim.fn.mode()] then
    return modes['?'].text
  end
  return modes[vim.fn.mode()].text
end

function M.get_paste()
  if not vim.o.paste then return '' end
  return '  | PASTE'
end

function M.get_spell()
  if not vim.wo.spell then return '' end
  return string.format('  | SPELL [%s]', string.upper(vim.bo.spelllang))
end

function M.get_item()
  return color_item(table.concat({
    [[%{luaeval('require("hardline.parts.mode").get_mode()')}]],
    [[%{luaeval('require("hardline.parts.mode").get_paste()')}]],
    [[%{luaeval('require("hardline.parts.mode").get_spell()')}]],
  }))
end

return M
