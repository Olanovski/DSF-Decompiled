module("onlineInstructionSupport", package.seeall)
local promptTimeOut = 10
local workingVector = vec.vector()
local playerData = {
  [0] = {
    lastStep = 0,
    playingPrompt = 0,
    prompts = {}
  },
  [1] = {
    lastStep = 0,
    playingPrompt = 0,
    prompts = {}
  }
}
local SSHUDStrings = {
  [0] = {
    text = "ss_p1_instruct",
    enable = "iSS_p1_instruct"
  },
  [1] = {
    text = "ss_p2_instruct",
    enable = "iSS_p2_instruct"
  }
}
local promptTimeOut = 3.5
local function removePlayerPrompt(localID)
  if userUpdateFunctions[SSHUDStrings[localID].text] then
    feedbackSystem.menusMaster.splitscreenSetTextVariable(SSHUDStrings[localID].text, nil, nil, nil)
    feedbackSystem.menusMaster.splitscreenSetVariable(SSHUDStrings[localID].enable, 0)
    removeUserUpdateFunction(SSHUDStrings[localID].text)
  end
end
local startTime0 = 0
local function displayPlayer0PromptCallBack()
  if g_NetworkTime - startTime0 > promptTimeOut then
    removePlayerPrompt(0)
    startTime0 = 0
  end
end
local function displayPlayer0Prompt(prompt, icon)
  if startTime0 ~= 0 then
    removePlayerPrompt(0)
  end
  feedbackSystem.menusMaster.splitscreenSetTextVariable(SSHUDStrings[0].text, prompt, nil, icon)
  feedbackSystem.menusMaster.splitscreenSetVariable(SSHUDStrings[0].enable, 1)
  startTime0 = g_NetworkTime
  addUserUpdateFunction(SSHUDStrings[0].text, displayPlayer0PromptCallBack, 4)
end
local startTime1 = 0
local function displayPlayer1PromptCallBack()
  if g_NetworkTime - startTime1 > promptTimeOut then
    removePlayerPrompt(1)
    startTime1 = 0
  end
end
local function displayPlayer1Prompt(prompt, icon)
  if startTime1 ~= 0 then
    removePlayerPrompt(1)
  end
  feedbackSystem.menusMaster.splitscreenSetTextVariable(SSHUDStrings[1].text, prompt, nil, icon)
  feedbackSystem.menusMaster.splitscreenSetVariable(SSHUDStrings[1].enable, 1)
  startTime1 = g_NetworkTime
  addUserUpdateFunction(SSHUDStrings[1].text, displayPlayer1PromptCallBack, 4)
end
local function setTextPrompt(prompt, value, felony, delay, icon, endCallback, localID, icon2)
  if gameStatus.splitscreenSession then
    if localID == 0 then
      displayPlayer0Prompt(prompt, icon)
    else
      displayPlayer1Prompt(prompt, icon)
    end
  else
    feedbackSystem.menusMaster.minimapTextPrompt(prompt, value, felony, delay, icon, endCallback, icon2)
  end
