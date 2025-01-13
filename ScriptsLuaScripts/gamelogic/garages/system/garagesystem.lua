module("garage", package.seeall)
local repairResetTime = 5
local garageTrigger = 0
local triggerSize = 30
local minimapRadius = 25
local iconRadius = 30
local iconColour = vec.vector(255, 255, 255, 255)
local garagePurchaseScreenActive = false
local drivenAVehicleIntoGarage = false
icons = {}
spoolingVehicle = false
garageWillpower = 0
local enabled = false
local visible = false
local inHotspot = false
garageTriggered = false
garageExitFinished = true
local hotspotEnterTime = g_NetworkTime
local lastRepaired = 0
currentGarageID = false
local enteredWithThrillCam
local largeVehicleList = {
  [118] = true,
  [123] = true,
  [131] = true,
  [152] = true,
  [167] = true,
  [170] = true,
  [185] = true,
  [186] = true,
  [201] = true,
  [246] = true,
  [276] = true,
  [277] = true,
  [284] = true,
  [285] = true,
  [286] = true,
  [289] = true,
  [290] = true,
  [291] = true,
  [298] = true,
  [301] = true
}
local garageUnlockStrings = {
  ["FISHERMANS WHARF"] = "ID:245775",
  ["DOWNTOWN"] = "ID:245776",
  ["PRESIDIO"] = "ID:245777",
  ["GOLDEN GATE PARK"] = "ID:245778",
  ["FOREST HILL"] = "ID:245779",
  ["HUNTERS POINT"] = "ID:245780",
  ["MIDTOWN"] = "ID:245781",
  ["REDWOOD"] = "ID:245782",
  ["LIGHTHOUSE BAY"] = "ID:245783",
  ["MARIN"] = "ID:245784"
}
local garageMarkerSettings = {
  minimap = {
    type = "Minimap",
    gadgetID = 200,
    colour = iconColour,
    radius = minimapRadius,
    visible = false,
    canrotate = false,
    constrain = false,
    nofade = true,
    animationType = "None"
  },
  shift = {
    type = "Shift",
    gadgetID = 200,
    scale = vec.vector(0.8, 0.8, 0.8, 0.8),
    colour = iconColour,
    radius = iconRadius,
    visible = false,
    canrotate = false
  },
  hotspot = {
    type = "World",
    gadgetID = 211,
    offset = vec.vector(0, 0.5, 0, 0),
    scale = vec.vector(9, 9, 9, 0),
    colour = vec.vector(255, 255, 255, 255),
    visible = false,
    facing = false,
    facinginzap = false,
    isoffsetinzap = false,
    introType = "Fade",
    outroType = "Fade",
    sortBias = 3
  },
  hotspotColumn = {
    type = "World",
    gadgetID = 307,
    offset = vec.vector(0, 1, 0, 0),
    colour = vec.vector(255, 255, 255, 0),
    scale = vec.vector(9, 9, 9, 0),
    visible = false,
    facing = true,
    fadedistance = 120,
    minalpha = 100,
    maxalpha = 255,
    introType = "Fade",
    outroType = "Fade",
    sortBias = 1
  },
  garageIcon = {
    type = "World",
    gadgetID = 200,
    offset = vec.vector(0, 7.9, 0, 0),
    scale = vec.vector(2, 2, 2, 2),
    colour = vec.vector(255, 255, 255, 245),
    visible = false,
    facing = true,
    facinginzap = false,
    isoffsetinzap = false,
    introType = "Fade",
    outroType = "Fade",
    sortBias = 2
  }
}
local function initialiseData()
  if not Network.isOnlineGame() and not Network.isSplitScreenMode() then
    for garageID, garageDetails in next, locations, nil do
      locationsByName[garageDetails.name] = garageDetails
      Garages.AddGarage(garageDetails.ID, garageDetails.position, garageDetails.price, ProfileSettings.GetGarageOwned(garageDetails.ID))
      if ProfileSettings.GetGarageOwned(garageDetails.ID) then
        Garages.PurchaseGarage(garageDetails.ID)
      end
    end
    Garages.SetEnterGarageTime(garageTrigger)
    Garages.SetRepairCooldownTime(repairResetTime)
    Garages.SetRewards(willpowerRewards)
    Garages.SetMoneyBags(moneyBagsMultiplier)
  end
