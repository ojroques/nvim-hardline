-- nvim-hardline
-- By Olivier Roques
-- github.com/ojroques

-------------------- VARIABLES -----------------------------
local api, cmd, fn, vim = vim.api, vim.cmd, vim.fn, vim
local g, o, wo = vim.g, vim.o, vim.wo
local common = require('hardline.common')
local statusline = require('hardline.statusline')
local bufferline = require('hardline.bufferline')
local M = {}

-------------------- OPTIONS -------------------------------
M.options = {
  bufferline = false,
  theme = 'default',
  sections = {
    {class = 'mode', item = require('hardline.parts.mode').get_item},
    {class = 'high', item = require('hardline.parts.git').get_item, hide = 80},
    '%<',
    {class = 'med', item = require('hardline.parts.filename').get_item},
    {class = 'med', item ='%='},
    {class = 'low', item = require('hardline.parts.wordcount').get_item, hide = 80},
    {class = 'error', item = require('hardline.parts.lsp').get_error},
    {class = 'warning', item = require('hardline.parts.lsp').get_warning},
    {class = 'warning', item = require('hardline.parts.whitespace').get_item},
    {class = 'high', item = require('hardline.parts.filetype').get_item, hide = 80},
    {class = 'mode', item = require('hardline.parts.line').get_item},
  },
}

-------------------- STATUSLINE ----------------------------
function M.update_statusline()
  local cache = M.options.sections
  if common.is_active() then
    cache = statusline.reload_sections(cache)
    cache = statusline.filter_sections(cache)
    cache = statusline.aggregate_sections(cache)
    api.nvim_win_set_var(g.statusline_winid, 'hardline_cache', cache)
  else
    cache = api.nvim_win_get_var(g.statusline_winid, 'hardline_cache')
  end
  return table.concat(vim.tbl_map(common.color, cache))
end

-------------------- BUFFERLINE ----------------------------
function M.update_bufferline()
  local sections = {}
  local buffers = bufferline.get_buffers()
  for _, buffer in ipairs(buffers) do
    table.insert(sections, bufferline.to_section(buffer))
    table.insert(sections, {class = 'bufferline', item = '|', conceal = true})
  end
  table.remove(sections)
  return table.concat(vim.tbl_map(common.color, sections))
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
  o.statusline = [[%!luaeval('require("hardline").update_statusline()')]]
  wo.statusline = o.statusline
end

local function set_bufferline()
  o.showtabline = 2
  o.tabline = [[%!luaeval('require("hardline").update_bufferline()')]]
end

function M.setup(user_options)
  M.options = vim.tbl_extend('force', M.options, user_options)
  set_theme()
  set_hlgroups()
  set_statusline()
  if M.options.bufferline then set_bufferline() end
end

------------------------------------------------------------
return M
