local cmd, fn, vim = vim.cmd, vim.fn, vim
local g = vim.g
local M = {}

M.modes = {
  ['?'] = {text = '???', state = 'inactive'},
  ['n'] = {text = 'NORMAL', state = 'normal'},
  ['i'] = {text = 'INSERT', state = 'insert'},
  ['R'] = {text = 'REPLACE', state = 'replace'},
  ['v'] = {text = 'VISUAL', state = 'visual'},
  ['V'] = {text = 'V-LINE', state = 'visual'},
  [''] = {text = 'V-BLOCK', state = 'visual'},
  ['c'] = {text = 'COMMAND', state = 'normal'},
  ['s'] = {text = 'SELECT', state = 'visual'},
  ['S'] = {text = 'S-LINE', state = 'visual'},
  [''] = {text = 'S-BLOCK', state = 'visual'},
  ['t'] = {text = 'TERMINAL', state = 'normal'},
}

function M.echo(hlgroup, msg)
  cmd(string.format('echohl %s', hlgroup))
  cmd(string.format('echo "[hardline] %s"', msg))
  cmd('echohl None')
end

function M.is_active()
  return g.statusline_winid == fn.win_getid()
end

function M.get_state(class)
  if class == 'mode' and M.is_active() then
    local mode = M.modes[fn.mode()] or M.modes['?']
    return mode.state
  end
  return M.is_active() and 'active' or 'inactive'
end

function M.set_cache(augroup)
  cmd(string.format('augroup %s', augroup))
  cmd('autocmd!')
  cmd(string.format('autocmd CursorHold,BufWritePost * unlet! b:%s', augroup))
  cmd('augroup END')
end

return M
