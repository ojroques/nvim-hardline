local fn = vim.fn
local g = vim.g

local function get_hunks()
  local summary
  if g.loaded_gitgutter then
    summary = fn.GitGutterGetHunkSummary()
  elseif g.loaded_signify then
    summary = fn['sy#repo#get_stats']()
    -- signify return [-1,-1,-1] in empty buffer
    -- that is why we check if one of value is -1
    -- then stop the operation by return empty string
    if (summary[1] == -1) then
      return ''
    end
  else
    -- return empty string if none of them is loaded
    return ''
  end
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