end
local function setDefaultPrompts(localID)
  localID = localID or 0
  playerData[localID].prompts = {
    score = {
      enabled = false,
      shown = false,
      resetOnScore = true,
      startTime = 10,
      resetTime = 30,
      message = "",
      displayFunction = function(self, objectivePos, opponents, player)
        displayPrompt(self.message, self.button, localID)
        return true
      end
    },
    accelerate = {
      enabled = false,
      shown = false,
      maxLevel = 4,
      startTime = 1,
      message = "ID:234235",
      displayFunction = function(self, objectivePos, opponents, player)
        if player.currentVehicle and player.currentVehicle.speed == 0 then
          displayPrompt(self.message, player.buttonLayout.accelerate, localID)
        end
        return true
      end
    },
    minimap = {
      enabled = false,
      shown = false,
      maxLevel = 5,
      distance = 250,
      message = "ID:234236",
      displayFunction = function(self, objectivePos, opponents, player)
        if objectivePos and not player.inZap and not GameVehicleResource.withinRadius(objectivePos, player.currentVehicle.position, self.distance) then
          displayPrompt(self.message, player.buttonLayout.minimapZoom, localID)
          return true
        end
      end
    },
    carSwap = {
      enabled = false,
      shown = false,
      minLevel = 5,
      maxLevel = 8,
      startTime = 30,
      distance = 100,
      message = "ID:234237",
      displayFunction = function(self, objectivePos, opponents, player)
        if not player.inZap and zapWeaponSupport.areZapWeaponsAvailable(localID) then
          displayPrompt(self.message, player.buttonLayout.vehicleSwap, localID)
          return true
        end
      end
    },
    carSwapShift = {
      enabled = false,
      shown = false,
      minLevel = 5,
      maxLevel = 8,
      startTime = 15,
      distance = 50,
      message = "ID:234237",
      displayFunction = function(self, objectivePos, opponents, player)
        if objectivePos and player.inZap and zapcontroller.GetTargetedGameVehicle(localID) and zapWeaponSupport.areZapWeaponsAvailable(localID) and GameVehicleResource.withinRadius(objectivePos, zapcontroller.GetTargetedGameVehicle().position, self.distance) then
          displayPrompt(self.message, player.buttonLayout.vehicleSwap, localID)
          return true
        end
      end
    },
    carSpawnShift = {
      enabled = false,
      shown = false,
      minLevel = 14,
      maxLevel = 16,
      startTime = 30,
      distance = 75,
      message = "ID:234238",
      displayFunction = function(self, objectivePos, opponents, player)
        if objectivePos and player.inZap and not zapcontroller.GetTargetedGameVehicle(localID) and zapWeaponSupport.areZapWeaponsAvailable(localID) and GameVehicleResource.withinRadius(objectivePos, spoolsystem.position, self.distance) then
          displayPrompt(self.message, player.buttonLayout.vehicleSwap, localID)
          return true
        end
      end
    },
    zapPulse = {
      enabled = false,
      shown = false,
      minLevel = 8,
      maxLevel = 11,
      startTime = 45,
      distance = 50,
      message = "ID:234239",
      displayFunction = function(self, objectivePos, opponents, player)
        if objectivePos and player.inZap and zapcontroller.GetTargetedGameVehicle(localID) and zapWeaponSupport.areZapWeaponsAvailable(localID) and opponents and GameVehicleResource.withinRadius(objectivePos, zapcontroller.GetTargetedGameVehicle(localID).position, self.distance) then
          for index, opponent in next, opponents, nil do
            if opponent.vehicle and opponent.vehicle.gameVehicle == zapcontroller.GetTargetedGameVehicle(localID) then
              displayPrompt(self.message, player.buttonLayout.enterZap, localID)
              return true
            end
          end
        end
      end
    },
    zapAttack = {
      enabled = false,
      shown = false,
      minLevel = 21,
      maxLevel = 23,
      startTime = 45,
      distance = 75,
      message = "ID:234240",
      displayFunction = function(self, objectivePos, opponents, player)
        if objectivePos and player.inZap and zapcontroller.GetTargetedGameVehicle(localID) and zapWeaponSupport.areZapWeaponsAvailable(localID) and opponents and GameVehicleResource.withinRadius(objectivePos, zapcontroller.GetTargetedGameVehicle(localID).position, self.distance) then
          for index, opponent in next, opponents, nil do
            if opponent.vehicle and opponent.vehicle.gameVehicle == zapcontroller.GetTargetedGameVehicle(localID) then
              displayPrompt(self.message, player.buttonLayout.enterZap, localID)
              return true
            end
          end
        end
      end
    },
    zap = {
      enabled = false,
      shown = false,
      maxLevel = 8,
      resetTime = 45,
      distance = 300,
      message = "ID:234254",
      button = localPlayerManager.players[localID].buttonLayout.enterZap,
      displayFunction = function(self, objectivePos, opponents, player)
        if objectivePos and not player.inZap and not GameVehicleResource.withinRadius(objectivePos, player.currentVehicle.position, self.distance) then
          displayPrompt(self.message, self.button, localID)
          return true
        end
      end
    },
    zapUp = {
      enabled = false,
      shown = false,
      maxLevel = 8,
      distance = 450,
      message = "ID:234255",
      displayFunction = function(self, objectivePos, opponents, player)
        if objectivePos and player.inZap and (zapcontroller.getZapLevel(localID) == 1 or zapcontroller.getZapLevel(localID) == 3) and not GameVehicleResource.withinRadius(objectivePos, spoolsystem.position, self.distance) then
          displayPrompt(self.message, player.buttonLayout.zapUp, localID)
          return true
        end
      end
    },
    zapDown = {
      enabled = false,
      shown = false,
      maxLevel = 6,
      distance = 100,
      message = "ID:234256",
      displayFunction = function(self, objectivePos, opponents, player)
        if objectivePos and player.inZap and zapcontroller.getZapLevel(localID) == 4 and GameVehicleResource.withinRadius(objectivePos, spoolsystem.position, self.distance) then
          displayPrompt(self.message, player.buttonLayout.zapDown, localID)
          return true
        end
      end
    },
    zapToAction = {
      enabled = false,
      shown = false,
      maxLevel = 8,
      startTime = 30,
      distance = 700,
      message = "ID:234257",
      displayFunction = function(self, objectivePos, opponents, player)
        if objectivePos and MPZapToAction.canZapToAction(player) and not GameVehicleResource.withinRadius(objectivePos, spoolsystem.position, self.distance) then
          displayPrompt(self.message, player.buttonLayout.zapReturn, localID)
          return true
        end
      end
    },
    boost = {
      enabled = false,
      shown = false,
      minLevel = 1,
      maxLevel = 5,
      startTime = 15,
      distance = 100,
      threshold = 75,
      message = "ID:234258",
      displayFunction = function(self, objectivePos, opponents, player)
        if (onlineProgressionSystem.onlineIsAbilityUnlocked(1) or gameStatus.splitscreenSession) and objectivePos and not player.inZap and player.abilityPoints > self.threshold then
          if objectivePos == player.currentVehicle.position then
            local smallDistance = math.huge
            local workingDistance
            for index, opponent in next, opponents, nil do
              workingDistance = workingVector:sub(opponent.position, player.currentVehicle.position):length()
              if smallDistance > workingDistance then
                smallDistance = workingDistance
              end
            end
            if smallDistance < self.distance then
              displayPrompt(self.message, player.buttonLayout.boostAbility, localID)
              return true
            end
          elseif not GameVehicleResource.withinRadius(objectivePos, player.currentVehicle.position, self.distance) then
            displayPrompt(self.message, player.buttonLayout.boostAbility, localID)
            return true
          end
        end
      end
    },
    ram = {
      enabled = false,
      shown = false,
      minLevel = 3,
      maxLevel = 10,
      startTime = 15,
      distance = 25,
      threshold = 40,
      message = "ID:234259",
      displayFunction = function(self, objectivePos, opponents, player)
        if not player.inZap and onlineProgressionSystem.onlineIsAbilityUnlocked(2) and player.abilityPoints > self.threshold and opponents then
          local smallDistance = math.huge
          local workingDistance
          for index, opponent in next, opponents, nil do
            workingDistance = workingVector:sub(opponent.position, player.currentVehicle.position):length()
            if smallDistance > workingDistance then
              smallDistance = workingDistance
            end
          end
          if smallDistance < self.distance then
            displayPrompt(self.message, player.buttonLayout.ramAbility, localID)
            return true
          end
        end
      end
    },
    damaged = {
      enabled = false,
      shown = false,
      maxLevel = 8,
      resetTime = 20,
      distance = 50,
      threshold = 0.8,
      maxThreshold = 1,
      displayFunction = function(self, objectivePos, opponents, player)
        if not player.inZap and player.currentVehicle.damage > self.threshold and player.currentVehicle.damage < self.maxThreshold then
          local distance = workingVector:sub(objectivePos, player.position):length()
          if distance <= self.distance and zapWeaponSupport.areZapWeaponsAvailable(localID) then
            displayPrompt("ID:234260", player.buttonLayout.vehicleSwap, localID)
            return true
          elseif distance > 0 then
            displayPrompt("ID:234261", player.buttonLayout.enterZap, localID)
            return true
          end
        end
      end
    }
  }
