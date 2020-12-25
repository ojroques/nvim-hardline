local fn = vim.fn

local function get_item()
  return table.concat({' ', fn.expand('%:~:.'), ' %r%m '})
end

return {
  get_item = get_item,
}
