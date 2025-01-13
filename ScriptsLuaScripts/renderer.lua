renderer._instances = {}
renderer._uidinstances = {}
renderer._activemoods = {}
function renderer._viewportDrawFunction(viewport)
  if renderer._instances[viewport] ~= nil then
    for _, instance in pairs(renderer._instances[viewport]) do
      viewport:addInstance(instance.modelContainer, instance.modelIndex, instance.transform)
    end
  end
  if renderer._uidinstances[viewport] ~= nil then
    for _, instance in pairs(renderer._uidinstances[viewport]) do
      viewport:addInstance_uid(instance.uid, instance.transform, instance.rendermethod)
    end
  end
  renderer.showprofile()
end
function renderer.addInstance(viewport, modelContainer, modelIndex, transform)
  renderer._instances[viewport] = renderer._instances[viewport] or {}
  table.insert(renderer._instances[viewport], {
    modelContainer = modelContainer,
    modelIndex = modelIndex,
    transform = transform
  })
  return #renderer._instances[viewport]
end
function renderer.addInstance_uid(viewport, uid, transform, rendermethod)
  renderer._uidinstances[viewport] = renderer._uidinstances[viewport] or {}
  table.insert(renderer._uidinstances[viewport], {
    uid = uid,
    transform = transform,
    rendermethod = rendermethod
  })
  return #renderer._uidinstances[viewport]
end
function renderer.deleteInstance(viewport, instance)
  if renderer._instances[viewport] ~= nil then
    renderer._instances[viewport][instance] = nil
  end
end
function renderer.tooManyStreetLights(modelIndex)
  v = renderer.viewports.main
  for x = 1, 50 do
    for y = 1, 50 do
      t = ModelPreviewer.Camera.matrix
      t[3] = t[3] + (x - 25) * 5 * t[0] - y * 5 * t[2] + vec.vector(0, -1, 0, 0)
      renderer.addInstance(v, 0, modelIndex or 100, t)
    end
  end
end
function renderer.showprofile()
  do return end
  if renderer.performancetable ~= nil then
    perftable = renderer.performancetable
    id = 50
    textscale = 0.5
    xpos = 0.1
    ypos = 0.1
    ystep = 0.03
    paramindent = 0.05
    for k, v in pairs(perftable) do
      perfprofile = v
      message = tostring(k) .. " ="
      Development:add2DText(id, message, vec.vector(xpos, ypos, 0, 1), vec.vector(1, 1, 1, 1), textscale, 1)
      ypos = ypos + ystep
      id = id + 1
      perfprofile["CPUFrameTime%%"] = (perfprofile.FrontEndTime + perfprofile.BackEndTime) / 0.166
      for name, value in pairs(perfprofile) do
        message = name .. " : " .. string.format("%0.2f", value)
        Development:add2DText(id, message, vec.vector(xpos + paramindent, ypos, 0, 1), vec.vector(1, 1, 1, 1), textscale, 1)
        id = id + 1
        ypos = ypos + ystep
      end
    end
  end
end
if helpTopics ~= nil then
  helpTopics[renderer] = "renderer : Renderer Functionality:"
end
