local fn = vim.fn
local g = vim.g
local fmt = string.format

local function get_hunks()
  local summary
  if g.loaded_gitgutter then
    summary = fn.GitGutterGetHunkSummary()
  elseif g.loaded_signify then
    summary = fn['sy#repo#get_stats']()
    if (summary[1] == -1) then -- signify returns {-1, -1, -1} in empty buffer
      return ''
    end
  else
    return ''
  end
  return table.concat({
    fmt('+%d', summary[1]),
    fmt('~%d', summary[2]),
    fmt('-%d', summary[3]),
  }, ' ')
end

local function get_branch()
  local branch
  if g.loaded_fugitive then
    branch = fn.FugitiveHead()
  elseif g.loaded_gina then
    branch = fn['gina#component#repo#branch']()
  elseif g.loaded_gitbranch then
    branch = fn['gitbranch#name']()
  end
  return branch ~= '' and fmt('(%s)', branch) or ''
end

local function get_item()
  local hunks, branch = get_hunks(), get_branch()
  if branch == '' then
    return ''
  end
  branch = not branch and '' or ' ' .. branch
  return table.concat({hunks, branch})
end

return {
  get_item = get_item,
}
