local drawTarget = function(settings, styleIDs, dynamicTargetID, target, task)
  local styles = settings.styles
  styleIDs[dynamicTargetID] = {}
  if dynamicTargetID == 1 then
    localPlayer.minimapSupport:setPointofInterest(target.position)
  end
  for style, styleParams in next, styles, nil do
    table.insert(styleIDs[dynamicTargetID], feedbackSystem.newTarget(target, style, styleParams, task))
  end
end
local clearTarget = function(styleIDs, styleID)
  for i, drawListID in ipairs(styleIDs[styleID]) do
    feedbackSystem.clearTarget(drawListID)
  end
  table.remove(styleIDs, styleID)
end
feedbackSystem.registerTargetManager("Target list", "Goal", function(task, settings)
  local targetList = task.targetList
  local styleIDs = {}
  local function update(targetsToRemove)
    if targetsToRemove then
      for i, dynamicTargetID in ripairs(targetsToRemove) do
        clearTarget(styleIDs, dynamicTargetID)
      end
    end
    if task.dynamicTargets then
      for dynamicTargetID, target in ipairs(task.dynamicTargets) do
        if not styleIDs[dynamicTargetID] then
          drawTarget(settings, styleIDs, dynamicTargetID, target, task)
        end
      end
    end
  end
  local function cleanup()
    for styleID, drawListData in ripairs(styleIDs) do
      clearTarget(styleIDs, styleID)
    end
  end
  return update, cleanup
end)
