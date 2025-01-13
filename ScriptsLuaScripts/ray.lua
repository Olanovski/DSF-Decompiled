epsilon = 0.01
maxRecursion = 10
w = 128
h = 128
mx = 1
my = 1
_black = vec.vector(0, 0, 0, 1)
_white = vec.vector(1, 1, 1, 1)
_red = vec.vector(1, 0.5, 0.5, 1)
_green = vec.vector(0.5, 1, 0.5, 1)
_blue = vec.vector(0.5, 0.5, 1, 1)
_yellow = vec.vector(1, 1, 0.5, 1)
_fs = {
  x = 0,
  y = 0,
  w = 1,
  XScale = 1,
  YScale = 1,
  colour = {
    r = 1,
    g = 1,
    b = 1
  }
}
function setPixel(viewport, x, y, colour)
  viewport:addSprite(-1, -1, 0.5 + x / (3 * w), y / (2 * h), 1 / (3 * w), 1 / (2 * h), 0, 0, 1, 1, colour)
end
function intersectPlane(origin, direction, object)
  local vd = direction:dot(object.normal)
  if vd == 0 then
    return -1
  else
    return -(object.normal:dot(origin) + object.d) / vd
  end
end
function intersectSphere(origin, direction, object)
  local a = direction:dot(direction)
  local c = origin - object.centre
  local b = 2 * direction:dot(c)
  c = c:dot(c) - object.radius * object.radius
  local d = b * b - 4 * a * c
  if d < 0 then
    return -1
  else
    local t1 = (-b + math.sqrt(d)) / (2 * a)
    local t2 = (-b - math.sqrt(d)) / (2 * a)
    if t1 > t2 then
      t1, t2 = t2, t1
    end
    if t1 < 0 then
      return t2
    else
      return t1
    end
  end
end
function intersect(origin, direction, object)
  if object.type == "plane" then
    return intersectPlane(origin, direction, object)
  elseif object.type == "sphere" then
    return intersectSphere(origin, direction, object)
  else
    return -1
  end
end
function normal(intersection, object)
  if object.type == "plane" then
    return object.normal
  elseif object.type == "sphere" then
    return intersection - object.centre:normalise()
  end
end
function reflect(intersection, direction, object)
  local n = normal(intersection, object)
  local d = direction:dot(n)
  return direction - n * 2 * d
end
function refract(intersection, direction, object)
  local n = normal(intersection, object)
  local i = -direction
  local index = object.index
  if n:dot(direction) > 0 then
    index = 1 / index
    n = -n
  end
  local ni = n:dot(i)
  local d = 1 - index * index * (1 - ni * ni)
  if d < 0 then
    d = direction:dot(n)
    return direction - n * 2 * d
  end
  local nscale = index * ni - math.sqrt(d)
  local result = n * nscale - i * index
  return result
end
function trace(origin, direction, world, depth)
  depth = depth or 0
  if depth > maxRecursion then
    return _black
  end
  local closestObject
  local closestDistance = 1 / 0
  for _, object in pairs(world) do
    local d = intersect(origin, direction, object)
    if d > epsilon and closestDistance > d then
      closestObject = object
      closestDistance = d
    end
  end
  if closestObject ~= nil then
    local intersection = origin + direction * closestDistance
    if 0 < closestObject.reflect then
      local reflectedDirection = reflect(intersection, direction, closestObject)
      local reflectedColour = trace(intersection, reflectedDirection, world, depth + 1)
      return closestObject:colour(intersection) * (1 - closestObject.reflect) + reflectedColour * closestObject.reflect
    elseif 0 < closestObject.refract then
      local refractedDirection = refract(intersection, direction, closestObject)
      local refractedColour = trace(intersection, refractedDirection, world, depth + 1)
      return closestObject:colour(intersection) * (1 - closestObject.refract) + refractedColour * closestObject.refract
    else
      return closestObject:colour(intersection)
    end
  else
    return _black
  end
end
function red(object, intersection)
  return _red
end
function green(object, intersection)
  return _green
end
function blue(object, intersection)
  return _blue
end
function yellow(object, intersection)
  return _yellow
end
function checker(object, intersection)
  local x = intersection - origin
  local s = math.floor(0.3 * x:dot(object.u))
  local t = math.floor(0.3 * x:dot(object.v))
  local y = s + t
  if y / 2 == math.floor(y / 2) then
    return _red
  else
    return _yellow
  end
end
function ray(viewport)
  local world = {
    {
      type = "plane",
      normal = vec.vector(0, 1, 0, 0),
      d = 4,
      u = vec.vector(1, 0, 0, 0),
      v = vec.vector(0, 0, 1, 0),
      origin = vec.vector(0, 0, 0, 0),
      colour = checker,
      reflect = 0.2
    },
    {
      type = "sphere",
      centre = vec.vector(-2, 2, 30, 0),
      radius = 3,
      colour = blue,
      reflect = 0.2
    },
    {
      type = "sphere",
      centre = vec.vector(2.2, -1, 16, 0),
      radius = 2,
      colour = blue,
      reflect = 0.8,
      refract = 0
    },
    {
      type = "sphere",
      centre = vec.vector(-2.2, -1, 16, 0),
      radius = 2,
      colour = green,
      reflect = 0,
      refract = 0.8,
      index = 1.2
    }
  }
  origin = vec.vector(0, 0, 0, 0)
  for x = 0, w - 1 do
    for y = 0, h - 1 do
      local colour = vec.vector(0, 0, 0, 0)
      for dx = 0, 1 - 1 / mx, 1 / mx do
        for dy = 0, 1 - 1 / my, 1 / my do
          local direction = vec.vector((2 * (x + dx) - w) / w, -(2 * (y + dy) - h) / h, 3, 0)
          direction = direction:normalise()
          colour = colour + trace(origin, direction, world)
        end
      end
      setPixel(viewport, x, y, colour / (mx * my))
    end
  end
end