end
addInitObject(initialiseData)
function createIcon(garage)
  if not icons[garage.ID] and not Network.isOnlineGame() and not Network.isSplitScreenMode() then
    icons[garage.ID] = {}
    InteractiveIconsManager.addIcon("Garage", garage.ID, garage.position, triggerSize)
    local owned = ProfileSettings.GetGarageOwned(garage.ID)
    for iconType, iconSettings in next, garageMarkerSettings, nil do
      iconSettings.identifier = garage.ID
      iconSettings.position = garage.position
      if iconType == "minimap" or iconType == "garageIcon" or iconType == "shift" then
        if not owned then
          iconSettings.gadgetID = 251
        else
          iconSettings.gadgetID = 200
        end
        iconSettings.visible = visible
      else
        iconSettings.visible = visible and owned
      end
      if iconType == "minimap" then
        if not ProfileSettings.GetGarageWillpowerTutorialPlayed() and (configSelector.launchConfig.Name == "Single Player" or configSelector.launchConfig.Name == "Post Debrief") then
          iconSettings.constrain = true
          iconSettings.animationType = "WaveScale"
        else
          iconSettings.constrain = false
          iconSettings.animationType = "None"
        end
      end
      icons[garage.ID][iconType] = Marker:create(iconSettings)
    end
  end
end
function createIcons()
  for garageID, garageDetails in next, locations, nil do
    if ProfileSettings.GetGarageUnlocked(garageDetails.ID) then
      createIcon(garageDetails)
    end
  end
end
function deleteIcon(garage)
  if icons[garage.ID] then
    for iconType, icon in next, icons[garage.ID], nil do
      Marker:delete(icon)
    end
    InteractiveIconsManager.removeIcon(garage.ID, garage.position)
    icons[garage.ID] = nil
  end
end
function deleteIcons()
  for garageID, garageDetails in next, locations, nil do
    deleteIcon(garageDetails)
  end
end
function enable(status, forceEnable)
  enabled = status and not Network.isOnlineGame() and not Network.isSplitScreenMode()
  hide(not status)
  if enabled and (forceEnable or not challengeProgressionTable[progressionSystem.currentProgression].settings or not challengeProgressionTable[progressionSystem.currentProgression].settings.blockGarage) then
    createIcons()
  else
    deleteIcons()
  end
  Garages.SetEnabled(enabled and visible)
  if ProfileSettings.GetGarageWillpowerTutorialPlayed() or configSelector.launchConfig.Name ~= "Single Player" then
    Garages.earnWillpower = status
  end
end
function areGaragesEnabled()
  if enabled then
    return true
  end
  return false
end
function hide(status)
  visible = not status
  updateIcons(enabled, visible)
  Garages.SetEnabled(enabled and visible)
end
local function cutsceneDoneFadeIn(vehicle)
  return function()
    if enteredWithThrillCam then
      enteredWithThrillCam = false
      setActiveCamera("ThrillCam", localPlayer.localID)
    end
    propSystem.reenableAllPropTypes()
    activeChallenges.preventActiveChallenges = false
    progressionSystem.setTrafficEvents(true)
    updateIcons(enabled, visible)
    if localPlayer.currentVehicle and localPlayer.currentVehicle.abilityActive then
      localPlayer.currentVehicle:cancelAbility(localPlayer.localID)
    end
    local callback = function()
      dareSystem.reactivateSuspendedDare()
      replays.unPause()
      garageExitFinished = true
    end
    if vehicle then
      localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
      localPlayer:SetZapLevel(0, vehicle, true)
    end
    spooling.fadeIn(nil, nil, callback)
  end
