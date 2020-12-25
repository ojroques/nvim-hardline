local fn = vim.fn
local o, bo, wo = vim.o, vim.bo, vim.wo
local common = require('hardline.common')

local function get_mode()
  return common.modes[fn.mode()].text
end

local function get_paste()
  if not o.paste then return '' end
  return ' PASTE'
end

local function get_spell()
  if not wo.spell then return '' end
  return string.format(' SPELL[%s]', string.upper(bo.spelllang))
end

local function get_item()
  return table.concat({' ', get_mode(), get_paste(), get_spell(), ' ' })
end

return {
  get_item = get_item,
}
