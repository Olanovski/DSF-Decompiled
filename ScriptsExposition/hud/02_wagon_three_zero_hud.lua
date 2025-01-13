feedbackSystem.registerHUD("Exposition pre crash chase HUD", function(task, settings)
end, function(task, settings)
  local alleyEntrancePosition = vec.vector(437.257, 18.03195, 1755.96, 1)
  local marker
  local function goalComplete(conditionKey)
    if string.find(task.specialName, "TannerChasingJericho") then
      if conditionKey == 1 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:170893", false, true, false, false)
      end
    elseif task.specialName == "Player at the alley" then
      if conditionKey == 2 then
        if not marker then
          marker = feedbackSystem.newTarget({position = alleyEntrancePosition}, "Hotspot", {hideTerrainMarker = true})
        end
      elseif conditionKey == 3 then
        if marker then
          feedbackSystem.clearTarget(marker)
          marker = nil
          OneShotSound.Play("HUD_Play_Waypoint")
        end
      elseif conditionKey == 4 then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:245509", false, false, true, false)
      end
    elseif task.specialName == "JerichoAtTheAlleyway" then
      if conditionKey == 1 then
        if task.networkVars.checkpoints == 4 then
          task.actor.distanceBehindPlayer = -20
        elseif task.networkVars.checkpoints == 6 then
          task.actor.distanceBehindPlayer = -30
        elseif task.networkVars.checkpoints == 7 then
          task.actor.distanceBehindPlayer = -45
        elseif task.networkVars.checkpoints == 8 then
          task.instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle.performance = 2
          task.actor.distanceBehindPlayer = -90
        elseif task.networkVars.checkpoints == 9 then
          eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_1")
        end
        taskSystem.buildDriveTraits(task)
      end
    elseif task.specialName == "Halt" then
      local traits = {}
      if conditionKey == 1 then
        traits.desiredSpeed = 135
      elseif conditionKey == 2 then
        traits.desiredSpeed = 20
      end
      ActiveLifeAI.setPersonalityTraits(task.instance.taskObjectsByActorID.Jericho.coreData.agent.gameVehicle, traits)
    end
  end
  local function taskComplete()
    if task.specialName == "Objective prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:170893", false, false, false, false)
    elseif task.specialName == "Player at the alley" then
      if marker then
        feedbackSystem.clearTarget(marker)
        marker = nil
      end
      if feedbackSystem.menusMaster.primaryPromptActive then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
