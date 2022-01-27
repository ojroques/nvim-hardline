local function get_item()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
end

return {
  get_item = get_item,
}
