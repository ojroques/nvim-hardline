local fn = vim.fn
local g = vim.g

local function get_hunks()
  if not g.loaded_gitgutter then return '' end
  local summary = fn.GitGutterGetHunkSummary()
  return table.concat({
    string.format('+%d', summary[1]), ' ',
    string.format('~%d', summary[2]), ' ',
    string.format('-%d', summary[3]), ' ',
  })
end

local function get_branch()
  if not g.loaded_gitgutter then return '' end
  return string.format('(%s)', fn.FugitiveHead())
end

local function get_item()
  return table.concat({' ', get_hunks(), get_branch(), ' '})
end

return {
  get_item = get_item,
}
