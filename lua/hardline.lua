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
    {class = 'high', item = require('hardline.parts.git').get_item, hide = 80},
    '%<',
    {class = 'med', item = require('hardline.parts.filename').get_item},
    '%=',
    {class = 'low', item = require('hardline.parts.wordcount').get_item, hide = 80},
    {class = 'error', item = require('hardline.parts.lsp').get_error},
    {class = 'warning', item = require('hardline.parts.lsp').get_warning},
    {class = 'warning', item = require('hardline.parts.whitespace').get_item},
    {class = 'high', item = require('hardline.parts.filetype').get_item, hide = 80},
    {class = 'mode', item = require('hardline.parts.line').get_item},
  },
}

-------------------- STATUSLINE ----------------------------
local function color_sections(sections)
  local function map(section)
    if type(section) ~= 'table' then return section end
    if section.class == 'none' then return section.item end
    local state = common.get_state(section.class)
    local hlgroup = string.format('Hardline_%s_%s', section.class, state)
    if fn.hlexists(hlgroup) == 0 then return section.item end
    return string.format('%%#%s#%s%%*', hlgroup, section.item)
  end
  return vim.tbl_map(map, sections)
end

local function aggregate_sections(sections)
  local aggregated, piv = {}, 1
  while piv <= #sections do
    if type(sections[piv]) == 'table' then
      local items = {}
      for j = piv, #sections + 1 do
        if j == #sections + 1 or sections[j].class ~= sections[piv].class then
          table.insert(aggregated, {
            class = sections[piv].class,
            item = string.format(' %s ', table.concat(items, ' '))
          })
          piv = j
          break
        end
        table.insert(items, sections[j].item)
      end
    else
      table.insert(aggregated, sections[piv])
      piv = piv + 1
    end
  end
  return aggregated
end

local function filter_sections(sections)
  local function filter(section)
    if type(section) == 'table' then
      return section.hide <= fn.winwidth(0) and section.item ~= ''
    end
    return section ~= ''
  end
  return vim.tbl_filter(filter, sections)
end

local function reload_sections(sections)
  local function map(section)
    if type(section) == 'string' then
      return section
    elseif type(section) == 'function' then
      return section()
    elseif type(section) == 'table' then
      return {
        class = section.class or 'none',
        item = map(section.item),
        hide = section.hide or 0,
      }
    end
    common.echo('WarningMsg', 'Invalid section.')
    return ''
  end
  return vim.tbl_map(map, sections)
end

function M.update()
  local cache = M.options.sections
  if common.is_active() then
    cache = reload_sections(cache)
    cache = filter_sections(cache)
    cache = aggregate_sections(cache)
    api.nvim_win_set_var(g.statusline_winid, 'hardline_cache', cache)
  else
    cache = api.nvim_win_get_var(g.statusline_winid, 'hardline_cache')
  end
  return table.concat(color_sections(cache))
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
