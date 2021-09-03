local function get_name()
  return vim.fn.expand('%:t')
end

local function get_readonly()
  if vim.bo.readonly then
    return '[RO]'
  end
  return ''
end

local function get_modified()
  if vim.bo.modified then
    return '[+]'
  end
  if not vim.bo.modifiable then
    return '[-]'
  end
  return ''
end

local function get_item()
  local name = get_name()
  local flags = table.concat({get_readonly(), get_modified()})
  if flags ~= '' then
    flags = ' ' .. flags
  end
  return table.concat({name, flags})
end

return {
  get_item = get_item,
}
