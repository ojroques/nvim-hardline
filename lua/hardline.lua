-- nvim-hardline
-- By Olivier Roques
-- github.com/ojroques

-------------------- VARIABLES -----------------------------
local cmd, vim = vim.cmd, vim
local wo = vim.wo
local M = {}

M.events = {
  reload = {
    'BufEnter',
    'BufReadPost',
    'BufWinEnter',
    'BufWritePost',
    'FileChangedShellPost',
    'FileType',
    'VimResized',
    'WinEnter',
  },
  unload = {
    'WinLeave',
  },
}

M.sections = {
  require('hardline.mode'), ' ',
  require('hardline.git'), ' ',
  require('hardline.file'), ' ',
  '%=',
  -- require('hardline.lsp'),
  -- require('hardline.whitespace'),
  require('hardline.filetype'), ' ',
  require('hardline.line'),
}

-------------------- HELPERS -------------------------------
local function echo(hlgroup, msg)
  cmd(string.format('echohl %s', hlgroup))
  cmd(string.format('echo "[hardline] %s"', msg))
  cmd('echohl None')
end

local function load_section(section)
  if not section then return end
  if type(section) == 'function' then
    return section()
  elseif type(section) == 'string' then
    return section
  elseif type(section) == 'table' then
    return load_section(section.get_component)
  end
  echo('WarningMsg', 'Section must be a function or a string!')
  return ''
end

-------------------- INTERFACE -----------------------------
function M.unload()
  wo.statusline = table.concat(vim.tbl_map(load_section, M.sections))
end

function M.reload()
  wo.statusline = table.concat(vim.tbl_map(load_section, M.sections))
end

function M.autocommands()
  cmd 'augroup hardline'
  cmd 'autocmd!'
  for _, event in ipairs(M.events.reload) do
    cmd(string.format('autocmd %s * lua require("hardline").reload()', event))
  end
  for _, event in ipairs(M.events.unload) do
    cmd(string.format('autocmd %s * lua require("hardline").unload()', event))
  end
  cmd 'augroup END'
end

------------------------------------------------------------
return M
