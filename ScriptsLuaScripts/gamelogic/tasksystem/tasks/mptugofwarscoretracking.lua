taskSystem.registerTask("MP tug of war score tracking", {
  {
    name = "blueTeam",
    startingValue = 0,
    parseType = "uinteger8"
  },
  {
    name = "redTeam",
    startingValue = 0,
    parseType = "uinteger8"
  }
}, function(task)
  local function goalCallback(success, condition, loop, returnData)
    if success then
      if returnData == "blueTeam" then
        task.networkVars.blueTeam = task.networkVars.blueTeam + 1
      else
        task.networkVars.redTeam = task.networkVars.redTeam + 1
      end
      local flagTaskObject = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
      local flag = flagTaskObject.coreData.agent
      if flag and task.agent.isLocal and task.instance.playerScores then
        task.instance.playerScores[flag.playerID + 1] = task.instance.playerScores[flag.playerID + 1] + 1
      end
    else
      task.agent:packageDropped(false, true)
    end
  end
  return goalCallback
end)
