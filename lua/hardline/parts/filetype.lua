local function get_filetype()
  return string.format('%s', vim.bo.filetype)
end

local function get_item()
  return table.concat({' ', get_filetype(), ' '})
end

return {
  get_item = get_item,
}
