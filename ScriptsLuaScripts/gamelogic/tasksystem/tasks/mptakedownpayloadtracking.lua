taskSystem.registerTask("MP Takedown Payload Tracking", {
  {
    name = "payload",
    startingValue = 0,
    parseType = "integer32"
  },
  {
    name = "playerScore",
    startingValue = 0,
    parseType = "integer32"
  },
  {
    name = "playerDropoffs",
    startingValue = 0,
    parseType = "uinteger16"
  },
  {
    name = "playerBonusScore",
    startingValue = 0,
    parseType = "uinteger16"
  }
}, function(task)
  local bitOffset = 8
  local timeBonusLimit = 45
  local targetTime = g_NetworkTime + timeBonusLimit
  local dropOffScores = {
    [0] = 0,
    [1] = 10,
    [2] = 25,
    [3] = 50,
    [4] = 100
  }
  local messageStartTime = false
  local function goalCallback(success, condition, missionData, points)
    if success then
      if task.takedownStartScore == nil then
        task.takedownStartScore = task.networkVars.playerScore
      end
      if condition == 1 then
        task.networkVars.playerDropoffs = task.networkVars.playerDropoffs + 1
        if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public then
          local value = ProfileSettings.GetNumTakedownDropOffsReached() + 1
          OnlineAchievements.onValueChange("Takedown", value)
          ProfileSettings.SetNumTakedownDropOffsReached(value)
        end
        if g_NetworkTime < targetTime then
          task.networkVars.playerBonusScore = task.networkVars.playerBonusScore + math.floor((targetTime - g_NetworkTime) / 3)
          targetTime = g_NetworkTime + timeBonusLimit
        end
        if task.networkVars.playerDropoffs < 4 then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:243148", tostring(task.networkVars.playerDropoffs))
          messageStartTime = g_NetworkTime
          addUserUpdateFunction("nextDropOffValueMsg", function()
            if g_NetworkTime - messageStartTime > 2.5 then
              feedbackSystem.menusMaster.primaryTextPrompt("ID:243288", tostring(dropOffScores[task.networkVars.playerDropoffs + 1] - dropOffScores[task.networkVars.playerDropoffs]))
              removeUserUpdateFunction("nextDropOffValueMsg")
            end
          end, 1)
        end
        task.networkVars.playerScore = task.networkVars.playerBonusScore + dropOffScores[task.networkVars.playerDropoffs]
        task.networkVars.payload = task.networkVars.playerDropoffs + task.networkVars.playerBonusScore * bitOffset
      elseif condition == 2 then
        task.networkVars.playerBonusScore = task.networkVars.playerBonusScore + 1
        task.networkVars.playerScore = task.networkVars.playerScore + 1
        task.networkVars.payload = task.networkVars.payload + 1 * bitOffset
      else
        task.networkVars.playerBonusScore = task.networkVars.playerBonusScore + points
        task.networkVars.playerScore = task.networkVars.playerScore + points
        task.networkVars.payload = task.networkVars.payload + points * bitOffset
      end
    else
      task.networkVars.playerBonusScore = math.floor(task.networkVars.payload / bitOffset)
      task.networkVars.playerDropoffs = task.networkVars.payload - task.networkVars.playerBonusScore * bitOffset
      task.networkVars.playerScore = task.networkVars.playerBonusScore + dropOffScores[task.networkVars.playerDropoffs]
      task.takedownStartScore = task.networkVars.playerScore
    end
  end
  local cleanup = function()
    removeUserUpdateFunction("nextDropOffValueMsg")
  end
  return goalCallback, AIUpdate, cleanup
end)
