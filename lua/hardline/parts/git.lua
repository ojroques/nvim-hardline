local fn = vim.fn
local g = vim.g

local function get_hunks()
  if not g.loaded_gitgutter then return '' end
  local summary = fn.GitGutterGetHunkSummary()
  return table.concat({
    string.format('+%d', summary[1]),
    string.format('~%d', summary[2]),
    string.format('-%d', summary[3]),
  }, ' ')
end

local function get_branch()
  local branch
  if g.loaded_fugitive then
    branch = fn.FugitiveHead()
  elseif g.loaded_gina then
    branch = fn['gina#component#repo#branch']()
  end
  return branch ~= '' and string.format('(%s)', branch) or ''
end

local function get_item()
  local hunks, branch = get_hunks(), get_branch()
  if branch == '' then return '' end
  branch = not branch and '' or ' ' .. branch
  return table.concat({hunks, branch})
end

return {
  get_item = get_item,
}
