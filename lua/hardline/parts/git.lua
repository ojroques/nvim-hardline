local common = require('hardline.common')

local function get_hunks()
  if not vim.g.loaded_gitgutter then return '' end
  local summary = vim.fn.GitGutterGetHunkSummary()
  return table.concat({
    ' ',
    string.format('+%d', summary[1]), ' ',
    string.format('~%d', summary[2]), ' ',
    string.format('-%d', summary[3]), ' ',
  })
end

local function get_branch()
  if not vim.g.loaded_gitgutter then return '' end
  return string.format('(%s) ', vim.fn.FugitiveHead())
end

local function get_item()
  return {
    text = table.concat({get_hunks(), get_branch()}),
    mode = common.get_active(),
  }
end

return {
  get_item = get_item,
}