end
local function spawnVehicleWaitForCity(locationName, modelID, vehicle)
  return function()
    if spoolsystem.IsLocationResident(locationsByName[locationName].spawnPosition) then
      if localPlayer.currentVehicle and drivenAVehicleIntoGarage or modelID then
        propSystem.disablePropType("Garage_Gate")
        if not localPlayer:getTaskObject() then
          activeChallenges.preventActiveChallenges = true
          for instanceID, instance in next, challengeSystem.instances, nil do
            instance:delete()
          end
          Getaway.StopAll()
          Chase.StopAll()
          progressionSystem.setTrafficEvents(false)
          vehicleManager.clearOrphanage()
        end
        if localPlayer.cameraMode == "ThrillCam" then
          enteredWithThrillCam = true
          setActiveCamera("Normal", localPlayer.localID)
        end
        local cutscene = locationsByName[locationName].smallCutscene
        if largeVehicleList[modelID] then
          cutscene = locationsByName[locationName].largeCutscene
        end
        engineCutscene.triggerCutscene(cutscene, nil, cutsceneDoneFadeIn(vehicle))
      else
        updateIcons(enabled, visible)
        if localPlayer.currentVehicle and localPlayer.currentVehicle.abilityActive then
          localPlayer.currentVehicle:cancelAbility(localPlayer.localID)
        end
        local callback = function()
          dareSystem.reactivateSuspendedDare()
          replays.unPause()
          garageExitFinished = true
        end
        spooling.fadeIn(nil, nil, callback)
      end
      drivenAVehicleIntoGarage = false
      spoolingVehicle = false
      feedbackSystem.menusMaster.allowUnlockPanel(true)
      removeUserUpdateFunction("garageWaitForCity")
    end
  end
end
local function spawnVehicleWaitForVehicle(locationName, modelID, chosenShader)
  Garages.SpoolVehicleModel(modelID)
  local bigRigID = 286
  local trailerID = 123
  return function()
    if TrafficSpooler.IsPlayerVehicleLoaded() then
      local vehicleParams = {
        modelID = modelID,
        position = locationsByName[locationName].spawnPosition,
        heading = locationsByName[locationName].heading,
        initialVelocity = 0
      }
      if chosenShader then
        vehicleParams.shader = {
          [0] = chosenShader
        }
      end
      local vehicle = vehicleManager.spawnVehicle(vehicleParams)
      for i = 1, 3 do
        GameVehicleResource.setCharacterSpoolingEntityIndex(vehicle.gameVehicle, i, "-1")
      end
      if modelID == bigRigID then
        GameVehicleResource.createTrailerAndHookup({
          gameVehicle = vehicle.gameVehicle,
          trailerId = trailerID
        })
      end
      localPlayer:SetZapLevel(0, vehicle, true)
      localPlayer:buildZapReturn()
      removeUserUpdateFunction("garageWaitForVehicle")
      addUserUpdateFunction("garageWaitForCity", spawnVehicleWaitForCity(locationName, modelID, vehicle), 1)
    end
  end
end
local function spawnVehicleAfterFadeCleanUp(locationName, modelID, chosenShader)
  return function()
    if localPlayer.currentVehicle then
      localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
      if not localPlayer.currentVehicle:getTaskObject() then
        localPlayer.currentVehicle:delete()
      end
    end
    addUserUpdateFunction("garageWaitForVehicle", spawnVehicleWaitForVehicle(locationName, modelID, chosenShader), 1)
  end
end
local function teleportVehicleAfterFade(locationName)
  if localPlayer.currentVehicle and drivenAVehicleIntoGarage then
    print("TELEPORTING VEHICLE: " .. tostring(localPlayer.currentVehicle))
    VEdit.ResetVehicleDamage()
    local matrix = alignMatrix(locationsByName[locationName].spawnPosition, locationsByName[locationName].heading)
    localPlayer.currentVehicle:teleport(matrix)
  else
    print("nothing to teleport")
    localPlayer:SetZapLevel(2, nil, true, {forcedOut = true})
    zapcontroller.setActionPoinTracking(locationsByName[locationName].spawnPosition, locationsByName[locationName].heading, 0, localPlayer.localID)
  end
  addUserUpdateFunction("garageWaitForCity", spawnVehicleWaitForCity(locationName), 1)
end
function spawnVehicle(locationName, modelID, chosenShader)
  print("spawnVehicle( " .. tostring(locationName) .. ", " .. tostring(modelID) .. ", " .. tostring(chosenShader) .. ")")
  garageTriggered = true
  spoolingVehicle = true
  feedbackSystem.menusMaster.allowUnlockPanel(false)
  if modelID then
    if modelID ~= ProfileSettings.GetGarageVehicle() then
      ProfileSettings.SetGarageVehicle(modelID)
      progressionSystem.saveGame("Exited a garage with a vehicle different to the one stored")
    end
    spooling.fadeOut(nil, 0, spawnVehicleAfterFadeCleanUp(locationName, modelID, chosenShader))
  else
    spooling.fadeOut(nil, 0, teleportVehicleAfterFade(locationName))
  end
  Chase.StopAll()
  Getaway.StopAll()
  presenceSystem.setPresence(9, true)
  felony_suspiciousVehicleManager.enableSuspiciousVehicles(true)
  felony_patrollingVehicleManager.enablePatrollingVehicles(true)
  InteractiveIconsManager.clearBuffer()
