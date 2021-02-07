local fn = vim.fn

local function get_item()
  return fn.fnamemodify(fn.getcwd(), ':~')
end

return {
  get_item = get_item,
}
