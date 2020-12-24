local M = {}

local modes = {
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

function M.echo(hlgroup, msg)
  vim.cmd(string.format('echohl %s', hlgroup))
  vim.cmd(string.format('echo "[hardline] %s"', msg))
  vim.cmd('echohl None')
end

function M.set_active(active)
  vim.api.nvim_win_set_var(0, 'hardline_active', active)
end

function M.get_active()
  return vim.api.nvim_win_get_var(0, 'hardline_active')
end

function M.is_active()
  return M.get_active() == 'active'
end

function M.get_mode()
  if not modes[vim.fn.mode()] then return modes['?'] end
  return modes[vim.fn.mode()]
end

return M
