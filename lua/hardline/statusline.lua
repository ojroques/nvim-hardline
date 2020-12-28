local fn, vim = vim.fn, vim
local common = require('hardline.common')

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

local function remove_empty_sections(sections)
  local filter = function(s)
    if type(s) == 'table' then return s.item ~= '' end
    return s ~= ''
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

local function remove_hidden_sections(sections)
  local filter = function(s) return not s.hide or s.hide <= fn.winwidth(0) end
  return vim.tbl_filter(filter, sections)
end

return {
  aggregate_sections = aggregate_sections,
  remove_empty_sections = remove_empty_sections,
  reload_sections = reload_sections,
  remove_hidden_sections = remove_hidden_sections,
}
