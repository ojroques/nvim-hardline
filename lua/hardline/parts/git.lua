local fn = vim.fn
local g = vim.g
local b = vim.b
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
  elseif b.gitsigns_status_dict ~= nil then
    local status_dict = b.gitsigns_status_dict
    if status_dict.added == nil then
      return ''
    end
    summary = {status_dict.added, status_dict.changed, status_dict.removed}
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
  elseif b.gitsigns_head ~= nil then
    branch = b.gitsigns_head
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
