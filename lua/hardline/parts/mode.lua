local fn = vim.fn
local o, bo, wo = vim.o, vim.bo, vim.wo
local common = require('hardline.common')

local function get_mode()
  local mode = common.modes[fn.mode()] or common.modes['?']
  return mode.text
end

local function get_paste()
  if not o.paste then return '' end
  return 'PASTE'
end

local function get_spell()
  if not wo.spell then return '' end
  return string.format('SPELL[%s]', string.upper(bo.spelllang))
end

local function get_item()
  local mode, paste, spell = get_mode(), get_paste(), get_spell()
  if paste ~= '' then paste = ' ' .. paste end
  if spell ~= '' then spell = ' ' .. spell end
  return table.concat({mode, paste, spell})
end

return {
  get_item = get_item,
}
