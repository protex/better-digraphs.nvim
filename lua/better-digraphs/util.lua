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

return {
  split = split,
  map = map,
  file_exists = file_exists,
  get_cursor_column = get_cursor_column
}
