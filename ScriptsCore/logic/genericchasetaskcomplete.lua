module("cardSystem", package.seeall)
taskCompleteData = taskCompleteData or {}
taskCompleteData["Generic chase"] = {}
taskCompleteData["Generic chase"].taskComplete = function(taskObject, task)
  local params = {
    vehicle = localPlayer.currentVehicle,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    successReasonPerfect = task.instance.challenge.taskCompleteData["Success reason (perfect)"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    inCarCompletion = task.instance.challenge.taskCompleteData["In-car completion"],
    inCarReward = task.instance.challenge.taskCompleteData["In-car reward"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    passReward = task.instance.challenge.taskCompleteData["Pass reward"],
    perfectCondition = task.instance.challenge.taskCompleteData["Perfect condition"],
    perfectReward = task.instance.challenge.taskCompleteData["Perfect reward"]
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local playerTeam
  for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
    if taskObject.playerTask then
      playerTeam = taskObject.coreData.actor.team
    end
  end
  if task.instance.taskObjectsByActorID["Evade team member 1"] then
    params.vehicle = task.instance.taskObjectsByActorID["Evade team member 1"].coreData.agent
  elseif task.instance.taskObjectsByActorID["Race team member 1"] then
    local distance = 9999
    for i, v in next, task.instance.taskObjectsByActorID, nil do
      if v.coreData.actor.team == "Race team" then
        local distanceFromPlayer = v.coreData.agent.position - localPlayer.position:length()
        if distance > distanceFromPlayer then
          distance = distanceFromPlayer
          params.vehicle = v.coreData.agent
        end
      end
    end
  end
  if playerTeam == "Chase team" then
    if taskObject.coreData.actor.team == "Chase team" then
      params.successReason = task.instance.challenge.taskCompleteData["Chaser success"] or params.successReason or "THE GETAWAY'S VEHICLE IS WRECKED"
      params.callback = completeTask
      params.rating = "PASS"
    else
      params.failReason = task.instance.challenge.taskCompleteData["Chaser failure"] or params.failReason or "THE GETAWAY ESCAPED THE COPS"
      params.callback = failTask
      params.rating = "FAIL"
    end
  elseif taskObject.coreData.actor.team == "Evade team" or taskObject.coreData.actor.team == "Race team" then
    if task.success then
      params.successReason = task.instance.challenge.taskCompleteData["Evader success"] or params.successReason or "YOU ESCAPED THE COPS"
      params.callback = completeTask
      params.rating = "PASS"
    else
      if params.vehicle.damage >= 1 then
        params.failReason = "YOUR VEHICLE IS WRECKED"
      else
        params.failReason = params.failReason or task.instance.challenge.taskCompleteData["Evader failure"]
      end
      params.callback = failTask
      params.rating = "FAIL"
    end
  else
    if params.vehicle.damage >= 1 then
      params.failReason = "YOUR VEHICLE IS WRECKED"
    else
      params.failReason = params.failReason or task.instance.challenge.taskCompleteData["Evader failure"]
    end
    params.callback = failTask
    params.rating = "FAIL"
  end
  if task.instance.challenge.goalValues["Within radius (+ score)"] then
    if task.success then
      params.successReason = task.instance.challenge.taskCompleteData["Chaser success"] or params.successReason or "You win"
      params.callback = completeTask
      params.rating = "PASS"
    else
      params.failReason = task.instance.challenge.taskCompleteData["Chaser failure"] or params.failReason or "You lose"
      params.callback = failTask
      params.rating = "FAIL"
    end
  end
  localPlayer.challenge.endScreen(taskObject, params)
end
