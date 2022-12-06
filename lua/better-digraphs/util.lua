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

local get_cursor_column = function()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col
end

local map_deprecated_mode_to_new_mode = function(mode, deprecated_map)
  if deprecated_map[mode] then
    vim.api.nvim_err_writeln("Mode " .. mode .. ' is depracated, please use "insert", "normal", and "visual", instead')
    mode = deprecated_map[mode]
  end
  return mode
end

local validate_mode = function(valid_modes, selected_mode)
  assert(valid_modes[selected_mode], selected_mode .. "is not a valid mode")
end

local is_empty_string = function(line)
  return line == ""
end

return {
  split = split,
  map = map,
  file_exists = file_exists,
  get_cursor_column = get_cursor_column,
  map_deprecated_mode_to_new_mode = map_deprecated_mode_to_new_mode,
  validate_mode = validate_mode,
  is_empty_string = is_empty_string
}
