module("propSystem", package.seeall)
local propGroups = {}
missionPropsActive = false
local lastGroupIndex = ""
local function hideMissedProps(groupName, smashedID)
  local cullID = smashedID - 1
  for k, v in next, propGroups[groupName].props, nil do
    if not v.hidden and v.smash and v.minimap and smashedID > v.id then
      Marker:delete(v.smash)
      Marker:delete(v.minimap)
      v.hidden = true
    end
  end
end
local function deleteProp(groupName, key)
  if propGroups[groupName].props[key] then
    if propGroups[groupName].propsHighlighted then
      if propGroups[groupName].props[key].smash then
        Marker:delete(propGroups[groupName].props[key].smash)
      end
      if propGroups[groupName].props[key].sound > 0 then
        OneShotSound.Stop(propGroups[groupName].props[key].sound)
      end
    end
    if propGroups[groupName].minimapHighlighted or propGroups[groupName].props[key].soloHighlight then
      if propGroups[groupName].hideMissed and propGroups[groupName].props[key].id then
        hideMissedProps(groupName, propGroups[groupName].props[key].id)
      end
      Marker:delete(propGroups[groupName].props[key].minimap)
    end
    propGroups[groupName].availableProps = math.max(propGroups[groupName].availableProps - 1, 0)
    local removed = PropSystem.RemoveWatch(propCallback, propGroups[groupName].propHandles[key])
    table.insert(propGroups[groupName].seenPropHandles, propGroups[groupName].propHandles[key])
    table.remove(propGroups[groupName].props, key)
    table.remove(propGroups[groupName].propHandles, key)
  end
end
local function propCallback(prop, gameVehicle, instance, region, lo, hi, vec)
  for k, v in next, propGroups, nil do
    for k2, v2 in next, v.propHandles, nil do
      if v2 == prop then
        print("delete")
        v.numberSmashed = v.numberSmashed + 1
        deleteProp(k, k2)
      end
    end
  end
end
local function onlinePropCallback(prop, gameVehicle, instance, region, lo, hi, vec)
  for k, v in next, propGroups, nil do
    for k2, v2 in next, v.propHandles, nil do
      if v2 == prop then
        local instance = challengeSystem.instances[phaseManager.networkVars.modeID]
        local isCoopMode = false
        if instance then
          local challengeName = instance.challenge.name
          if phaseManager.playlistSupport.modePool.cooperative[challengeName] then
            isCoopMode = true
          end
        end
        if isCoopMode then
          v.numberSmashed = v.numberSmashed + 1
          deleteProp(k, k2)
        elseif gameVehicle then
          deleteProp(k, k2)
          if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle and gameVehicle.uid == localPlayer.currentVehicle.gameVehicle.uid then
            v.numberSmashed = v.numberSmashed + 1
          end
        end
      end
    end
  end
end
local function watchRuntimeProps(groupName)
  for k, v in next, propGroups[groupName].propHandles, nil do
    if gameStatus.onlineSession then
      PropSystem.AddWatch(onlinePropCallback, v)
    else
      PropSystem.AddWatch(propCallback, v)
    end
  end
end
function removeProp(position, groupName, addSeenIcon)
  local workingVector = vec.vector()
  local closestPosition = math.huge
  local temp = 0
  local key
  lastGroupIndex = groupName or lastGroupIndex
  local pos
  if position then
    pos = position
    propGroups[lastGroupIndex].propSeenCount = propGroups[lastGroupIndex].propSeenCount + 1
  else
    pos = localPlayer.currentVehicle.position
  end
  for k, v in next, propGroups[lastGroupIndex].props, nil do
    temp = workingVector:sub(pos, v.position):length()
    if closestPosition > temp then
      closestPosition = temp
      key = k
    end
  end
  if propGroups[lastGroupIndex].props[key] then
    if addSeenIcon then
      propGroups[groupName].propSeenIcons[propGroups[groupName].propSeenCount] = Marker:create({
        type = "World",
        gadgetID = 113,
        scale = vec.vector(1.7, 1.7, 1.7, 0),
        visible = true,
        facing = true,
        colour = vec.vector(255, 0, 0, 255),
        offset = vec.vector(0, 0, 0, 0),
        position = propGroups[groupName].props[key].position + vec.vector(0, 4, 0, 0)
      })
    end
    deleteProp(lastGroupIndex, key)
  end