end
function setPrompts(accelerate, minimap, carSwap, carSwapShift, carSpawnShift, zap, zapUp, zapDown, zapToAction, boost, ram, damaged, zapPulse, zapAttack, lastScoredMsg, lastScoreMsgTimeOverRide, localID)
  localID = localID or 0
  setPrompt("accelerate", accelerate, nil, nil, nil, localID)
  setPrompt("minimap", minimap, nil, nil, nil, localID)
  setPrompt("carSwap", carSwap, nil, nil, nil, localID)
  setPrompt("carSwapShift", carSwapShift, nil, nil, nil, localID)
  setPrompt("carSpawnShift", carSpawnShift, nil, nil, nil, localID)
  setPrompt("zap", zap, nil, nil, nil, localID)
  setPrompt("zapUp", zapUp, nil, nil, nil, localID)
  setPrompt("zapDown", zapDown, nil, nil, nil, localID)
  setPrompt("zapToAction", zapToAction, nil, nil, nil, localID)
  setPrompt("boost", boost, nil, nil, nil, localID)
  setPrompt("ram", ram, nil, nil, nil, localID)
  setPrompt("damaged", damaged, nil, nil, nil, localID)
  setPrompt("zapPulse", zapPulse, nil, nil, nil, localID)
  setPrompt("zapAttack", zapAttack, nil, nil, nil, localID)
  setPrompt("score", lastScoredMsg ~= nil, lastScoreMsgTimeOverRide, lastScoreMsgTimeOverRide, lastScoredMsg, localID)
