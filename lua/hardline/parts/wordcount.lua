local common = require('hardline.common')
local fmt = string.format

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
  local mode = common.modes[vim.fn.mode()] or common.modes['?']
  return mode.state == 'visual'
end

local function get_wordcount()
  local query = in_visual() and 'visual_words' or 'words'
  local wordcount = vim.fn.wordcount()[query]
  return fmt('%d words', wordcount)
end

local function get_item()
  if not enabled then
    common.set_cache_autocmds('hardline_wordcount')
    enabled = true
  end
  if not vim.tbl_contains(options.filetypes, vim.bo.filetype) then
    return ''
  end
  if vim.fn.line('$') > options.max_lines then
    return ''
  end
  if vim.b.hardline_wordcount and not in_visual() then
    return cache
  end
  vim.b.hardline_wordcount = true
  cache = get_wordcount()
  return cache
end

return {
  get_item = get_item,
}
