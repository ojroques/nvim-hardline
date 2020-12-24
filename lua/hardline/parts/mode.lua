local common = require('hardline.common')

local function get_paste()
  if not vim.o.paste then return '' end
  return '|PASTE'
end

local function get_spell()
  if not vim.wo.spell then return '' end
  return string.format('|SPELL[%s]', string.upper(vim.bo.spelllang))
end

local function get_item()
  local mode = common.get_mode()
  return {
    text = table.concat({
      ' ',
      string.format('%s', mode.text),
      get_paste(),
      get_spell(),
      ' '
    }),
    mode = mode.color,
  }
end

return {
  get_item = get_item,
}
