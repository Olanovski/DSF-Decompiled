taskSystem.registerTask("Vehicle prop dropper", {
  {
    name = "eliminatedTargets",
    startingValue = false,
    parseType = "boolean"
  }
}, function(task)
  local rtpropIDs
  for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team == "Race team" then
      rtpropIDs = rtpropIDs or {}
      rtpropIDs[actorID] = PropSystem.CreateRuntimeProps({
        {
          modelUID = "0x2572E201900F1200",
          position = vec.vector(0, 0.9, -1.5, 1),
          attachVehicle = taskObject.coreData.agent.gameVehicle
        },
        {
          modelUID = "0x2572E201900F1200",
          position = vec.vector(0, 0.9, -2.05, 1),
          attachVehicle = taskObject.coreData.agent.gameVehicle
        },
        {
          modelUID = "0x2572E201900F1200",
          position = vec.vector(0, 1.45, -1.8, 1),
          attachVehicle = taskObject.coreData.agent.gameVehicle
        }
      })
    end
  end
  local function goalCallback(success, condition, missionData, goalData)
    for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
      if goalData == taskObject.coreData.agent.gameVehicle then
        for i = 1, #rtpropIDs[actorID] do
          PropSystem.DetachRuntimeProp(rtpropIDs[actorID][i])
        end
      end
    end
    if missionData then
      task.networkVars.eliminatedTargets = true
    end
  end
  return goalCallback, AIUpdate
end)