end
_G.garageSpawnVehicle = garage.spawnVehicle
function updateIcons(enabled, visible)
  for garageID, iconList in next, icons, nil do
    local on = enabled and visible and ProfileSettings.GetGarageUnlocked(garageID)
    for iconType, icon in next, iconList, nil do
      if on == false then
        icon.visible = false
      end
      if on == true and (iconType == "shift" or iconType == "minimap") then
        icon.visible = true
      end
    end
  end
  local IconOn = enabled and visible
  InteractiveIconsManager.enableIconType("Garage", IconOn)
end
function updateIcon(ID, inRange)
  print("updateIcon( " .. tostring(ID) .. ", " .. tostring(inRange) .. " )")
  for garageID, garageDetails in next, locations, nil do
    if garageDetails.ID == ID and icons[garageDetails.ID] then
      local owned = ProfileSettings.GetGarageOwned(garageDetails.ID)
      for iconType, icon in next, icons[garageDetails.ID], nil do
        if iconType ~= "shift" and iconType ~= "minimap" then
          if iconType == "garageIcon" then
            icon.visible = inRange
          elseif owned then
            icon.visible = inRange
          end
        end
      end
    end
  end
end
function unlockGarage(ID)
  ProfileSettings.SetGarageUnlocked(ID)
end
function purchaseGarage(ID)
  if ProfileSettings.GetGarageUnlocked(ID) then
    ProfileSettings.SetGarageOwned(ID)
    Garages.PurchaseGarage(ID)
    for garageID, garageDetails in next, locations, nil do
      if garageDetails.ID == ID then
        deleteIcon(garageDetails)
        createIcon(garageDetails)
        break
      end
    end
    vehicleManager.updateVehicleUnlocks(nil, nil, ID)
    progressionSystem.challengeUnlockCheck(ID)
    progressionSystem.saveGame("Purchased a garage")
  end
end
function updateGarageUnlocks(chapter)
  print("updateGarageUnlocks")
  callStack()
  local unlocks = false
  for garageID, garageDetails in next, locations, nil do
    if chapter >= garageDetails.unlockChapter and (ProfileSettings.GetMissionAttempted(cards.ReverseMissionNetworkLookup["Tutorial garage"]) or chapter > 0) and not ProfileSettings.GetGarageUnlocked(garageDetails.ID) then
      unlockGarage(garageDetails.ID)
      if garageDetails.price == 0 then
        shop.purchaseGarage(garageDetails.ID)
      else
        unlocks = unlocks or {}
        table.insert(unlocks, garageDetails.ID)
      end
      if enabled then
        createIcon(garageDetails)
      end
    end
  end
  if unlocks then
    local unlockTitle = "ID:245773"
    if #unlocks == 1 then
      unlockTitle = garageUnlockStrings[locations[unlocks[1]].name]
    end
    feedbackSystem.menusMaster.queueUnlockPanel("gadget", "garage", "garage", unlocks, nil, nil, unlockTitle, "ID:245770")
  end
end
function repairVehicle()
  GameVehicleResource.zapFlash(localPlayer.currentVehicle.gameVehicle)
  VEdit.ResetVehicleDamage()
  OneShotSound.Play("HUD_Garage_Vehicle_Repair", false)
end
_G.garageRepairVehicle = garage.repairVehicle
function awardedWillpower(wpAmount)
  garageWillpower = garageWillpower + wpAmount
end
_G.garageAwardedWillpower = garage.awardedWillpower
function enterGarage(garageID)
  localPlayer:clearPreviousVehicle()
  garageTriggered = true
  garageExitFinished = false
  drivenAVehicleIntoGarage = localPlayer.currentVehicle and localPlayer.currentVehicle.controlled
  feedbackSystem.previewScreen.clearActivityBeingPrompted()
  feedbackSystem.previewScreen.hideZapPreview()
  if localPlayer.currentVehicle and localPlayer.currentVehicle.abilityActive then
    localPlayer.currentVehicle:cancelAbility(localPlayer.localID)
  end
  dareSystem.suspendActiveDare()
  vehicleManager.clearOrphanage()
  PauseMenu.triggergarage(garageID)
