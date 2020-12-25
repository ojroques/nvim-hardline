local cmd, fn, vim = vim.cmd, vim.fn, vim
local b, bo = vim.b, vim.bo
local enabled = false
local cache = ''
local options = {
  c_langs = {'arduino', 'c', 'cpp', 'cuda', 'go', 'javascript', 'ld', 'php'},
  max_lines = 5000,
  timeout = 100,
}

local function search(prefix, pattern)
  local line = fn.search(pattern, 'nw', 0, options.timeout)
  if line == 0 then return '' end
  return string.format('[%s:%d]', prefix, line)
end

local function check_trailing()
  return search('trailing', [[\s$]])
end

local function check_mixed_indent()
  local tst = [[(^\t* +\t\s*\S)]]
  local tls = string.format([[(^\t+ {%d,}\S)]], bo.tabstop)
  local pattern = string.format([[\v%s|%s]], tst, tls)
  return search('mix-indent', pattern)
end

local function check_mixed_indent_file()
  local head_spc = [[\v(^ +)]]
  if vim.tbl_contains(options.c_langs, bo.filetype) then
    head_spc = [[\v(^ +\*@!)]]
  end
  local indent_tabs = fn.search([[\v(^\t+)]], 'nw', 0, options.timeout)
  local indent_spc = fn.search(head_spc, 'nw', 0, options.timeout)
  if indent_tabs == 0 or indent_spc == 0 then return '' end
  return string.format('[mix-indent-file:%d,%d]', indent_spc, indent_tabs)
end

local function check_conflict()
  local annotation = [[\%([0-9A-Za-z_.:]\+\)\?]]
  local raw_pattern = [[^\%%(\%%(<\{7} %s\)\|\%%(=\{7\}\)\|\%%(>\{7\} %s\)\)$]]
  if bo.filetype == 'rst' then
    raw_pattern = [[^\%%(\%%(<\{7} %s\)\|\%%(>\{7\} %s\)\)$]]
  end
  local pattern = string.format(raw_pattern, annotation, annotation)
  return search('conflict', pattern)
end

local function get_item()
  if not enabled then
    cmd 'augroup hardline_whitespace'
    cmd 'autocmd!'
    cmd 'autocmd CursorHold,BufWritePost * unlet! b:hardline_whitespace'
    cmd 'augroup end'
    enabled = true
  end
  if bo.readonly or not bo.modifiable then return '' end
  if fn.line('$') > options.max_lines then return '' end
  if fn.exists('b:hardline_whitespace') ~= 0 then return cache end
  b.hardline_whitespace = 1
  local item = table.concat({
    ' ',
    check_trailing(),
    check_mixed_indent(),
    check_mixed_indent_file(),
    check_conflict(),
    ' ',
  })
  cache = item == '  ' and '' or item
  return cache
end

return {
  get_item = get_item,
}
