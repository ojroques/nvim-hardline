-- nvim-hardline
-- By Olivier Roques
-- github.com/ojroques

-------------------- VARIABLES -----------------------------
local api, cmd, fn, vim = vim.api, vim.cmd, vim.fn, vim
local g, o, wo = vim.g, vim.o, vim.wo
local common = require('hardline.common')
local M = {}

-------------------- OPTIONS -------------------------------
M.options = {
  theme = 'default',
  sections = {
    {class = 'mode', item = require('hardline.parts.mode').get_item},
    '%<',
    {class = 'high', item = require('hardline.parts.git').get_item},
    {class = 'med', item = require('hardline.parts.filename').get_item},
    '%=',
    {class = 'low', item = require('hardline.parts.wordcount').get_item},
    {class = 'error', item = require('hardline.parts.lsp').get_error},
    {class = 'warning', item = require('hardline.parts.lsp').get_warning},
    {class = 'warning', item = require('hardline.parts.whitespace').get_item},
    {class = 'high', item = require('hardline.parts.filetype').get_item},
    {class = 'mode', item = require('hardline.parts.line').get_item},
  },
}

-------------------- STATUSLINE ----------------------------
local function get_state(class)
  if class == 'mode' and common.is_active() then
    local mode = common.modes[vim.fn.mode()]
    if not mode then return common.modes['?'].color end
    return mode.color
  end
  return common.is_active() and 'active' or 'inactive'
end

local function color_section(section)
  if type(section) ~= 'table' then return section end
  if not section.class or section.class == 'none' then return section.item end
  local state = get_state(section.class)
  local hlgroup = string.format('Hardline_%s_%s', section.class, state)
  if fn.hlexists(hlgroup) == 0 then return section.item end
  return string.format('%%#%s#%s%%*', hlgroup, section.item)
end

local function update_section(section)
  if type(section) == 'string' then
    return section
  elseif type(section) == 'function' then
    return section()
  elseif type(section) == 'table' then
    return {class = section.class, item = update_section(section.item)}
  end
  common.echo('WarningMsg', 'Invalid section.')
  return ''
end

function M.update()
  local cache
  if common.is_active() then
    cache = vim.tbl_map(update_section, M.options.sections)
    api.nvim_win_set_var(g.statusline_winid, 'hardline_cache', cache)
  else
    cache = api.nvim_win_get_var(g.statusline_winid, 'hardline_cache')
  end
  return table.concat(vim.tbl_map(color_section, cache))
end

-------------------- SETUP -----------------------------
local function set_theme()
  if type(M.options.theme) ~= 'string' then return end
  local theme = string.format('hardline.themes.%s', M.options.theme)
  M.options.theme = require(theme)
end

local function set_hlgroups()
  for class, attr in pairs(M.options.theme) do
    for state, args in pairs(attr) do
      local a = {}
      for k, v in pairs(args) do
        table.insert(a, string.format('%s=%s', k, v))
      end
      a = table.concat(a, ' ')
      cmd(string.format('hi Hardline_%s_%s %s', class, state, a))
    end
  end
end

local function set_statusline()
  o.statusline = [[%!luaeval('require("hardline").update()')]]
  wo.statusline = o.statusline
end

function M.setup(user_options)
  M.options = vim.tbl_extend('force', M.options, user_options)
  set_theme()
  set_hlgroups()
  set_statusline()
end

------------------------------------------------------------
return M