end
function enterGarageHotspot(garageID)
  currentGarageID = garageID
  hotspotEnterTime = g_NetworkTime
  Garages.GarageEntryRangeCallback(garageID, true)
end
function _G.garageEnterHotspot()
  print("code calling enterGarageHotspot")
end
function exitGarageHotspot()
  if currentGarageID then
    Garages.GarageEntryRangeCallback(currentGarageID, false)
  end
  garageTriggered = false
  currentGarageID = false
  removeUserUpdateFunction("inGarageHotspotUpdate")
end
function _G.garageExitHotspot()
  print("code calling exitGarageHotspot")
end
function canAwardWillpower()
  player = localPlayerManager.players[0]
  if not localPlayer:getTaskObject() and not Getaway.IsAGetawayActive() and not Chase.IsAChaseActive() and not vehicleManager.previewVehicleManager.previewVehicle and not player.zapTransition and not player.inCutscene and not progressionSystem.applyingChapterSettings then
    return true
  else
    return false
  end
end
_G.garageCanAwardWillpower = garage.canAwardWillpower
function canPlayerAffordGarage(garageID)
  local playerWillpower = ProfileSettings.GetWillpower()
  local garagePrice = locations[garageID].price
  if playerWillpower and garagePrice and playerWillpower < garagePrice then
    return false
  else
    return true
  end
end
function isGaragePurchaseScreenActive()
  if garagePurchaseScreenActive then
    return true
  end
  return false
end
function purchaseGaragePrompt(garageID)
  garagePurchaseScreenActive = true
  feedbackSystem.menusMaster.masterSetVariable("iActivity_Toggle", 0)
  localPlayer.controls:resetState("Player")
  localPlayer.controllerInterface:removePlayerControl()
  zapcontroller.EnableZapInput(false)
  simulation.setSpeed(0)
  Sound.SimulationPause()
  PauseMenu.allow(false)
  local playerWillpower = ProfileSettings.GetWillpower()
  local garagePrice = locations[garageID].price
  local garageName = locations[garageID].name
  local blockBuyButton = false
  if not localPlayer.inZap then
    localPlayer:enterCutsceneMode()
  end
  if feedbackSystem.previewScreen.activityBeingPrompted and localPlayer.inZap then
    feedbackSystem.previewScreen.hidePreviewScreen()
  end
  if not canPlayerAffordGarage(garageID) then
    blockBuyButton = true
  end
  if blockBuyButton then
    Menu.SetTextVariable("ErrorMessages", "Garage_Message_Title", "ID:243862")
    Menu.SetTextVariable("ErrorMessages", "Garage_Message_Copy", "ID:243863", garagePrice, playerWillpower)
    Menu.SetTextVariable("ErrorMessages", "Garage_Message_Opt_DontBuy", "ID:235459")
    Menu.SetVariable("ErrorMessages", "OptionNumber", 1)
  else
    Menu.SetTextVariable("ErrorMessages", "Garage_Message_Title", "ID:243852")
    Menu.SetTextVariable("ErrorMessages", "Garage_Message_Copy", "ID:243853", playerWillpower, garageName, garagePrice)
    Menu.SetTextVariable("ErrorMessages", "Garage_Message_Opt_Buy", "ID:243856")
    Menu.SetTextVariable("ErrorMessages", "Garage_Message_Opt_DontBuy", "ID:216901")
    Menu.SetVariable("ErrorMessages", "OptionNumber", 2)
  end
  Menu.SetTextVariable("ErrorMessages", "Garage_Message_Info1", "HI")
  Menu.SetTextVariable("ErrorMessages", "Garage_Message_Info2", "LO")
  local starBuy = locations[garageID].starBuy
  if starBuy then
    local vehicleStats = vehicleStats[starBuy]
    if vehicleStats then
      local string1 = vehicleStats.ManufacturerName
      local string2 = vehicleStats.ModelName
      local number = locations[garageID].otherBuys
      Menu.SetTextVariable("ErrorMessages", "Garage_Message_Info1", "ID:248767", string1, string2, number)
    end
  end
  local numberOfChallengesUnlockedByGarage = #challengeLookupTable.shop[garageID]
  if numberOfChallengesUnlockedByGarage > 0 then
    local string1 = false
    if numberOfChallengesUnlockedByGarage == 1 then
      string1 = "ID:248768"
    elseif numberOfChallengesUnlockedByGarage > 1 then
      string1 = "ID:248769"
    end
    Menu.SetTextVariable("ErrorMessages", "Garage_Message_Info2", string1)
  end
  local showPurchasePrompt = function()
    Menu.ChangePage("ErrorMessages", "Garage_Message")
    Menu.ShowMenu("ErrorMessages", 1)
    removeUserUpdateFunction("setPurchasePromptText")
  end
  addUserUpdateFunction("setPurchasePromptText", showPurchasePrompt, 0.3 * updates.stepRate, true)
  addUserUpdateFunction("garageButtonDelay", function()
    setBuyGarageButtons(garageID, blockBuyButton)
    removeUserUpdateFunction("garageButtonDelay")
  end, 0.9 * updates.stepRate, true)
