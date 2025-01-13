feedbackSystem.registerHUD("Tanner & Jones Mission 1 HUD", function(task, settings)
end, function(task, settings)
  local promptTable
  if string.find(task.specialName, "In Racer") then
    promptTable = {
      ["zap into racer"] = "ID:184126",
      ["jump off vehicle"] = "ID:184125",
      ["hit a cop"] = "ID:184127",
      ["zap back hook"] = "ID:184117",
      ["lose the cops"] = "ID:242126"
    }
  end
  local highlightVehicle = function(inID)
    local vehicles
    if type(inID) == "table" then
      for i = 1, #inID do
        vehicles = {
          {
            VehicleModelUID = inID[i],
            AllowTowedVehicles = false
          }
        }
        minimap.AddHighlightedVehicleModelUIDs(vehicles)
      end
    else
      vehicles = {
        {VehicleModelUID = inID, AllowTowedVehicles = false}
      }
      minimap.AddHighlightedVehicleModelUIDs(vehicles)
    end
    minimap.SetHighlightedVehicles(true)
  end
  local showPrompt = function(prompt, permanent, icon)
    local showAlways = permanent or false
    local promptCallback = function()
      feedbackSystem.menusMaster.clearSecondaryTextPrompt()
    end
    feedbackSystem.menusMaster.primaryTextPrompt(prompt, nil, false, showAlways, false, icon, promptCallback)
  end
  local function goalComplete(conditionKey)
    if string.find(task.specialName, "In Racer") then
      if conditionKey == 1 then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      elseif conditionKey == 2 then
        local vehicleListForHighlight
        if task.specialName == "In Racer 1" then
          vehicleListForHighlight = 298
          showPrompt(promptTable["jump off vehicle"])
          feedbackSystem.menusMaster.secondaryTextPrompt("ID:246222", false, false, true)
          feedbackSystem.menusMaster.setCurrentFocusString(3)
          localPlayer.minimapSupport.setHighlightedVehicleModelType("exclamationMark")
        elseif task.specialName == "In Racer 2" then
          vehicleListForHighlight = {
            267,
            271,
            280,
            269,
            265
          }
          showPrompt(promptTable["hit a cop"])
          feedbackSystem.menusMaster.secondaryTextPrompt("ID:246222", false, false, true)
          feedbackSystem.menusMaster.setCurrentFocusString(4)
          localPlayer.minimapSupport.setHighlightedVehicleModelType("smash")
        elseif task.specialName == "In Racer lose cop" then
          showPrompt(promptTable["lose the cops"])
          feedbackSystem.menusMaster.setCurrentFocusString(6)
        elseif task.specialName == "In Racer 3" then
          vehicleListForHighlight = 287
          showPrompt(promptTable["zap back hook"])
          feedbackSystem.menusMaster.secondaryTextPrompt("ID:246222", false, false, true)
          feedbackSystem.menusMaster.setCurrentFocusString(5)
          localPlayer:setBlockWagglePrompt(true)
          localPlayer.minimapSupport.setHighlightedVehicleModelType("exclamationMark")
        end
        localPlayer.simulationSupport.doWait(1.5, function()
          highlightVehicle(vehicleListForHighlight)
        end, "waitForHighlight")
      elseif conditionKey == 3 then
        removeUserUpdateFunction("waitForHighlight")
        showPrompt(promptTable["zap into racer"], true, localPlayer.buttonLayout.enterZap)
        feedbackSystem.menusMaster.setCurrentFocusString(2)
        minimap.RemoveAllHighlightedVehicleModelUIDs()
        if task.specialName == "In Racer 3" then
          localPlayer:setBlockWagglePrompt(false)
        end
      end
    end
  end
  local cleanup = function()
    minimap.RemoveAllHighlightedVehicleModelUIDs()
  end
  return nil, goalComplete, nil, cleanup
end)
