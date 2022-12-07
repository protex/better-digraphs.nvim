Betterdigraphs = {}
Betterdigraphs.mt = {}
setmetatable(Betterdigraphs, Betterdigraphs.mt)

Betterdigraphs.mt.__index = function()
  error('importing from betterdigraphs no longer supported, please use "require(\'better-digraphs\')" instead')
end

return Betterdigraphs
