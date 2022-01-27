local function get_item()
  return vim.bo.filetype
end

return {
  get_item = get_item,
}
