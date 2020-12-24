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
  vim.cmd(string.format('echohl %s', hlgroup))
  vim.cmd(string.format('echo "[hardline] %s"', msg))
  vim.cmd('echohl None')
end

function M.is_active()
  return vim.g.statusline_winid == vim.fn.win_getid()
end

return M
