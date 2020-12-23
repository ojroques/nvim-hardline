local M = {}

function M.get_hunks()
  if not vim.g.loaded_gitgutter then return '' end
  local summary = vim.fn.GitGutterGetHunkSummary()
  return table.concat({
    string.format('+%d', summary[1]),
    string.format('~%d', summary[2]),
    string.format('-%d', summary[3]),
  }, ' ')
end

function M.get_branch()
  if not vim.g.loaded_gitgutter then return '' end
  return string.format('  %s', vim.fn.FugitiveHead())
end

function M.get_item()
  return table.concat({
    [[%{luaeval('require("hardline.parts.git").get_hunks()')}]],
    [[%{luaeval('require("hardline.parts.git").get_branch()')}]],
  })
end

return M
