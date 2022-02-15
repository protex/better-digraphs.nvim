local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

-- https://stackoverflow.com/questions/1426954/split-string-in-lua
local split = function(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

local map = function(list, callback)
  local returnList = {}
  for key, item in pairs(list) do
    table.insert(returnList, callback(item, key))
  end
  return returnList
end

-- https://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua
local file_exists = function(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local match_digraph_table_header = function(line)
  return string.match(line, "official name")
end

local is_empty_string = function(line)
  return line == ""
end

local match_digraph_table_footer = function(line)
  return string.match(line, "vim:tw=78:ts=8:noet:ft=help:norl:")
end

local get_digraph_from_doc = function()
  local digraph_doc = vim.fn.expand("$VIMRUNTIME/doc/digraph.txt")
  if not file_exists(digraph_doc) then return {} end
  local lines = {}
  local line_number = 1
  local table_found = false
  for line in io.lines(digraph_doc) do
    if string.match(line, "digraph%-table%-mbyte") then
      table_found = true
      line_number = 1
      print('table_found')
    elseif table_found
      and not match_digraph_table_header(line)
      and not is_empty_string(line)
      and not match_digraph_table_footer(line) then
        lines[line_number] = line
        line_number = line_number + 1
    end
  end
  return lines
end

local digraph_raw_list = get_digraph_from_doc()
local digraph_list = map(digraph_raw_list, function(line)
  local columns = split(line, "\t")
  return {columns[5], columns[2], columns[1]}
end)

local digraphs = function(mode, opts)
  opts = opts or require("telescope.themes").get_cursor{}
  pickers.new(opts, {
    prompt_title = "Digraphs",
    finder = finders.new_table {
      results = digraph_list,
      entry_maker = function(entry)
        if not entry[1] or not entry[2] or not entry[3] then
          return {}
        end
        return {
          value = entry,
          display = entry[3] .. " " .. entry[2],
          ordinal = entry[1] .. ", " .. entry[2],
        }
      end
    },
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if not mode or not string.match(mode, "[ar]") then
          vim.api.nvim_feedkeys("a" .. selection.value[2], "", false)
        else
          vim.api.nvim_feedkeys(mode .. "" .. selection.value[2], "", false)
        end
      end)
      return true
    end,
    sorter = conf.generic_sorter(opts),
  }):find()
end

return {
  digraphs = digraphs
}
