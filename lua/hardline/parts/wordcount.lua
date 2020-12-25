local cmd, fn, vim = vim.cmd, vim.fn, vim
local b, bo = vim.b, vim.bo
local enabled = false
local cache = ''
local options = {
  filetypes = {
    'asciidoc',
    'help',
    'mail',
    'markdown',
    'nroff',
    'org',
    'rst',
    'plaintex',
    'tex',
    'text',
  },
  max_lines = 5000,
}

local function in_visual()
  return vim.tbl_contains({'v', 'V', '', 's', 'S', ''}, fn.mode())
end

local function get_wordcount()
  local query = in_visual() and 'visual_words' or 'words'
  local wordcount = fn.wordcount()[query]
  return string.format('%d words', wordcount)
end

local function get_item()
  if not enabled then
    cmd 'augroup hardline_wordcount'
    cmd 'autocmd!'
    cmd 'autocmd CursorHold,BufWritePost * unlet! b:hardline_wordcount'
    cmd 'augroup end'
    enabled = true
  end
  if not vim.tbl_contains(options.filetypes, bo.filetype) then return '' end
  if fn.line('$') > options.max_lines then return '' end
  if fn.exists('b:hardline_wordcount') ~= 0 and not in_visual() then
    return cache
  end
  b.hardline_wordcount = 1
  local item = table.concat({' ', get_wordcount(), ' '})
  cache = item == '  ' and '' or item
  return cache
end

return {
  get_item = get_item,
}
