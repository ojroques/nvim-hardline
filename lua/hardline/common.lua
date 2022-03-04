local fmt = string.format
local M = {}

M.modes = {
  [''] = {text = 'S-BLOCK', state = 'visual'},
  [''] = {text = 'V-BLOCK', state = 'visual'},
  ['?'] = {text = '???', state = 'inactive'},
  ['R'] = {text = 'REPLACE', state = 'replace'},
  ['S'] = {text = 'S-LINE', state = 'visual'},
  ['V'] = {text = 'V-LINE', state = 'visual'},
  ['c'] = {text = 'COMMAND', state = 'command'},
  ['i'] = {text = 'INSERT', state = 'insert'},
  ['n'] = {text = 'NORMAL', state = 'normal'},
  ['r'] = {text = 'PROMPT', state = 'replace'},
  ['s'] = {text = 'SELECT', state = 'visual'},
  ['t'] = {text = 'TERMINAL', state = 'command'},
  ['v'] = {text = 'VISUAL', state = 'visual'},
}

function M.echo(msg, hlgroup)
  vim.api.nvim_echo({{fmt('[hardline] %s', msg), hlgroup}}, false, {})
end

function M.set_cache_autocmds(augroup)
  vim.cmd(fmt([[
  augroup %s
    autocmd!
    autocmd CursorHold,BufWritePost * unlet! b:%s
  augroup END
  ]], augroup, augroup))
end

return M
