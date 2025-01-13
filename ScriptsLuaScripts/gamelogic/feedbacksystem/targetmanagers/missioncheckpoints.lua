feedbackSystem.registerTargetManager("Mission checkpoints", "Goal", function(task, settings)
  local targets = task.instance.targetsToShow
  local missionCheckpointMarkers = {}
  missionCheckpointMarkers.world = {}
  local function update()
    if settings.showOnlyFinal then
      table.insert(missionCheckpointMarkers.world, feedbackSystem.newTarget({
        position = targets[#targets]
      }, settings.style or "Checkpoint Gate"))
    elseif settings.showOnlyFirst then
      table.insert(missionCheckpointMarkers.world, feedbackSystem.newTarget({
        position = targets[1]
      }, settings.style or "Checkpoint Gate"))
    else
      for k, v in next, targets, nil do
        table.insert(missionCheckpointMarkers.world, feedbackSystem.newTarget({position = v}, settings.style or "Checkpoint Gate"))
      end
    end
  end
  local function cleanup()
    for k, v in next, missionCheckpointMarkers.world, nil do
      feedbackSystem.clearTarget(v)
    end
  end
  return update, cleanup
end)