end
function removePropFromHandle(propHandle, groupName)
  assert(propGroups[groupName], "Invalid group " .. tostring(groupName) .. " passed to removePropFromHandle!")
  for i, handle in pairs(propGroups[groupName].propHandles) do
    if handle == propHandle then
      print("Deleting prop " .. i)
      deleteProp(groupName, i)
    end
  end
end
function highlightPropGroup(groupName, propsHighlighted, showOnMinimap)
  local heightOffset = vec.vector(0, 4, 0, 0)
  local offset = vec.vector(0, 0, 0, 0)
  local eyeMarkerScale = vec.vector(1.7, 1.7, 1.7, 0)
  local eyeMarkerColour = vec.vector(255, 0, 0, 255)
  local smashMarkerScale = vec.vector(1, 1, 1, 0)
  local smashMarkerColour = vec.vector(255, 255, 255, 255)
  local minimapColour = vec.vector(255, 0, 0, 255)
  for k, v in next, missionProps[groupName], nil do
    if propsHighlighted then
      local smashGadgetID = 75
      local smashVisible = true
      if v.smashGadgetID ~= nil then
        if v.smashGadgetID == -1 then
          smashVisible = false
        else
          smashGadgetID = v.smashGadgetID
        end
        smashColour = vec.vector(255, 255, 255, 255)
      end
      propGroups[groupName].propsHighlighted = true
      propGroups[groupName].props[k].smash = Marker:create({
        type = "World",
        gadgetID = smashGadgetID,
        scale = smashMarkerScale,
        visible = smashVisible,
        facing = true,
        colour = smashMarkerColour,
        offset = offset,
        position = propGroups[groupName].props[k].position + heightOffset
      })
    end
    if showOnMinimap then
      propGroups[groupName].minimapHighlighted = true
      propGroups[groupName].props[k].minimap = Marker:create({
        type = "Minimap",
        gadgetID = 4,
        radius = 7,
        visible = true,
        canrotate = false,
        colour = minimapColour,
        position = propGroups[groupName].props[k].position
      })
    end
    propGroups[groupName].props[k].sound = 0
  end
end
function setupRuntimeProps(groupName, highlightProps, showOnMinimap, hideMissed)
  lastGroupIndex = groupName
  propGroups[groupName] = {}
  propGroups[groupName].propHandles = PropSystem.CreateRuntimeProps(missionProps[groupName])
  propGroups[groupName].props = {}
  propGroups[groupName].seenPropHandles = {}
  propGroups[groupName].propSeenIcons = {}
  propGroups[groupName].numberProps = 0
  propGroups[groupName].numberSmashed = 0
  propGroups[groupName].propSeenCount = 0
  propGroups[groupName].availableProps = 0
  propGroups[groupName].propsHighlighted = false
  propGroups[groupName].minimapHighlighted = false
  if hideMissed then
    propGroups[groupName].hideMissed = true
  end
  watchRuntimeProps(groupName)
  missionPropsActive = true
  propGroups[groupName].numberProps = 0
  local workingVector = vec.vector()
  local position = vec.vector()
  for k, v in next, missionProps[groupName], nil do
    propGroups[groupName].numberProps = propGroups[groupName].numberProps + 1
    propGroups[groupName].props[k] = {}
    propGroups[groupName].props[k].position = vec.vector()
    if v.id then
      propGroups[groupName].props[k].id = v.id
    end
    if hideMissed then
      propGroups[groupName].props[k].hidden = false
    end
    for i = 0, 3 do
      v.matrix:getColumn(i, workingVector)
      propGroups[groupName].props[k].position[i] = workingVector[3]
    end
  end
  if highlightProps or showOnMinimap then
    highlightPropGroup(groupName, highlightProps, showOnMinimap)
  end
  propGroups[groupName].availableProps = propGroups[groupName].numberProps
