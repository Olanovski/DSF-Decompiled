feedbackSystem.registerTargetManager("Self", "Zap", function(task, settings)
  local target = task.agent
  local alwaysOn = settings.alwaysOn
  local styleIDs = {}
  local function drawTarget()
    for style, styleParams in next, settings.styles, nil do
      table.insert(styleIDs, feedbackSystem.newTarget(target, style, styleParams))
    end
  end
  local function clearTarget()
    for i, drawListID in ipairs(styleIDs) do
      feedbackSystem.clearTarget(drawListID)
    end
    styleIDs = {}
  end
  local function update()
    if alwaysOn then
      if #styleIDs == 0 then
        drawTarget()
      end
    elseif not target.controlled and #styleIDs == 0 then
      drawTarget()
    elseif target.controlled and #styleIDs > 0 then
      clearTarget()
    end
  end
  local function cleanup()
    if #styleIDs > 0 then
      clearTarget()
    end
  end
  return update, cleanup
end)
