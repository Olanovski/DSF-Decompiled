module("cardSystem", package.seeall)
taskCompleteData = taskCompleteData or {}
taskCompleteData["Generic scoring"] = {}
taskCompleteData["Generic scoring"].taskComplete = function(taskObject, task)
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local veh
  for k, v in next, task.instance.taskObjectsByActorID, nil do
    veh = v.coreData.agent
    break
  end
  local params = {
    vehicle = veh,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    inCarCompletion = task.instance.challenge.taskCompleteData["In-car completion"],
    inCarReward = task.instance.challenge.taskCompleteData["In-car reward"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    passReward = task.instance.challenge.taskCompleteData["Pass reward"]
  }
  if minimap.GetHighlightedVehicles() then
    minimap.SetHighlightedVehicles(false)
  end
  if task.success and taskObject.playerTask then
    params.completeReason = task.instance.challenge.taskCompleteData["Complete reason"] or task.instance.challenge.taskCompleteData.Success or "MISSION COMPLETE"
    params.callback = completeTask
    if params.vehicle.damage == 0 then
      params.rating = "PASS"
    else
      params.rating = "PASS"
    end
  else
    if params.vehicle.damage >= 1 then
      params.failReason = "YOUR VEHICLE IS WRECKED"
    end
    params.callback = failTask
    params.rating = "FAIL"
  end
  localPlayer.challenge.endScreen(taskObject, params)
end