end
function setPrompt(promptName, promptEnabled, promptStartTime, promptResetTime, promptMessage, localID)
  localID = localID or 0
  local promptsTable = playerData[localID].prompts
  if promptsTable[promptName] then
    promptsTable[promptName].enabled = promptEnabled or promptEnabled == nil
    if promptStartTime then
      promptsTable[promptName].startTime = promptStartTime
    end
    if promptResetTime then
      promptsTable[promptName].resetTime = promptResetTime
    end
    if not gameStatus.splitscreenSession then
      if promptsTable[promptName].minLevel and promptsTable[promptName].minLevel > getLocalPlayerLevel() then
        promptsTable[promptName].enabled = false
        return
      elseif promptsTable[promptName].maxLevel and promptsTable[promptName].maxLevel < getLocalPlayerLevel() then
        promptsTable[promptName].enabled = false
        return
      end
    end
    if not promptsTable[promptName].timer then
      if promptsTable[promptName].startTime then
        promptsTable[promptName].timer = g_NetworkTime + promptsTable[promptName].startTime
      end
    elseif promptsTable[promptName].resetTime then
      if not promptsTable[promptName].shown and promptsTable[promptName].startTime then
        promptsTable[promptName].timer = g_NetworkTime + promptsTable[promptName].startTime
      else
        promptsTable[promptName].timer = g_NetworkTime + promptsTable[promptName].resetTime
      end
    end
    if promptsTable[promptName].message and promptMessage then
      promptsTable[promptName].message = promptMessage
    end
  end
end
function resetPrompts(localID)
  localID = localID or 0
  setDefaultPrompts(localID)
end
function resetPrompt(promptName, localID)
  localID = localID or 0
  local promptsTable = playerData[localID].prompts
  if promptsTable[promptName] then
    promptsTable[promptName].enabled = false
    promptsTable[promptName].shown = false
    promptsTable[promptName].timer = nil
  end
end
function releasePrompts()
  playerData[0].prompts = {}
  playerData[1].prompts = {}
end
function modifyPrompt(promptName, promptProperty, promptPropertyValue, localID)
  localID = localID or 0
  local promptsTable = playerData[localID].prompts
  if promptsTable[promptName] then
    promptsTable[promptName][promptProperty] = promptPropertyValue
  end
end
function addPrompt(promptName, promptData, localID)
  localID = localID or 0
  local promptsTable = playerData[localID].prompts
  if not promptsTable[promptName] then
    promptsTable[promptName] = promptData
    promptsTable[promptName].userDefined = true
  elseif promptsTable[promptName].userDefined then
    promptsTable[promptName] = promptData
  end
end
function displayPrompt(promptText, promptButton, localID, promptButton2)
  localID = localID or 0
  setTextPrompt(promptText, nil, nil, nil, promptButton, nil, localID, promptButton2)
  playerData[localID].playingPrompt = promptTimeOut
end
function step(objectivePos, opponents, scored, localID)
  localID = localID or 0
  local promptsTable = playerData[localID].prompts
  if 0 < playerData[localID].playingPrompt then
    for i, prompt in pairs(promptsTable) do
      if scored and prompt.resetOnScore then
        if not prompt.shown and prompt.startTime then
          promptsTable[i].timer = g_NetworkTime + prompt.startTime
        elseif prompt.resetTime then
          promptsTable[i].timer = g_NetworkTime + prompt.resetTime
        end
      end
    end
    playerData[localID].playingPrompt = playerData[localID].playingPrompt - (g_NetworkTime - playerData[localID].lastStep)
  else
    local shownPrompt = false
    for i, prompt in pairs(promptsTable) do
      if scored and prompt.resetOnScore then
        if not prompt.shown and prompt.startTime then
          promptsTable[i].timer = g_NetworkTime + prompt.startTime
        elseif prompt.resetTime then
          promptsTable[i].timer = g_NetworkTime + prompt.resetTime
        end
      end
      if not shownPrompt and prompt.enabled and (not prompt.shown or prompt.resetTime) and (prompt.timer and prompt.timer <= g_NetworkTime or not prompt.timer) then
        shownPrompt = prompt.displayFunction(prompt, objectivePos, opponents, localPlayerManager.players[localID])
        if shownPrompt then
          if prompt.resetTime then
            promptsTable[i].timer = g_NetworkTime + promptsTable[i].resetTime
            promptsTable[i].shown = true
            break
          end
          promptsTable[i].shown = true
          break
        end
      end
    end
  end
  playerData[localID].lastStep = g_NetworkTime
end
function purge()
  removePlayerPrompt(0)
  removePlayerPrompt(1)
  playerData[0].lastStep = 0
  playerData[0].playingPrompt = 0
  playerData[0].prompts = {}
  playerData[1].lastStep = 0
  playerData[1].playingPrompt = 0
  playerData[1].prompts = {}
end
