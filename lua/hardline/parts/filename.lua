local function get_item()
  local name = vim.fn.expand('%:~:.')
  return table.concat({' ', '%<', name, ' '})
end

return {
  get_item = get_item(),
}
