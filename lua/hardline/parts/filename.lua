local fn = vim.fn
local bo = vim.bo

local function get_name()
  return fn.expand('%:~:.')
end

local function get_readonly()
  if not bo.readonly then return '' end
  return '[RO]'
end

local function get_modified()
  if bo.modified then return '[+]' end
  if not bo.modifiable then return '[-]' end
  return ''
end

local function get_item()
  local name, readonly, modified = get_name(), get_readonly(), get_modified()
  if readonly ~= '' then readonly = ' ' .. readonly end
  if modified ~= '' then modified = ' ' .. modified end
  return table.concat({name, readonly, modified})
end

return {
  get_item = get_item,
}
