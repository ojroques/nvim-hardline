local cmd, fn, vim = vim.cmd, vim.fn, vim
local g = vim.g
local M = {
  modes = {
    ['?'] = {text = '???', color = 'inactive'},
    ['n'] = {text = 'NORMAL', color = 'normal'},
    ['c'] = {text = 'COMMAND', color = 'normal'},
    ['i'] = {text = 'INSERT', color = 'insert'},
    ['R'] = {text = 'REPLACE', color = 'replace'},
    ['v'] = {text = 'VISUAL', color = 'visual'},
    ['V'] = {text = 'V-LINE', color = 'visual'},
    [''] = {text = 'V-BLOCK', color = 'visual'},
    ['s'] = {text = 'SELECT', color = 'visual'},
    ['S'] = {text = 'S-LINE', color = 'visual'},
    [''] = {text = 'S-BLOCK', color = 'visual'},
    ['t'] = {text = 'TERMINAL', color = 'normal'},
  }
}

function M.echo(hlgroup, msg)
  cmd(string.format('echohl %s', hlgroup))
  cmd(string.format('echo "[hardline] %s"', msg))
  cmd('echohl None')
end

function M.is_active()
  return g.statusline_winid == fn.win_getid()
end

return M
