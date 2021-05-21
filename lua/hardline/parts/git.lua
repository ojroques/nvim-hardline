local fn = vim.fn
local g = vim.g
local b = vim.b
local fmt = string.format

local function concat_hunks(hunks)
  return vim.tbl_isempty(hunks) and '' or table.concat({
    fmt('+%d', hunks[1]),
    fmt('~%d', hunks[2]),
    fmt('-%d', hunks[3]),
  }, ' ')
end

local function get_hunks()
  local hunks = {}
  if g.loaded_gitgutter then
    hunks = fn.GitGutterGetHunkSummary()
  elseif g.loaded_signify then
    hunks = fn['sy#repo#get_stats']()
    hunks = hunks[1] == -1 and {} or hunks
  elseif b.gitsigns_status_dict then
    hunks = {
      b.gitsigns_status_dict.added,
      b.gitsigns_status_dict.changed,
      b.gitsigns_status_dict.removed,
    }
  end
  return concat_hunks(hunks)
end

local function get_branch()
  local branch = ''
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
  if hunks == concat_hunks({0, 0, 0}) and branch == '' then
    hunks = ''
  end
  if hunks ~= '' and branch ~= '' then
    branch = ' ' .. branch
  end
  return table.concat({hunks, branch})
end

return {
  get_item = get_item,
}
