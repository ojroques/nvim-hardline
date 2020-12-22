local fn, vim = vim.fn, vim
local g = vim.g
local M = {}

function M.get_hunks()
  if not g.loaded_gitgutter then
    return ''
  end
  local summary = fn.GitGutterGetHunkSummary()
  return table.concat({
    string.format('+%d', summary[1]),
    string.format('~%d', summary[2]),
    string.format('-%d', summary[3]),
  }, ' ')
end

function M.get_branch()
  return ''
end

function M.get_component()
  return table.concat({
    [[%{luaeval('require("hardline.git").get_hunks()')}]],
    [[%{luaeval('require("hardline.git").get_branch()')}]],
  })
end

return M
