taskSystem.registerTask("SS Checkpoint Rush Speed Clamp", nil, function(task)
  local function goalCallback(success, condition, missionData)
    local taskObject = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
    local p1Score = task.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[1]].namedTasks.checkpoints.networkVars.checkpointsPassed
    local p2Score = task.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[2]].namedTasks.checkpoints.networkVars.checkpointsPassed
    local p1Clamp = 1
    local p2Clamp = 1
    if p1Score > p2Score then
      p1Clamp = 1 - (p1Score - p2Score) * task.instance.challenge.settings.speedClampRate
      if p1Clamp < task.instance.challenge.settings.speedClampMin then
        p1Clamp = task.instance.challenge.settings.speedClampMin
      end
    elseif p1Score < p2Score then
      p2Clamp = 1 - (p2Score - p1Score) * task.instance.challenge.settings.speedClampRate
      if p2Clamp < task.instance.challenge.settings.speedClampMin then
        p2Clamp = task.instance.challenge.settings.speedClampMin
      end
    end
    if task.agent.currentVehicle then
      if task.agent.localID == 0 then
        task.agent.currentVehicle:setEngineTweak(p1Clamp)
      else
        task.agent.currentVehicle:setEngineTweak(p2Clamp)
      end
    end
  end
  return goalCallback
end)
