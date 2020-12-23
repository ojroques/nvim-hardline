-- nvim-hardline
-- By Olivier Roques
-- github.com/ojroques

-------------------- VARIABLES -----------------------------
local api, cmd, vim = vim.api, vim.cmd, vim
local wo = vim.wo
local common = require('hardline.common')
local M = {}

-------------------- OPTIONS -------------------------------
M.theme = 'default'
M.events = {
  active = {
    'BufEnter',
    'BufReadPost',
    'BufWinEnter',
    'BufWritePost',
    'FileChangedShellPost',
    'FileType',
    'VimResized',
    'WinEnter',
  },
  inactive = {
    'WinLeave',
  },
}
M.sections = {
  {
    class = nil,
    item = require('hardline.parts.mode').get_item()
  }, ' ',
  {
    class = 'B',
    item = require('hardline.parts.git').get_item()
  }, ' ',
  {
    class = 'C',
    item = require('hardline.parts.filename').get_item()
  }, ' ',
  '%=',
  -- {
  --   class = 'Error',
  --   item = require('hardline.parts.lsp').get_errors()
  -- }, ' ',
  -- {
  --   class = 'Warning',
  --   item = require('hardline.parts.lsp').get_warnings()
  -- }, ' ',
  -- {
  --   class = 'Warning',
  --   item = require('hardline.parts.whitespace').get_item()
  -- }, ' ',
  -- {
  --   class = 'X',
  --   item = require('hardline.parts.wordcount').get_item()
  -- }, ' ',
  {
    class = 'Y',
    item = require('hardline.parts.filetype').get_item()
  }, ' ',
  {
    class = 'A',
    item = require('hardline.parts.line').get_item()
  },
}

-------------------- STATUSLINE ----------------------------
local function color_item(item, class)
  local mode = common.is_active() and 'active' or 'inactive'
  if not class or not common.theme.colors[class] then return item end
  return string.format('%%#Hardline%s%s#%s%%##', class, mode, item)
end

local function reload_section(section)
  if type(section) == 'function' then
    return section()
  elseif type(section) == 'string' then
    return section
  elseif type(section) == 'table' then
    return color_item(reload_section(section.item), section.class)
  end
  common.echo('WarningMsg', 'Invalid section.')
  return ''
end

function M.reload(active)
  common.set_active(active)
  wo.statusline = table.concat(vim.tbl_map(reload_section, M.sections))
end

-------------------- SETUP -----------------------------

local function set_hlgroups()
  for class, attr in pairs(common.theme.colors) do
    for mode, args in pairs(attr) do
      local a = common.build_args(args)
      cmd(string.format('hi Hardline%s%s %s', class, mode, a))
    end
  end
  for mode, args in pairs(common.theme.mode_colors) do
    local a = common.build_args(args)
    cmd(string.format('hi HardlineMode%s %s', mode, a))
  end
end

local function set_autocmds()
  cmd 'augroup hardline'
  cmd 'autocmd!'
  for mode, events in pairs(M.events) do
    for _, event in ipairs(events) do
      local raw_str = 'autocmd %s * lua require("hardline").reload(%s)'
      cmd(string.format(raw_str, event, mode == 'active'))
    end
  end
  cmd 'augroup END'
end

function M.setup(user_opts)
  common.theme = require(string.format('hardline.themes.%s', M.theme))
  set_hlgroups()
  set_autocmds()
end

------------------------------------------------------------
return M
