local fn = vim.fn

local function get_item()
  local name = fn.expand('%:~:.')
  return table.concat({' ', '%<', name, ' '})
end

return {
  get_item = get_item,
}
