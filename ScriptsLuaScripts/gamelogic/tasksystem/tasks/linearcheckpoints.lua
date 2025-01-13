taskSystem.registerTask("Linear Checkpoints", {
  {
    name = "checkpoints",
    startingValue = 1,
    parseType = "integer32",
    dynamicTargetTrigger = true
  },
  {
    name = "laps",
    startingValue = 0,
    parseType = "integer32"
  }
}, function(task)
  local goalCallback, AIUpdate, cleanup
  local destination = false
  local numberOfCheckpoints = 0
  local promptCheckpointNum = 0
  if task.instance.challenge.settings.enableRaceStatusPrompts then
    numberOfCheckpoints = checkpointSystem.getCheckpoints(task.instance, task.actor.checkpointGroup) or 0
    promptCheckpointNum = #numberOfCheckpoints - 2
    task.instance.raceStatusDisplayed = false
  end
  local function setupRoute()
    local roadRoute
    if task.actor.routeName and routes[task.actor.routeName] then
      roadRoute = routes[task.actor.routeName].roads
    end
    return roadRoute
  end
  local function createBehaviour()
    local behaviour = {
      traits = taskSystem.buildDriveTraits(task),
      roadRoute = setupRoute(),
      routeName = task.actor.routeName
    }
    if #task.dynamicTargets ~= 0 then
      behaviour.destinationPosition = task.dynamicTargets[1].position
    end
    if task.instance and task.instance.raceId and task.coreData then
      if task.instance.challenge.name and raceManager.raceSettingsPerMission[task.instance.challenge.name] then
        RaceManager.SetRaceProgressPerformanceBoostThreshold(task.instance.raceId, raceManager.raceSettingsPerMission[task.instance.challenge.name].raceProgressPerformanceBoostThreshold)
        RaceManager.SetRaceMaxSpeedReductionAfterPlayerHasBeenLeadingInSecondPart(task.instance.raceId, raceManager.raceSettingsPerMission[task.instance.challenge.name].raceMaxSpeedReductionAfterPlayerHasBeenLeadingInSecondPart)
      else
        RaceManager.SetRaceProgressPerformanceBoostThreshold(task.instance.raceId, raceManager.defaultRaceSettings.raceProgressPerformanceBoostThreshold)
        RaceManager.SetRaceMaxSpeedReductionAfterPlayerHasBeenLeadingInSecondPart(task.instance.raceId, raceManager.defaultRaceSettings.raceMaxSpeedReductionAfterPlayerHasBeenLeadingInSecondPart)
      end
      RaceManager.SetLapCount(task.instance.raceId, (task.coreData.totalLaps or 0) + 1)
    end
    return behaviour
  end
  local function AIUpdate(nonGoalUpdate)
    task.agent:highSpeedDrive(createBehaviour())
  end
  local function goalCallback(success, condition, completedLap, goalData)
    if task.instance.challenge.settings.enableRaceStatusPrompts and task.networkVars.checkpoints == promptCheckpointNum then
      if task.networkVars.laps == (task.coreData.totalLaps or 0) and not task.instance.raceStatusDisplayed then
        local racerPosition = RaceManager.GetRacerPosition(task.instance.raceId, task.agent.gameVehicle)
        if task.taskObject.playerTask then
          if racerPosition == 1 and not task.agent.controlled then
            feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245684", priority = 2})
          elseif racerPosition == 2 and not task.agent.controlled then
            feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:246415", priority = 2})
          end
          task.instance.raceStatusDisplayed = true
        elseif task.instance.missionType == "challenge" or racerPosition >= 2 then
          feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245685", priority = 2})
          task.instance.raceStatusDisplayed = true
        end
      end
    end
    if completedLap then
      task.networkVars.checkpoints = 1
      task.networkVars.laps = task.networkVars.laps + 1
    else
      task.networkVars.checkpoints = task.networkVars.checkpoints + 1
    end
  end
  return goalCallback, AIUpdate, cleanup
end)