end
function cleanupRuntimeProps(groupName)
  lastGroupIndex = groupName or lastGroupIndex
  if propGroups[lastGroupIndex] then
    if propGroups[lastGroupIndex].propHandles then
      if propGroups[lastGroupIndex].propsHighlighted then
        for k, v in next, propGroups[lastGroupIndex].props, nil do
          if v.smash then
            Marker:delete(v.smash)
          end
        end
        propGroups[lastGroupIndex].propsHighlighted = false
      end
      if propGroups[lastGroupIndex].minimapHighlighted then
        for k, v in next, propGroups[lastGroupIndex].props, nil do
          Marker:delete(v.minimap)
        end
        propGroups[lastGroupIndex].minimapHighlighted = false
      else
        for k, v in next, propGroups[lastGroupIndex].props, nil do
          if v.soloHighlight then
            Marker:delete(v.minimap)
          end
        end
      end
      missionPropsActive = false
      PropSystem.DeleteRuntimeProps(propGroups[lastGroupIndex].propHandles)
      PropSystem.DeleteRuntimeProps(propGroups[lastGroupIndex].seenPropHandles)
      propGroups[lastGroupIndex].propHandles = nil
      propGroups[lastGroupIndex].props = nil
      propGroups[lastGroupIndex].numberProps = 0
      propGroups[lastGroupIndex].availableProps = 0
      propGroups[lastGroupIndex].propSeenCount = 0
      propGroups[lastGroupIndex].numberSmashed = 0
    end
    for k, v in next, propGroups[lastGroupIndex].propSeenIcons, nil do
      Marker:delete(v)
    end
    propGroups[lastGroupIndex] = nil
  end
end
function minimapHighlightProp(playerPosition, groupName, fixedPosition, checkRadius)
  assert(propGroups[groupName], "Invalid group " .. tostring(groupName) .. " passed to minimapHighlightProp!")
  local offset = -60
  local alterTan = playerPosition[2] * offset
  local positionToCheck = fixedPosition or playerPosition[3] + alterTan
  local groupName = groupName
  local workingVector = vec.vector()
  local distToCheck = checkRadius or 30
  for key, value in next, propGroups[groupName].props, nil do
    if GameVehicleResource.withinRadius(positionToCheck, value.position, distToCheck) and not value.soloHighlight then
      value.minimap = Marker:create({
        type = "Minimap",
        gadgetID = 4,
        radius = 7,
        visible = true,
        canrotate = false,
        colour = vec.vector(255, 0, 0, 255),
        position = value.position
      })
      value.soloHighlight = true
    end
  end
end
function getProps(groupName)
  lastGroupIndex = groupName or lastGroupIndex
  return propGroups[lastGroupIndex] and {}
end
function getNumberRemainingProps(groupName)
  lastGroupIndex = groupName or lastGroupIndex
  return propGroups[lastGroupIndex] and 0
end
function getInitialPropCount(groupName)
  lastGroupIndex = groupName or lastGroupIndex
  return propGroups[lastGroupIndex] and 0
end
function getPropsSeenCount(groupName)
  lastGroupIndex = groupName or lastGroupIndex
  return propGroups[lastGroupIndex] and 0
end
function getNumberSmashed(groupName)
  lastGroupIndex = groupName or lastGroupIndex
  return propGroups[lastGroupIndex] and 0
end
function getPropHandles(groupName)
  return propGroups[groupName].propHandles
end
function getAccumulativeNumberSmashed()
  local count = 0
  for k, v in next, propGroups, nil do
    count = count + (v.numberSmashed or 0)
  end
  return count
end
function getAccumulativePropsSeenCount()
  local count = 0
  for k, v in next, propGroups, nil do
    count = count + (v.propSeenCount or 0)
  end
  return count
end
function getAccumulativeNumberRemainingProps()
  local count = 0
  for k, v in next, propGroups, nil do
    count = count + (v.availableProps or 0)
  end
  return count
end
function getAccumulativeTotalOfInitialProps()
  local count = 0
  for k, v in next, propGroups, nil do
    count = count + (v.numberProps or 0)
  end
  return count
end
function disablePropType(...)
  arg.n = nil
  for i, key in ipairs(arg) do
    arg[i] = propType[key]
  end
  printTable(arg)
  PropSystem.DisablePropTypes(arg)
end
function reenableAllPropTypes()
  PropSystem.ClearDisablePropTypes()
end
