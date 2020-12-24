local common = require('hardline.common')

local function get_filetype()
  return string.format(' %s ', vim.bo.filetype)
end

local function get_item()
  return {
    text = get_filetype(),
    mode = common.get_active(),
  }
end

return {
  get_item = get_item,
}
