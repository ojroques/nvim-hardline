local common = require('hardline.common')

local function get_name()
  return vim.fn.expand('%:~:.')
end

local function get_item()
  return {
    text = table.concat({' %<', get_name()}),
    mode = common.get_active(),
  }
end

return {
  get_item = get_item,
}
