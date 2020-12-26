local fn, vim = vim.fn, vim
local b, bo = vim.b, vim.bo
local common = require('hardline.common')

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
  local mode = common.modes[fn.mode()] or common.modes['?']
  return mode.state == 'visual'
end

local function get_wordcount()
  local query = in_visual() and 'visual_words' or 'words'
  local wordcount = fn.wordcount()[query]
  return string.format('%d words', wordcount)
end

local function get_item()
  if not enabled then
    common.set_cache('hardline_wordcount')
    enabled = true
  end
  if not vim.tbl_contains(options.filetypes, bo.filetype) then return '' end
  if fn.line('$') > options.max_lines then return '' end
  if b.hardline_wordcount and not in_visual() then return cache end
  b.hardline_wordcount = true
  cache = get_wordcount()
  return cache
end

return {
  get_item = get_item,
}
