function renderer.debugOptions.list()
  c = renderer.debugOptions.getNum()
  for i = 0, c - 1 do
    n = renderer.debugOptions.getName(i)
    min = renderer.debugOptions.getMin(i)
    max = renderer.debugOptions.getMax(i)
    val = renderer.debugOptions.getValue(i)
    u = string.find(n, "unused")
    if u == nil or u > 2 then
      print(i .. " = " .. n .. " (min=" .. min .. ", max=" .. max .. ", cur=" .. val .. ")")
    end
  end
end
function renderer.debugOptions.listDefaults()
  c = renderer.debugOptions.getNum()
  for i = 0, c - 1 do
    n = renderer.debugOptions.getName(i)
    u = string.find(n, "unused")
    if u == nil or u > 2 then
      print(i .. ":" .. n .. " (default=" .. renderer.debugOptions.defaults[i] .. ")")
    end
  end
end
function renderer.debugOptions.setAllToDefault()
  c = renderer.debugOptions.getNum()
  for i = 0, c - 1 do
    renderer.debugOptions.setValue(i, renderer.debugOptions.defaults[i])
  end
end