end
local function buyGarageCleanUp(showGaragePreview)
  garagePurchaseScreenActive = false
  removeUserUpdateFunction("garageButtonDelay")
  if localPlayer.inCutscene then
    localPlayer:exitCutsceneMode()
  end
  if feedbackSystem.previewScreen.activityBeingPrompted and localPlayer.inZap and showGaragePreview then
    feedbackSystem.previewScreen.showPreview("shiftHotspotPreview", feedbackSystem.previewScreen.activityBeingPrompted.ID)
  end
  if localPlayer.inZap then
    simulation.setSpeed(zap.singlePlayerZapSlowDownMultiplier)
  else
    simulation.setSpeed(1)
  end
  Sound.SimulationResume()
  controlHandler:resetState("BuyGarage")
  controlHandler:removeState("BuyGarage", localPlayer.localID)
  if localPlayer.currentVehicle and localPlayer.currentVehicle.controlled then
    localPlayer.controls:setState("Player")
  end
  PauseMenu.allow(true)
  localPlayer.controllerInterface:registerPlayerControl()
  zapcontroller.EnableZapInput(true)
  Menu.ShowMenu("ErrorMessages", 0)
  OneShotSound.Play("Menu_Select")
end
local rejectGarage = false
local selectionMade = false
function setBuyGarageButtons(garageID, blockBuyButton)
  rejectGarage = false
  selectionMade = false
  local function menuSelectionUp()
    if rejectGarage and not selectionMade then
      OneShotSound.Play("Menu_Move")
      rejectGarage = false
    end
  end
  local function menuSelectionDown()
    if not rejectGarage and not selectionMade then
      OneShotSound.Play("Menu_Move")
      rejectGarage = true
    end
  end
  if not blockBuyButton then
    controlHandler:registerState(localPlayer.localID, "BuyGarage", {
      MissionComplete_Analog_Up = {
        JustPressed = {
          [1] = menuSelectionUp
        }
      },
      MissionComplete_Analog_Down = {
        JustPressed = {
          [1] = menuSelectionDown
        }
      },
      MissionComplete_DPad_Up = {
        JustPressed = {
          [1] = menuSelectionUp
        }
      },
      MissionComplete_DPad_Down = {
        JustPressed = {
          [1] = menuSelectionDown
        }
      },
      Menu_Select = {
        JustPressed = {
          [1] = function()
            selectionMade = true
            buyGarageCleanUp(rejectGarage)
            OneShotSound.Play("Menu_Select")
            if not rejectGarage then
              if garageID and locations[garageID].price then
                ProfileSettings.SetWillpower(ProfileSettings.GetWillpower() - locations[garageID].price)
              end
              Achievements.UnlockAchievement(AchievementTable.AchievementID.FIRSTTIMEBUYER.achievementID)
              ProfileSettings.SetGarageBought(garageID)
              purchaseGarage(garageID)
              enterGarage(garageID)
            end
          end
        }
      },
      Menu_Cancel = {
        JustPressed = {
          [1] = function()
            selectionMade = true
            buyGarageCleanUp(true)
          end
        }
      }
    })
  else
    rejectGarage = true
    controlHandler:registerState(localPlayer.localID, "BuyGarage", {
      Menu_Select = {
        JustPressed = {
          [1] = function()
            selectionMade = true
            buyGarageCleanUp(true)
          end
        }
      },
      Menu_Cancel = {
        JustPressed = {
          [1] = function()
            selectionMade = true
            buyGarageCleanUp(true)
          end
        }
      }
    })
  end
  controlHandler:setState("BuyGarage")
end
