local bo = vim.bo

local function get_item()
  return bo.filetype
end

return {
  get_item = get_item,
}
