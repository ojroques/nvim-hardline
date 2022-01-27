local common = require('hardline.common')
local fmt = string.format

local function get_mode()
  local mode = common.modes[vim.fn.mode()] or common.modes['?']
  return mode.text
end

local function get_paste()
  if not vim.o.paste then
    return ''
  end
  return 'PASTE'
end

local function get_spell()
  if not vim.wo.spell then
    return ''
  end
  return fmt('SPELL[%s]', string.upper(vim.bo.spelllang))
end

local function get_item()
  local mode, paste, spell = get_mode(), get_paste(), get_spell()
  if paste ~= '' then
    paste = ' ' .. paste
  end
  if spell ~= '' then
    spell = ' ' .. spell
  end
  return table.concat({mode, paste, spell})
end

return {
  get_item = get_item,
}
