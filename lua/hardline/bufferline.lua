local fn, vim = vim.fn, vim
local fmt = string.format

local function is_excluded(bufnr, settings)
  local excluded = fn.buflisted(bufnr) == 0 or fn.getbufvar(bufnr, '&filetype') == 'qf'
  if settings.exclude_terminal then
    excluded = excluded or fn.getbufvar(bufnr, '&buftype') == 'terminal'
  end
  return excluded
end

local function get_head(path, tail)
  local result = fn.fnamemodify(path, ':p')
  for i = 1, #vim.split(tail, '/') do
    result = fn.fnamemodify(result, ':h')
  end
  return fn.fnamemodify(result, ':t')
end

local function unique_tail(buffers)
  local hist = {}
  local duplicate = false
  for _, buffer in ipairs(buffers) do
    if not hist[buffer.name] then
      hist[buffer.name] = 1
    elseif buffer.name ~= '' then
      hist[buffer.name] = hist[buffer.name] + 1
    end
    duplicate = duplicate or hist[buffer.name] > 1
  end
  if not duplicate then
    return
  end
  for _, buffer in ipairs(buffers) do
    if hist[buffer.name] > 1 then
      local parent = get_head(fn.bufname(buffer.bufnr), buffer.name)
      buffer.name = fmt('%s/%s', parent, buffer.name)
    end
  end
  unique_tail(buffers)
end

local function to_section(buffer, idx, settings)
  local flags = {}
  local item = buffer.name == '' and '[No Name]' or buffer.name
  if buffer.flags.modified then
    table.insert(flags, '[+]')
  end
  if not buffer.flags.modifiable then
    table.insert(flags, '[-]')
  end
  if buffer.flags.readonly then
    table.insert(flags, '[RO]')
  end
  flags = table.concat(flags)
  item = flags == '' and item or fmt('%s %s', item, flags)
  if settings.show_index then
    item = fmt(' %d:%s ', idx, item)
  else
    item = fmt(' %s ', item)
  end
  return {
    class = 'bufferline',
    item = item,
    modified = buffer.flags.modified,
    current = buffer.current,
  }
end

local function get_buffers(settings)
  local buffers = {}
  for nr = 1, fn.bufnr('$') do
    if not is_excluded(nr, settings) then
      table.insert(buffers, {
        bufnr = nr,
        name = fn.fnamemodify(fn.bufname(nr), ':t'),
        current = nr == fn.bufnr('%'),
        flags = {
          modified = fn.getbufvar(nr, '&modified') == 1,
          modifiable = fn.getbufvar(nr, '&modifiable') == 1,
          readonly = fn.getbufvar(nr, '&readonly') == 1,
        },
      })
    end
  end
  unique_tail(buffers)
  return buffers
end

return {
  to_section = to_section,
  get_buffers = get_buffers,
}
