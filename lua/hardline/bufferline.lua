local fn, vim = vim.fn, vim

local function exclude(bufnr)
  return (fn.buflisted(bufnr) == 0 or fn.getbufvar(bufnr, '&filetype') == 'qf')
end

local function get_head(path, tail)
  local result = path
  for i = 1, #vim.split(tail, '/', true) do
    result = fn.fnamemodify(result, ':~:h')
  end
  return fn.fnamemodify(result, ':t')
end

local function unique_tail(buffers)
  local hist = {}
  local duplicate = false
  for _, buffer in ipairs(buffers) do
    hist[buffer.name] = not hist[buffer.name] and 1 or hist[buffer.name] + 1
    duplicate = duplicate or hist[buffer.name] > 1
  end
  if not duplicate then return end
  for _, buffer in ipairs(buffers) do
    if hist[buffer.name] > 1 then
      local parent = get_head(fn.bufname(buffer.bufnr), buffer.name)
      buffer.name = string.format('%s/%s', parent, buffer.name)
    end
  end
  unique_tail(buffers)
end

local function to_section(buffer)
  local flags = {}
  local item = buffer.name == '' and '[No Name]' or buffer.name
  if buffer.flags.modified then table.insert(flags, '[+]') end
  if not buffer.flags.modifiable then table.insert(flags, '[-]') end
  if buffer.flags.readonly then table.insert(flags, '[RO]') end
  flags = table.concat(flags)
  item = flags == '' and item or string.format('%s %s', item, flags)
  return {
    class = 'bufferline',
    item = string.format(' %s ', item),
    modified = buffer.flags.modified,
    current = buffer.current,
  }
end

local function get_buffers()
  local buffers = {}
  for nr = 1, fn.bufnr('$') do
    if not exclude(nr) then
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
