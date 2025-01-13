feedbackSystem.registerHUD("Gone in 59 seconds HUD", function(task, settings)
end, function(task, settings)
  local timer = {
    slot = 1,
    startTime = 300,
    flashTime = 30
  }
  local counterTable = {
    slot = 2,
    title = "ID:220876",
    barTitle = "ID:236331",
    numericValue = 0,
    value = 0
  }
  local valueReseted = false
  local reminderTimer = 0
  local truckLookup = {
    ["Hot Car 1"] = "Truck 1",
    ["Hot Car 2"] = "Truck 2",
    ["Hot Car 3"] = "Truck 3",
    ["Hot Car 4"] = "Truck 4"
  }
  local function changeIconVisible(name, state)
    if task.instance.taskObjectsByActorID[name] then
      task.instance.taskObjectsByActorID[name].coreData.agent.iconsVisible = state
    end
  end
  local function update()
    if not gameStatus.simulationPaused then
      if task.agent.inTrailer and task.instance.taskObjectsByActorID[task.actor.ID].coreData.agent.iconsVisible then
        changeIconVisible(task.actor.ID, false)
      end
      if task.specialName == "first second" and not valueReseted then
        for k, v in next, task.instance.taskObjectsByActorID, nil do
          changeIconVisible(k, false)
        end
        feedbackSystem.removeSlot(1)
        feedbackSystem.removeSlot(2)
        valueReseted = true
      end
      if task.specialName == "Get all cars" and counterTable.numericValue ~= 4 then
        if not task.instance.allFourReturned then
          feedbackSystem.stepTimer(timer)
          counterTable.numericValue = task.instance.recoveredCars
          counterTable.value = task.instance.recoveredCars * 25
        else
          counterTable.numericValue = 4
          counterTable.value = 100
        end
        feedbackSystem.updateProgressBar(counterTable)
      end
      if task.specialName == "Far away from the targets" and reminderTimer ~= 0 and g_NetworkTime - reminderTimer > 15 then
        local prompt = {
          prompt = "ID:245311",
          icon1 = localPlayer.buttonLayout.enterZap,
          delay = false,
          priority = 2
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
        reminderTimer = g_NetworkTime
      end
      if localPlayer.inZap then
        if task.instance.taskObjectsByActorID["Truck 1"] and (task.instance.taskObjectsByActorID["Truck 1"].coreData.agent.iconsVisible == nil or task.instance.taskObjectsByActorID["Truck 1"].coreData.agent.iconsVisible == true) then
          changeIconVisible("Truck 1", false)
        end
        if task.instance.taskObjectsByActorID["Truck 2"] and (task.instance.taskObjectsByActorID["Truck 2"].coreData.agent.iconsVisible == nil or task.instance.taskObjectsByActorID["Truck 2"].coreData.agent.iconsVisible == true) then
          changeIconVisible("Truck 2", false)
        end
        if task.instance.taskObjectsByActorID["Truck 3"] and (task.instance.taskObjectsByActorID["Truck 3"].coreData.agent.iconsVisible == nil or task.instance.taskObjectsByActorID["Truck 3"].coreData.agent.iconsVisible == true) then
          changeIconVisible("Truck 3", false)
        end
        if task.instance.taskObjectsByActorID["Truck 4"] and (task.instance.taskObjectsByActorID["Truck 4"].coreData.agent.iconsVisible == nil or task.instance.taskObjectsByActorID["Truck 4"].coreData.agent.iconsVisible == true) then
          changeIconVisible("Truck 4", false)
        end
      end
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "hot car task" and conditionKey ~= 3 then
      for actorID, myTaskObject in next, task.instance.taskObjectsByActorID, nil do
        if myTaskObject.coreData.actor.team == "Hot Car team" or myTaskObject.coreData.actor.team == "Hot Car team2" then
          myTaskObject.coreData.agent.iconsVisible = true
        else
          myTaskObject.coreData.agent.iconsVisible = false
        end
      end
    elseif task.specialName == "Get all cars" and conditionKey == 1 then
      localPlayer:clearPreviousVehicle()
      localPlayer:overrideZapReturn(task.agent)
    elseif task.specialName == "Get all cars" and conditionKey == 2 then
      for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
        if (taskObject.coreData.actor.team == "Hot Car team" or taskObject.coreData.actor.team == "Hot Car team2") and taskObject.coreData.agent.controlled then
          localPlayer:overrideZapReturn(taskObject.coreData.agent)
          localPlayer:buildZapReturn()
        end
      end
    elseif task.specialName == "chase hot car" then
      task.instance.taskObjectsByActorID["Hot Car 3"].coreData.actor.markerType = "Objective"
    elseif task.specialName == "hot car visible" or task.specialName == "Wait for player" then
      for actorID, myTaskObject in next, task.instance.taskObjectsByActorID, nil do
        myTaskObject.coreData.agent.iconsVisible = false
      end
      if task.actor.ID == "Hot Car 1" then
        GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID["Truck 1"].coreData.agent.gameVehicle, true)
        changeIconVisible("Truck 1", true)
        changeIconVisible("Hot Car 1", true)
      elseif task.actor.ID == "Hot Car 2" then
        GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID["Truck 2"].coreData.agent.gameVehicle, true)
        changeIconVisible("Truck 2", true)
        changeIconVisible("Hot Car 2", true)
      elseif task.actor.ID == "Hot Car 3" then
        GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID["Truck 3"].coreData.agent.gameVehicle, true)
        changeIconVisible("Truck 3", true)
        changeIconVisible("Hot Car 3", true)
        changeIconVisible("Goon 1", true)
        changeIconVisible("Goon 2", true)
        changeIconVisible("Goon 3", true)
      elseif task.actor.ID == "Hot Car 4" then
        GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID["Truck 4"].coreData.agent.gameVehicle, true)
        changeIconVisible("Truck 4", true)
        changeIconVisible("Hot Car 4", true)
      end
    elseif task.specialName == "tow check" then
      if conditionKey == 1 then
        GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID[truckLookup[task.actor.ID]].coreData.agent.gameVehicle, false)
      else
        GameVehicleResource.setCanCaptureCars(task.instance.taskObjectsByActorID[truckLookup[task.actor.ID]].coreData.agent.gameVehicle, true)
      end
    elseif task.specialName == "Far away from the targets" then
      if conditionKey == 1 then
        local prompt = {
          prompt = "ID:245311",
          icon1 = localPlayer.buttonLayout.enterZap,
          delay = false,
          priority = 2
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
        reminderTimer = g_NetworkTime
      else
        reminderTimer = 0
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Lost chasers" then
      local prompt = {
        prompt = "ID:245550",
        delay = false,
        priority = 2
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
    end
  end
  return update, goalComplete, taskComplete, nil
end)
