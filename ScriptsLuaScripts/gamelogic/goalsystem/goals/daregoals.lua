validPlayerCameraModes = {
  Normal = true,
  DriverEye = true,
  Bonnet = true,
  Bumper = true,
  ThrillCam = true
}
local workingVector = vec.vector(0, 0, 0, 0)
local dareArgs = {}
local definedCameraModeGroups = {
  firstPersonCamera = {
    DriverEye = true,
    Bumper = true,
    Bonnet = true
  },
  thirdPersonCamera = {Normal = true}
}
function isInCorrectCameraMode(specifiedCameraMode)
  if validPlayerCameraModes[specifiedCameraMode] then
    if localPlayer.cameraMode == specifiedCameraMode then
      return true
    end
  elseif definedCameraModeGroups[specifiedCameraMode] and definedCameraModeGroups[specifiedCameraMode][localPlayer.cameraMode] then
    return true
  end
end
goalSystem.registerGoal("Dare time trigger", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local startTime = g_NetworkTime
  local elapsedTime
  local maxTime = params.value
  local previousValue = 0
  local function update()
    local goalConditionsMet = false
    elapsedTime = g_NetworkTime - startTime
    if elapsedTime >= maxTime then
      goalConditionsMet = true
    end
    if feedback then
      local difference = 0
      if previousValue < elapsedTime then
        difference = elapsedTime - previousValue
      end
      if difference > 0.1 then
        feedback(elapsedTime)
        previousValue = elapsedTime
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local cleanup = function()
    if not goalConditionsMet then
      OneShotSound.Play("HUD_Gen_Currency_Fail", false)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Dare overtakes in time", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local challengeOvertakes = 0
  local previousValue = 0
  local overtakesNeeded = params.value
  local currentOvertakes = localPlayer.scoring:getNumberOfOvertakes()
  local previousOvertakes = currentOvertakes
  local timeAllowance = params.timer
  local previousNetworkTime = g_NetworkTime
  local pointsParams = {
    pointsText = "+" .. tostring(1),
    pointsSlotPass = 2
  }
  local delay = 1
  local vehiclesOvertaken = {}
  local function maintainTable()
    for i, time in ipairs(vehiclesOvertaken) do
      if g_NetworkTime > time + timeAllowance then
        table.remove(vehiclesOvertaken, i)
      end
    end
    challengeOvertakes = #vehiclesOvertaken
  end
  local function update()
    goalConditionsMet = false
    currentOvertakes = localPlayer.scoring:getNumberOfOvertakes()
    if currentOvertakes ~= previousOvertakes then
      OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
      feedbackSystem.updatePointsFeedback(pointsParams)
      table.insert(vehiclesOvertaken, g_NetworkTime)
      maintainTable()
      previousNetworkTime = g_NetworkTime
      previousOvertakes = currentOvertakes
    elseif g_NetworkTime >= previousNetworkTime + delay then
      maintainTable()
      previousNetworkTime = g_NetworkTime
    end
    if feedback and previousValue ~= challengeOvertakes then
      feedback(challengeOvertakes)
      previousValue = challengeOvertakes
    end
    if challengeOvertakes >= overtakesNeeded then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
      goalSystem.callbackHandler(UID, params.score)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.score)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    if not goalConditionsMet and currentOvertakes > 0 then
      OneShotSound.Play("HUD_Gen_Currency_Fail", false)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Dare highlight vehicle", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local currentVehicleModel
  local goalConditionsMet = true
  local highlightedVehicles
  local inVehicleID = params.inVehicle
  local beenInZap = false
  if params.highlightList then
    highlightedVehicles = params.highlightList
  end
  local function turnOnHighlight()
    minimap.SetHighlightedVehicles(true)
    for index, modelID in next, highlightedVehicles, nil do
      local vehicles = {
        {VehicleModelUID = modelID}
      }
      minimap.AddHighlightedVehicleModelUIDs(vehicles)
    end
  end
  local turnOffHighlight = function()
    minimap.RemoveAllHighlightedVehicleModelUIDs()
    minimap.SetHighlightedVehicles(false)
  end
  turnOnHighlight()
  local function update()
    if localPlayer.inZap then
      beenInZap = true
      turnOnHighlight()
    elseif beenInZap and localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle.model_id == inVehicleID then
      beenInZap = false
      turnOffHighlight()
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local cleanup = function()
    minimap.RemoveAllHighlightedVehicleModelUIDs()
    minimap.SetHighlightedVehicles(false)
  end
  return update, cleanup
end)
local distInAirStunt = {
  stuntText = "ID:243808",
  stuntTextValue = nil,
  stuntSlotPass = nil,
  stuntFail = true
}
goalSystem.registerGoal("Dare distance travelled in air", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local distance = 0
  local previousValue = 0
  local correctCameraModeOnConditionStart = false
  local jumping = false
  local goalDistance = params.value
  scoringSystem.AddJumpScoringCallback = params.value or 1
  local startTotal = localPlayer.scoring:getTotalAirTimeDistance()
  local endTime
  local stillInPreGoalJump = false
  if localPlayer.scoring.isJumping then
    stillInPreGoalJump = true
  end
  local function conditionCheck()
    distance = localPlayer.scoring:getCurrentAirTimeDistance()
    if distance >= goalDistance and localPlayer.scoring:getTotalAirTimeDistance() >= startTotal + goalDistance then
      return true
    end
  end
  local function removeJumpStunt()
    if g_NetworkTime - endTime > 2 then
      removeUserUpdateFunction("removeJumpStunt")
      distInAirStunt.stuntHide = true
      feedbackSystem.updateStuntFeedback(distInAirStunt)
      distInAirStunt = {
        stuntText = "ID:243808",
        stuntTextValue = nil,
        stuntSlotPass = nil,
        stuntFail = true
      }
    end
  end
  local startDist = 0
  local function update()
    if stillInPreGoalJump then
      if localPlayer.scoring.isJumping then
        stillInPreGoalJump = false
      end
    else
      local goalConditionsMet = false
      if not jumping and localPlayer.scoring.isJumping then
        if params.inCameraMode and not correctCameraModeOnConditionStart then
          correctCameraModeOnConditionStart = isInCorrectCameraMode(params.inCameraMode)
        end
        startDist = localPlayer.scoring:getTotalAirTimeDistance()
        distInAirStunt.stuntFail = false
        distInAirStunt.stuntTextValue = distance
        distInAirStunt.stuntHide = false
        feedbackSystem.updateStuntFeedback(distInAirStunt)
        jumping = true
      end
      if not params.inCameraMode then
        goalConditionsMet = conditionCheck()
      elseif correctCameraModeOnConditionStart then
        if isInCorrectCameraMode(params.inCameraMode) then
          goalConditionsMet = conditionCheck()
        else
          distance = 0
          correctCameraModeOnConditionStart = false
        end
      end
      if jumping and not localPlayer.scoring.isJumping then
        local totalAirTimeOnLanding = localPlayer.scoring:getTotalAirTimeDistance()
        if startTotal ~= totalAirTimeOnLanding then
          startTotal = localPlayer.scoring:getTotalAirTimeDistance()
        else
          distance = 0
        end
        local endDist = localPlayer.scoring:getTotalAirTimeDistance() - startDist
        if endDist > 0 then
          distInAirStunt.stuntFail = true
          distInAirStunt.stuntTextValue = endDist
          feedbackSystem.updateStuntFeedback(distInAirStunt)
          endTime = g_NetworkTime
          addUserUpdateFunction("removeJumpStunt", removeJumpStunt, 4)
        end
        if endDist < goalDistance then
          OneShotSound.Play("HUD_Gen_Currency_Fail", false)
        end
        correctCameraModeOnConditionStart = false
        jumping = false
      end
      if feedback then
        if localPlayer.scoring.isJumping then
          scoringSystem.SetDareJumpBarProgression(localPlayer.localID, true, goalDistance, true)
          scoringSystem.UpdateJumpStuntText = true
        else
          feedback(0)
        end
      end
      if goalConditionsMet and not goalReportedSuccessful then
        OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
        distInAirStunt.stuntSlotPass = 2
        distInAirStunt.stuntFail = false
        feedbackSystem.updateStuntFeedback(distInAirStunt)
        scoringSystem.SetDareJumpBarProgression(localPlayer.localID, false, goalDistance, true)
        scoringSystem.UpdateJumpStuntText = false
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = true
      elseif not goalConditionsMet and goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = false
      end
    end
  end
  local function cleanup()
    if not goalConditionsMet and jumping then
      OneShotSound.Play("HUD_Gen_Currency_Fail", false)
    end
    scoringSystem.SetDareJumpBarProgression(localPlayer.localID, false, goalDistance, true)
    scoringSystem.UpdateJumpStuntText = false
    distInAirStunt.stuntFail = true
    distInAirStunt = {
      stuntHide = true,
      stuntText = "ID:243808",
      stuntTextValue = nil,
      stuntSlotPass = nil,
      stuntFail = true
    }
    feedbackSystem.updateStuntFeedback(distInAirStunt)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Jump x times in y time", function(operandA, operandB, UID, params, feedback)
  local jumpsRequired = params.value
  local jumpCount = 0
  local lastJumpState = localPlayer.scoring.isJumping
  local pointsParams = {
    pointsText = "+" .. tostring(1),
    pointsSlotPass = 2
  }
  return function()
    local goalConditionsMet = false
    if params.transition == "landing" and lastJumpState and not localPlayer.scoring.isJumping then
      jumpCount = jumpCount + 1
      if params.centralFeedback then
        OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
        feedbackSystem.updatePointsFeedback(pointsParams)
      end
    end
    lastJumpState = localPlayer.scoring.isJumping
    if feedback then
      feedback(jumpCount)
    end
    if jumpCount >= jumpsRequired then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Dare same vehicle", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local dareVehicle
  local function checkForInitialVehicle()
    if localPlayer.currentVehicle then
      dareVehicle = localPlayer.currentVehicle.gameVehicle
    end
  end
  checkForInitialVehicle()
  return function()
    local goalConditionsMet = false
    if not dareVehicle then
      checkForInitialVehicle()
    end
    if dareVehicle then
      if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle ~= dareVehicle then
        goalConditionsMet = false
        checkForInitialVehicle()
      else
        goalConditionsMet = true
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
local jumpInTimeStunt = {
  stuntText = "ID:243808",
  stuntTextValue = nil,
  stuntSlotPass = nil,
  stuntFail = true
}
goalSystem.registerGoal("Dare distance jumped in time", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local challengeDistance = 0
  local previousValue = 0
  local distanceNeeded = params.value
  local timeAllowance = params.timer
  local distanceJumped = {}
  local toDelete = {}
  local currentDistance = localPlayer.scoring:getTotalAirTimeDistance()
  local previousDistance = localPlayer.scoring:getTotalAirTimeDistance()
  local networkTime
  local previousNetworkTime = 0
  local delay = 1
  local needToDelete = false
  local startDist = localPlayer.scoring:getTotalAirTimeDistance()
  scoringSystem.UpdateJumpStuntText = true
  local function maintainTable()
    challengeDistance = 0
    for i, data in ipairs(distanceJumped) do
      if networkTime > data.time + timeAllowance then
        table.insert(toDelete, i, true)
        needToDelete = true
      else
        challengeDistance = challengeDistance + data.distance
      end
    end
    if needToDelete then
      for k, v in next, toDelete, nil do
        table.remove(distanceJumped, k)
      end
      needToDelete = false
      toDelete = {}
      scoringSystem.UpdateJumpStuntText = true
    end
    if feedback and previousValue ~= challengeDistance then
      feedback(challengeDistance)
      previousValue = challengeDistance
    end
  end
  local function update()
    local goalConditionsMet = false
    networkTime = g_NetworkTime
    currentDistance = localPlayer.scoring:getTotalAirTimeDistance()
    if currentDistance ~= previousDistance then
      table.insert(distanceJumped, {
        time = g_NetworkTime,
        distance = currentDistance - previousDistance
      })
      maintainTable()
      previousNetworkTime = networkTime
      previousDistance = currentDistance
    end
    if not jumping and localPlayer.scoring.isJumping then
      startDist = localPlayer.scoring:getTotalAirTimeDistance()
      jumping = true
    elseif jumping and not localPlayer.scoring.isJumping then
      if localPlayer.scoring:getTotalAirTimeDistance() - startDist >= 1 then
        jumpInTimeStunt.stuntSlotPass = 2
        jumpInTimeStunt.stuntFail = false
        jumpInTimeStunt.stuntTextValue = localPlayer.scoring:getTotalAirTimeDistance() - startDist
        jumpInTimeStunt.stuntHide = false
        feedbackSystem.updateStuntFeedback(jumpInTimeStunt)
        jumpInTimeStunt.stuntSlotPass = nil
        OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
      end
      jumping = false
    end
    if networkTime >= previousNetworkTime + delay then
      maintainTable()
      previousNetworkTime = networkTime
    end
    if challengeDistance >= distanceNeeded then
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
      scoringSystem.UpdateJumpStuntText = false
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    if not goalConditionsMet and jumping then
      OneShotSound.Play("HUD_Gen_Currency_Fail", false)
    end
    scoringSystem.UpdateJumpStuntText = false
    jumpInTimeStunt.stuntSlotPass = nil
    jumpInTimeStunt.stuntFail = true
    jumpInTimeStunt = {
      stuntHide = true,
      stuntText = "ID:243808",
      stuntTextValue = nil,
      stuntSlotPass = nil,
      stuntFail = true
    }
    feedbackSystem.updateStuntFeedback(jumpInTimeStunt)
    removeUserUpdateFunction("failedJump")
  end
  return update, cleanup
end)
local driftStunt = {
  stuntText = "ID:245410",
  stuntTextValue = nil,
  stuntSlotPass = nil,
  stuntFail = true
}
goalSystem.registerGoal("Dare distance travelled in drift", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local distance = 0
  local startTotal = localPlayer.scoring:getTotalDriftDistance()
  local goalDistance = params.value
  scoringSystem.AddDriftScoringCallback = params.value or 1
  scoringSystem.UpdateDriftStuntText = false
  localPlayer.scoring.currentDriftDistance = 0
  local endTime
  local driftDistance = 0
  local drifting = false
  local updateProgress = false
  local inZap = localPlayer.inZap
  local updating = false
  local highlightedVehicles
  local highlightOn = false
  local requiredModel = params.requiredModel
  local stillInPreGoalDrift = false
  if localPlayer.scoring.isDrifting then
    stillInPreGoalDrift = true
  end
  local function removeDriftStunt()
    if g_NetworkTime - endTime > 2 then
      removeUserUpdateFunction("removeDriftStunt")
      driftStunt.stuntHide = true
      feedbackSystem.updateStuntFeedback(driftStunt)
      driftStunt = {
        stuntText = "ID:245410",
        stuntTextValue = nil,
        stuntSlotPass = nil,
        stuntFail = true
      }
    end
  end
  local function failDrift()
    OneShotSound.Play("HUD_Gen_Currency_Fail", false)
    driftStunt.stuntFail = true
    driftStunt.stuntTextValue = driftDistance
    feedbackSystem.updateStuntFeedback(driftStunt)
    endTime = g_NetworkTime
    addUserUpdateFunction("removeDriftStunt", removeDriftStunt, 4)
  end
  local function updateDrift()
    driftStunt.stuntFail = false
    driftStunt.stuntTextValue = driftDistance
    driftStunt.stuntHide = false
    feedbackSystem.updateStuntFeedback(driftStunt)
  end
  local function turnOnHighlight()
    highlightOn = true
    if params.highlight then
      minimap.SetHighlightedVehicles(true)
      highlightedVehicles = params.requiredModel
      for index, modelID in next, highlightedVehicles, nil do
        local vehicles = {
          {VehicleModelUID = modelID}
        }
        minimap.AddHighlightedVehicleModelUIDs(vehicles)
      end
    end
  end
  local function turnOffHighlight()
    highlightOn = false
    if params.highlight then
      minimap.RemoveAllHighlightedVehicleModelUIDs()
      minimap.SetHighlightedVehicles(false)
    end
  end
  local function update()
    if params.highlight then
      if localPlayer.inZap and not highlightOn then
        turnOnHighlight()
      elseif localPlayer.currentVehicle and not localPlayer.inZap then
        local vehicleModel = localPlayer.currentVehicle.model_id
        local inRequiredVehicle = false
        if vehicleModel then
          for k, v in next, requiredModel, nil do
            if v == vehicleModel then
              inRequiredVehicle = true
              break
            end
          end
          if inRequiredVehicle and highlightOn then
            turnOffHighlight()
          elseif not inRequiredVehicle and not highlightOn then
            turnOnHighlight()
          end
        end
      end
    end
    local goalConditionsMet = false
    if params.requiredModel == nil or params.requiredModel ~= nil and not highlightOn then
      if stillInPreGoalDrift then
        if localPlayer.scoring.isDrifting then
          stillInPreGoalDrift = false
        end
      else
        driftDistance = localPlayer.scoring:getCurrentDriftDistance()
        if localPlayer.scoring.isDrifting and not drifting then
          scoringSystem.UpdateDriftStuntText = true
          drifting = true
          updateProgress = true
          driftDistance = 0
        elseif drifting and not localPlayer.scoring.isDrifting then
          drifting = false
          updateProgress = false
          if driftDistance >= goalDistance then
            goalConditionsMet = true
          else
            failDrift()
          end
        end
        if localPlayer.inZap and not inZap then
          inZap = true
          updateProgress = false
          if drifting or localPlayer.scoring.isDrifting then
            failDrift()
          end
        elseif inZap and not localPlayer.inZap then
          inZap = false
          updateProgress = false
          driftStunt.stuntHide = true
          driftStunt.stuntFail = true
          feedbackSystem.updateStuntFeedback(driftStunt)
          driftStunt = {
            stuntText = "ID:245410",
            stuntTextValue = nil,
            stuntSlotPass = nil,
            stuntFail = true
          }
        end
        if updateProgress then
          if not updating then
            scoringSystem.SetDareDriftBarProgression(localPlayer.localID, true, goalDistance)
            updateDrift()
          end
          updating = true
        else
          if updating then
            scoringSystem.SetDareDriftBarProgression(localPlayer.localID, false, goalDistance)
          end
          if feedback then
            feedback(0)
          end
          updating = false
        end
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
      driftStunt.stuntTextValue = goalDistance
      driftStunt.stuntSlotPass = 2
      driftStunt.stuntFail = false
      feedbackSystem.updateStuntFeedback(driftStunt)
      scoringSystem.SetDareDriftBarProgression(localPlayer.localID, false, goalDistance)
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
      scoreSystem.RemoveDriftScoringCallback = goalDistance
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    if not goalConditionsMet and drifting then
      OneShotSound.Play("HUD_Gen_Currency_Fail", false)
    end
    scoringSystem.UpdateDriftStuntText = false
    driftStunt.stuntFail = true
    driftStunt = {
      stuntHide = true,
      stuntText = "ID:245410",
      stuntTextValue = nil,
      stuntSlotPass = nil,
      stuntFail = true
    }
    feedbackSystem.updateStuntFeedback(driftStunt)
    scoringSystem.SetDareDriftBarProgression(localPlayer.localID, false, goalDistance)
    if params.highlight then
      turnOffHighlight()
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Dare number of props smashed", function(operandA, operandB, UID, params, feedback)
  local props = props or 0
  local tableOfTargets = not tableOfTargets and {}
  local smashWatchAdded = false
  local playerVehicle
  local function propFindCallback(context, instance, region, lo, hi, vector)
    local target = Marker:create({
      type = "World",
      gadgetID = 75,
      radius = 100,
      visible = true,
      facing = true,
      colour = vec.vector(255, 255, 255, 255),
      position = vector + vec.vector(0, 4, 0, 0)
    })
    tableOfTargets[props] = {}
    tableOfTargets[props].target = target
    tableOfTargets[props].instance = instance
    tableOfTargets[props].region = region
    printTable(tableOfTargets)
    props = props + 1
    if context == 0 and props >= 10 then
      return false
    end
    return true
  end
  local goalReportedSuccessful = false
  local targetNumber = params.value
  local pointsParams = {
    pointsText = "+" .. tostring(1),
    pointsSlotPass = 2
  }
  local numberHit = 0
  local prevNumberHit = 0
  local networkTime, previousNetworkTime, timeAllowance, allowed, delay
  local propsSmashed = {}
  if params.timer then
    previousNetworkTime = 0
    timeAllowance = params.timer
    delay = 1
  end
  local function propSmashCallback(context, gameVehicle, instance, region, lo, hi, vec)
    allowed = true
    if localPlayer.inZap or params.inCameraMode and not isInCorrectCameraMode(params.inCameraMode) or params.onlyAlleyProps and localPlayer.currentVehicle and Atlas.DoesRoadHaveDrivingLanes(localPlayer.currentVehicle:get_closestRoadIndex()) then
      allowed = false
    end
    if allowed and (not gameVehicle or localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle == gameVehicle) then
      numberHit = numberHit + 1
    end
    if params.highlightTargets then
      for k, v in next, tableOfTargets, nil do
        if v.instance == instance then
          Marker:delete(v.target)
          tableOfTargets[k] = nil
          break
        end
      end
    end
  end
  if not goalReportedSuccessful then
    if params.propData then
      if propType[params.propData.name] then
        PropSystem.AddWatch(propSmashCallback, {
          name = params.propData.name
        })
        smashWatchAdded = true
        if params.highlightTargets then
          PropSystem.FindStaticProps(propFindCallback, {
            context = 1,
            name = params.propData.name,
            position = localPlayer.position,
            radius = 1000
          })
        end
      elseif propGroup[params.propData.name] then
        for k, v in next, propGroup[params.propData.name], nil do
          PropSystem.AddWatch(propSmashCallback, {name = v})
          smashWatchAdded = true
          if params.highlightTargets then
            PropSystem.FindStaticProps(propFindCallback, {
              context = 1,
              name = v,
              position = localPlayer.position,
              radius = 1000
            })
          end
        end
      end
    else
      PropSystem.AddWatch(propSmashCallback)
      smashWatchAdded = true
    end
  end
  local function update()
    networkTime = g_NetworkTime
    local goalConditionsMet = false
    if params.inCameraMode then
      local showIt = true
      if isInCorrectCameraMode(params.inCameraMode) then
        showIt = false
      end
      if localPlayer.inZap then
        showIt = false
      end
      if showIt then
        if not feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:236453", false, false, true, false, localPlayer.buttonLayout.changeCamera)
        end
      elseif feedbackSystem.menusMaster.primaryPromptActive then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      end
    end
    if numberHit > prevNumberHit then
      if not params.disableFeedback then
        OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
        feedbackSystem.updatePointsFeedback(pointsParams)
      end
      if params.value then
        if numberHit >= targetNumber then
          goalConditionsMet = true
        end
      else
        goalConditionsMet = true
      end
      if feedback then
        feedback(numberHit)
      end
      prevNumberHit = numberHit
    end
    if goalConditionsMet and not goalReportedSuccessful then
      if params.highlightTargets then
        for i, target in next, tableOfTargets, nil do
          Marker:delete(target.target)
        end
        props = 0
        tableOfTargets = {}
      end
      goalSystem.callbackHandler(UID, params.score)
      goalReportedSuccessful = true
      PropSystem.RemoveWatch(propSmashCallback)
      smashWatchAdded = false
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID, params.score)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    if params.highlightTargets then
      for k, v in next, tableOfTargets, nil do
        Marker:delete(v.target)
      end
      props = 0
      tableOfTargets = {}
    end
    if smashWatchAdded then
      PropSystem.RemoveWatch(propSmashCallback)
      smashWatchAdded = false
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Get x vehicles above y mph", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local numberRequired = params.value
  local speedRequired = params.speed
  local vehicleType = params.inVehicleID
  local vehicleHasBeenUsed = false
  local isCorrectVehicleType = false
  local lastPlayerVehicle = localPlayer.currentVehicle
  local currentCountXX = 0
  local vehiclesUsedXX = {}
  local totalCount = 0
  local timeRecords = {}
  local timeAllowance = params.timer
  local delay = 1
  local previousNetworkTime = 0
  local pointsParams = {
    pointsText = "+" .. tostring(1),
    pointsSlotPass = 2
  }
  local function maintainTable()
    for k, v in next, timeRecords, nil do
      if g_NetworkTime > v + timeAllowance then
        table.remove(timeRecords, i)
        currentCountXX = math.ceil(currentCountXX - 1, 0)
        if currentCountXX == 0 and vehiclesUsedXX[localPlayer.currentVehicle] then
          vehiclesUsedXX[localPlayer.currentVehicle] = nil
        end
        if feedback then
          feedback(currentCountXX)
        end
      end
    end
  end
  return function()
    if localPlayer.currentVehicle then
      vehicleHasBeenUsed = false
      if vehiclesUsedXX[localPlayer.currentVehicle.gameVehicle] then
        vehicleHasBeenUsed = true
      end
      isCorrectVehicleType = false
      if vehicleType then
        for k, v in next, vehicleType, nil do
          if v == localPlayer.currentVehicle.gameVehicle.model_id then
            isCorrectVehicleType = true
          end
        end
      else
        isCorrectVehicleType = true
      end
      networkTime = g_NetworkTime
      if localPlayer.currentVehicle then
        local speed
        if params.displayed then
          speed = localPlayer.currentVehicle.gameVehicle.displayedSpeed
        else
          speed = localPlayer.currentVehicle.speed
        end
        speed = speed * 2.236
        if speed >= speedRequired and vehicleHasBeenUsed == false and isCorrectVehicleType == true then
          OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
          feedbackSystem.updatePointsFeedback(pointsParams)
          currentCountXX = currentCountXX + 1
          vehiclesUsedXX[localPlayer.currentVehicle.gameVehicle] = true
          table.insert(timeRecords, networkTime)
          previousNetworkTime = networkTime
          if feedback then
            feedback(currentCountXX)
          end
        end
        if networkTime >= previousNetworkTime + delay and timeAllowance then
          maintainTable()
          previousNetworkTime = networkTime
        end
      end
      local goalConditionsMet = false
      if currentCountXX >= numberRequired then
        goalConditionsMet = true
      end
      if goalConditionsMet and not goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = true
      elseif not goalConditionsMet and goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = false
      end
    end
  end
end)
goalSystem.registerGoal("Tag x number of y vehicle", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local vehiclesHit = {}
  local times = {}
  local lastPlayerVehicle = false
  local newHit = false
  local addTo = false
  local vehicle, highlightedVehicles
  local pointsParams = {
    pointsText = "+" .. tostring(1),
    pointsSlotPass = 2
  }
  local previousVehicleTowing
  if params.highlight then
    minimap.SetHighlightedVehicles(true)
    if params.inVehicleID then
      highlightedVehicles = params.inVehicleID
    elseif params.vehicleID then
      localPlayer.minimapSupport.setHighlightedVehicleModelType("smash")
      highlightedVehicles = params.vehicleID
    end
    for index, modelID in next, highlightedVehicles, nil do
      local vehicles = {
        {VehicleModelUID = modelID}
      }
      minimap.AddHighlightedVehicleModelUIDs(vehicles)
    end
  end
  local function collisionCheck(collisionData)
    local willCount = false
    if collisionData.CollidedGameVehicle then
      if params.vehicleID then
        for k, v in next, params.vehicleID, nil do
          if collisionData.CollidedGameVehicle.model_id == v then
            willCount = true
            break
          end
        end
      end
      if not params.inVehicleID and not params.vehicleID then
        willCount = true
      end
      if willCount then
        newHit = true
        vehicle = collisionData.CollidedGameVehicle
      end
      if willCount and params.highlight then
        minimap.AddVehicleToExcludeFromHighlights(collisionData.CollidedGameVehicle)
      end
    end
  end
  local function collisionCheckTrailer(collisionData)
    if collisionData.CollidedGameVehicle then
      local willCount = false
      if params.vehicleID then
        for k, v in next, params.vehicleID, nil do
          if collisionData.CollidedGameVehicle.model_id == v then
            willCount = true
            break
          end
        end
      end
      if not params.inVehicleID and not params.vehicleID then
        willCount = true
      end
      if willCount then
        newHit = true
        vehicle = collisionData.CollidedGameVehicle
      end
      if willCount and params.highlight then
        minimap.AddVehicleToExcludeFromHighlights(collisionData.CollidedGameVehicle)
      end
    end
  end
  local callbackSettings = {
    callbackFunction = collisionCheck,
    minimumForce = 1000,
    typeOfHit = "Vehicle"
  }
  local callbackSettingsTrailer = {
    callbackFunction = collisionCheckTrailer,
    minimumForce = 1000,
    typeOfHit = "Vehicle"
  }
  local function update()
    if localPlayer.currentVehicle then
      if lastPlayerVehicle ~= localPlayer.currentVehicle then
        if lastPlayerVehicle then
          lastPlayerVehicle:removeCollisionCallback(callbackSettings)
        end
        localPlayer.currentVehicle:addCollisionCallback(callbackSettings)
        lastPlayerVehicle = localPlayer.currentVehicle
        if previousVehicleTowing then
          GameVehicleResource.UnRegisterCollisionCallback(callbackSettingsTrailer)
        end
        if localPlayer.currentVehicle.gameVehicle.isTowing then
          callbackSettingsTrailer.gameVehicle = localPlayer.currentVehicle.gameVehicle.childVehicle
          GameVehicleResource.RegisterCollisionCallback(callbackSettingsTrailer)
          previousVehicleTowing = true
        else
          previousVehicleTowing = false
        end
      end
      if newHit then
        newHit = false
        addTo = true
        for k, v in next, vehiclesHit, nil do
          if vehicle == v then
            addTo = false
            break
          end
        end
        if addTo then
          if params.centralFeedback then
            OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
            feedbackSystem.updatePointsFeedback(pointsParams)
          end
          if params.timer then
            table.insert(times, g_NetworkTime)
          end
          table.insert(vehiclesHit, vehicle)
          addTo = false
        end
        feedback(#vehiclesHit)
      end
      if params.timer then
        for k, v in next, times, nil do
          if g_NetworkTime - v > params.timer then
            table.remove(vehiclesHit, k)
            table.remove(times, k)
            feedback(#vehiclesHit)
          end
        end
      end
      if #vehiclesHit >= params.value then
        goalConditionsMet = true
      end
      if goalConditionsMet and not goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = true
      elseif not goalConditionsMet and goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = false
      end
    end
  end
  local function cleanup()
    minimap.RemoveAllHighlightedVehicleModelUIDs()
    minimap.SetHighlightedVehicles(false)
    localPlayer.minimapSupport.setHighlightedVehicleModelType("exclamationMark")
    if lastPlayerVehicle then
      lastPlayerVehicle:removeCollisionCallback(callbackSettings)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Dare is player in vehicle model", function(operandA, operandB, UID, params)
  local goalReportedSuccessful = false
  local vehicleModel
  local requiredModel = params.value
  local goalConditionsMet = false
  local listOfVehicle, highlightedVehicles
  listOfVehicle = requiredModel and type(requiredModel) == "table"
  local function turnOnHighlight()
    if params.highlight then
      minimap.SetHighlightedVehicles(true)
      if params.inVehicleID then
        highlightedVehicles = params.inVehicleID
      elseif params.vehicleID then
        highlightedVehicles = params.vehicleID
      end
      for index, modelID in next, highlightedVehicles, nil do
        local vehicles = {
          {VehicleModelUID = modelID}
        }
        minimap.AddHighlightedVehicleModelUIDs(vehicles)
      end
    end
  end
  local function turnOffHighlight()
    if params.highlight then
      minimap.RemoveAllHighlightedVehicleModelUIDs()
      minimap.SetHighlightedVehicles(false)
    end
  end
  turnOnHighlight()
  local function update()
    goalConditionsMet = false
    if localPlayer.currentVehicle and (not localPlayer.inZap or params.allowZap) then
      if localPlayer.currentVehicle then
        vehicleModel = localPlayer.currentVehicle.model_id
      end
      if vehicleModel then
        if listOfVehicle then
          for k, v in next, requiredModel, nil do
            if v == vehicleModel then
              goalConditionsMet = true
              break
            end
          end
        elseif vehicleModel == requiredModel then
          goalConditionsMet = true
        end
      end
    end
    if params.highlight then
      if localPlayer.inZap then
        turnOnHighlight()
      elseif goalConditionsMet then
        turnOffHighlight()
      end
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      turnOffHighlight()
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      turnOnHighlight()
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local cleanup = function()
    minimap.RemoveAllHighlightedVehicleModelUIDs()
    minimap.SetHighlightedVehicles(false)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Player in x vehicle and jumped off y vehicle z times", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local vehicleModel
  local requiredModel = params.inVehicleID
  local goalConditionsMet = false
  local listOfVehicle, highlightedVehicles
  local turnOnHighlight = true
  local timeAllowance = params.timer
  local previousNetworkTime = 0
  local delay = 1
  local count = 0
  localPlayer.scoring.setMinimumJumpOffRelativeSpeed(10)
  local vehiclesJumped = {}
  local highlight
  local previouslyInZap = localPlayer.inZap
  local pointsParams = {
    pointsText = "+" .. tostring(1),
    pointsSlotPass = 2
  }
  local vehiclesToExclude = {}
  local previouslyHighlighted
  listOfVehicle = requiredModel and type(requiredModel) == "table"
  local function turnOnHighlight()
    if params.highlight then
      if previouslyHighlighted ~= nil and highlight ~= nil and previouslyHighlighted ~= highlight then
        minimap.RemoveAllHighlightedVehicleModelUIDs()
        minimap.SetHighlightedVehicles(false)
      end
      minimap.SetHighlightedVehicles(true)
      if highlight == "inVehicle" and params.inVehicleID then
        previouslyHighlighted = "inVehicle"
        highlightedVehicles = params.inVehicleID
      elseif highlight == "vehicle" and params.vehicleID then
        previouslyHighlighted = "vehicle"
        highlightedVehicles = params.vehicleID
      end
      for index, modelID in next, highlightedVehicles, nil do
        local vehicles = {
          {VehicleModelUID = modelID}
        }
        minimap.AddHighlightedVehicleModelUIDs(vehicles)
      end
      for gameVeh, _ in next, vehiclesToExclude, nil do
        minimap.AddVehicleToExcludeFromHighlights(gameVeh)
      end
    end
  end
  local function updateHighlight()
    if localPlayer.inZap then
      highlight = "inVehicle"
      turnOnHighlight()
    elseif localPlayer.currentVehicle and not localPlayer.inZap then
      vehicleModel = localPlayer.currentVehicle.model_id
      if vehicleModel then
        if vehiclesJumped and vehiclesJumped[localPlayer.currentVehicle.gameVehicle] then
          highlight = "inVehicle"
        else
          highlight = "inVehicle"
          for k, v in next, requiredModel, nil do
            if v == vehicleModel then
              highlight = "vehicle"
              break
            end
          end
        end
        turnOnHighlight()
      end
    end
  end
  local function checkZap()
    if previouslyInZap ~= localPlayer.inZap then
      updateHighlight()
    end
    previouslyInZap = localPlayer.inZap
  end
  updateHighlight()
  local function maintainTable()
    for k, time in next, vehiclesJumped, nil do
      if g_NetworkTime > time + timeAllowance then
        vehiclesJumped[k] = nil
      end
    end
    count = 0
    for k, v in next, vehiclesJumped, nil do
      count = count + 1
    end
  end
  local function removeGameVehiclesFromTable(gameVehicle)
    vehiclesToExclude[gameVehicle] = nil
  end
  local function jumped(jumpInfo)
    local allowed = true
    if params.vehicleID then
      allowed = false
      for k, v in next, params.vehicleID, nil do
        if v == jumpInfo.VehicleID then
          allowed = true
          break
        end
      end
    end
    if allowed and params.inVehicleID then
      allowed = false
      for k, v in next, params.inVehicleID, nil do
        if v == localPlayer.currentVehicle.gameVehicle.model_id then
          allowed = true
          break
        end
      end
    end
    if allowed and not vehiclesJumped[localPlayer.currentVehicle.gameVehicle] then
      local id = localPlayer.currentVehicle.gameVehicle
      vehiclesJumped[id] = g_NetworkTime
      vehiclesToExclude[id] = g_NetworkTime
      highlight = "inVehicle"
      turnOnHighlight()
      GameVehicleResource.RegisterDeletionCallback(localPlayer.currentVehicle.gameVehicle, removeGameVehiclesFromTable)
      count = 0
      for k, v in next, vehiclesJumped, nil do
        count = count + 1
      end
      if params.centralFeedback then
        OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
        feedbackSystem.updatePointsFeedback(pointsParams)
      end
    end
  end
  localPlayer.scoring.registerJumpOffVehicleCallback(jumped)
  local function update()
    checkZap()
    if localPlayer.currentVehicle then
      if feedback then
        feedback(count)
      end
      if timeAllowance and g_NetworkTime >= previousNetworkTime + delay then
        maintainTable()
        previousNetworkTime = g_NetworkTime
      end
      goalConditionsMet = count >= (params.value or 1)
      if goalConditionsMet and not goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = true
      elseif not goalConditionsMet and goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = false
      end
    end
  end
  local function cleanup()
    minimap.RemoveAllHighlightedVehicleModelUIDs()
    minimap.SetHighlightedVehicles(false)
    localPlayer.scoring.unregisterJumpOffVehicleCallback(jumped)
    for gameVeh, _ in next, vehiclesToExclude, nil do
      GameVehicleResource.UnRegisterDeletionCallback(gameVeh, removeGameVehiclesFromTable)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Stay above x mph for y seconds", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local inSpeedStunt = {
    stuntText = "ID:242735",
    stuntTextValue = nil,
    stuntHide = false,
    stuntSlotPass = nil,
    stuntFail = nil
  }
  local requiredTime = params.value
  local requiredSpeed = params.speed
  local startTime, currentSpeed, currentSpeedInMph
  local startedToSlowdown = false
  local timerCheck = false
  local timeOfSlowdown = 0
  local speedDifference, aboveSpeed
  local previousSpeed = 300
  local failing = false
  local disappearTime = 1
  local function updateSpeedBar()
    if not startedToSlowdown and speedDifference >= 0.15 then
      startedToSlowdown = true
      timerCheck = true
      timeOfSlowdown = g_NetworkTime
    elseif startedToSlowdown and speedDifference <= -0.15 then
      startedToSlowdown = false
      inSpeedStunt.stuntFail = false
      inSpeedStunt.stuntHide = false
      timerCheck = false
      disappearTime = 1
    end
    if timerCheck and g_NetworkTime - timeOfSlowdown >= disappearTime then
      inSpeedStunt.stuntHide = true
      timerCheck = false
      inSpeedStunt.stuntFail = false
      disappearTime = 1
    end
    inSpeedStunt.stuntTextValue = feedbackSystem.localiseSpeedFromMetersASecond(currentSpeed)
    feedbackSystem.updateStuntFeedback(inSpeedStunt)
  end
  local function setSpeedInMph()
    if localPlayer.currentVehicle and not localPlayer.inZap then
      currentSpeed = localPlayer.currentVehicle.gameVehicle.displayedSpeed
      currentSpeedInMph = math.floor(currentSpeed * 2.236)
      speedDifference = previousSpeed - currentSpeedInMph
    end
  end
  local function checkSpeed()
    setSpeedInMph()
    if requiredSpeed and currentSpeedInMph and currentSpeedInMph <= requiredSpeed then
      aboveSpeed = false
    elseif requiredSpeed and currentSpeedInMph and currentSpeedInMph > requiredSpeed then
      aboveSpeed = true
    end
  end
  checkSpeed()
  local function update()
    if localPlayer.currentVehicle and not localPlayer.inZap then
      checkSpeed()
      if aboveSpeed then
        if not startTime then
          startTime = g_NetworkTime
          inSpeedStunt.stuntHide = true
          feedbackSystem.updateStuntFeedback(inSpeedStunt)
        end
        elapsedTime = g_NetworkTime - startTime
        if feedback then
          feedback(elapsedTime)
        end
        if elapsedTime >= requiredTime then
          goalConditionsMet = true
          OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
        end
      else
        if startTime then
          startTime = nil
          OneShotSound.Play("HUD_Gen_Currency_Fail", false)
          inSpeedStunt.stuntFail = true
          inSpeedStunt.stuntHide = false
          disappearTime = 2
        end
        if currentSpeedInMph > 0 and not feedbackSystem.menusMaster.primaryPromptActive then
          updateSpeedBar()
        end
        if feedback then
          feedback(0)
        end
      end
      if speedDifference >= 0.15 or speedDifference <= -0.15 then
        previousSpeed = currentSpeedInMph
      end
      if goalConditionsMet and not goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = true
      elseif not goalConditionsMet and goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = false
      end
    end
  end
  local function cleanup()
    if not goalConditionsMet and aboveSpeed then
      OneShotSound.Play("HUD_Gen_Currency_Fail", false)
    end
    inSpeedStunt.stuntHide = true
    feedbackSystem.updateStuntFeedback(inSpeedStunt)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Dare is towing above x speed", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local targetSpeed = params.value
  local towingFeedback = 0
  local speed, speedInMph
  local inSpeedStunt = {
    stuntText = "ID:242735",
    stuntTextValue = nil,
    stuntHide = false,
    stuntSlotPass = nil
  }
  local towTruckModel = 287
  local highlightOn = false
  local inZap = localPlayer.inZap
  local function isInTowTruck()
    if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle.model_id ~= towTruckModel then
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:246529", priority = 1})
      return false
    else
      return true
    end
  end
  local function turnOnHighlight()
    highlightOn = true
    minimap.SetHighlightedVehicles(true)
    local vehicles = {
      {VehicleModelUID = towTruckModel}
    }
    minimap.AddHighlightedVehicleModelUIDs(vehicles)
  end
  local function turnOffHighlight()
    highlightOn = false
    minimap.RemoveAllHighlightedVehicleModelUIDs()
    minimap.SetHighlightedVehicles(false)
  end
  if localPlayer.inZap or not localPlayer.inZap and not isInTowTruck() then
    turnOnHighlight()
  end
  local function update()
    goalConditionsMet = false
    if localPlayer.inZap and not inZap then
      if not highlightOn then
        turnOnHighlight()
      end
      inZap = true
    elseif inZap and not localPlayer.inZap then
      if localPlayer.currentVehicle then
        if isInTowTruck() and highlightOn then
          turnOffHighlight()
        elseif not isInTowTruck() and not highlightOn then
          turnOnHighlight()
        end
      end
      inZap = false
    end
    if localPlayer.currentVehicle then
      if params.displayed then
        speed = localPlayer.currentVehicle.gameVehicle.displayedSpeed
      else
        speed = localPlayer.currentVehicle.speed
      end
      speedInMph = speed * 2.236
    else
      speed = nil
    end
    if localPlayer.currentVehicle and not localPlayer.inZap and localPlayer.currentVehicle.model_id == 287 and localPlayer.currentVehicle.isTowing then
      towingFeedback = speedInMph
      if speedInMph >= targetSpeed then
        goalConditionsMet = true
        OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
        inSpeedStunt.stuntHide = false
        inSpeedStunt.stuntTextValue = params.targetDisplaySpeed
        inSpeedStunt.stuntSlotPass = 2
        feedbackSystem.updateStuntFeedback(inSpeedStunt)
      elseif params.showSpeed then
        inSpeedStunt.stuntHide = false
        inSpeedStunt.stuntTextValue = feedbackSystem.localiseSpeedFromMetersASecond(speed)
        feedbackSystem.updateStuntFeedback(inSpeedStunt)
      end
    else
      inSpeedStunt.stuntHide = true
      feedbackSystem.updateStuntFeedback(inSpeedStunt)
      towingFeedback = 0
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if feedback then
      feedback(towingFeedback)
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    minimap.RemoveAllHighlightedVehicleModelUIDs()
    minimap.SetHighlightedVehicles(false)
    inSpeedStunt.stuntHide = true
    feedbackSystem.updateStuntFeedback(inSpeedStunt)
    towingFeedback = 0
  end
  return update, cleanup
end)
local distanceStunt = {
  stuntText = "ID:242923",
  stuntTextValue = nil,
  stuntSlotPass = nil,
  stuntFail = true
}
goalSystem.registerGoal("Player driven X metres", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  local distance = 0
  local frame = 0
  local correctCameraModeOnConditionStart = false
  local lastLocation
  local pastDistances = {}
  local currentGameVehicle
  local cumulativeDistanceForUpdate = 0
  local function conditionCheck()
    if localPlayer.currentVehicle then
      local subDistance = workingVector:sub(localPlayer.currentVehicle.position, lastLocation):length()
      distance = distance + subDistance
      cumulativeDistanceForUpdate = cumulativeDistanceForUpdate + subDistance
      frame = frame + 1
      lastLocation.x = localPlayer.currentVehicle.position.x
      lastLocation.y = localPlayer.currentVehicle.position.y
      lastLocation.z = localPlayer.currentVehicle.position.z
      if params.timer and frame == 20 then
        frame = 0
        local subPosition = {timer = g_NetworkTime, distance = cumulativeDistanceForUpdate}
        table.insert(pastDistances, subPosition)
        cumulativeDistanceForUpdate = 0
        for k, v in ripairs(pastDistances) do
          if v.timer < g_NetworkTime - params.timer then
            distance = distance - v.distance
            table.remove(pastDistances, k)
          end
        end
      end
      if distance >= params.value then
        return true
      end
    end
  end
  local function removeDistanceStunt()
    if g_NetworkTime - endTime > 2 then
      removeUserUpdateFunction("removeDistanceStunt")
      distanceStunt.stuntHide = true
      feedbackSystem.updateStuntFeedback(distanceStunt)
      distanceStunt = {
        stuntText = "ID:242923",
        stuntTextValue = nil,
        stuntSlotPass = nil,
        stuntFail = true
      }
    end
  end
  local failDistanceSet = false
  local function update()
    goalConditionsMet = false
    if localPlayer.currentVehicle and params.feedbackDistance and params.button == "Vehicle_HandBrake" then
      local downButtonStatus = controlHandler:getStatus(params.button)
      if lastLocation and downButtonStatus == "Pressed" and workingVector:sub(localPlayer.currentVehicle.position, lastLocation):length() > 0 then
        failDistanceSet = false
        distanceStunt.stuntFail = false
        distanceStunt.stuntTextValue = distance
        distanceStunt.stuntHide = false
        feedbackSystem.updateStuntFeedback(distanceStunt)
      end
    end
    if localPlayer.currentVehicle and (not lastLocation or currentGameVehicle ~= localPlayer.currentVehicle) then
      lastLocation = vec.vector()
      lastLocation.x = localPlayer.currentVehicle.position.x
      lastLocation.y = localPlayer.currentVehicle.position.y
      lastLocation.z = localPlayer.currentVehicle.position.z
      if params.inCameraMode then
        correctCameraModeOnConditionStart = isInCorrectCameraMode(params.inCameraMode)
      end
      currentGameVehicle = localPlayer.currentVehicle
    elseif not localPlayer.inZap then
      if not params.inCameraMode then
        goalConditionsMet = conditionCheck()
      elseif correctCameraModeOnConditionStart then
        if isInCorrectCameraMode(params.inCameraMode) then
          goalConditionsMet = conditionCheck()
        else
          cumulativeDistanceForUpdate = 0
          pastDistances = {}
          distance = 0
          correctCameraModeOnConditionStart = false
        end
      end
    end
    if feedback then
      feedback(distance)
    end
    if goalConditionsMet and not goalReportedSuccessful then
      OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
      if params.feedbackDistance then
        distanceStunt.stuntTextValue = params.value
        distanceStunt.stuntSlotPass = 2
        distanceStunt.stuntFail = false
        feedbackSystem.updateStuntFeedback(distanceStunt)
      end
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    if not goalConditionsMet then
      OneShotSound.Play("HUD_Gen_Currency_Fail", false)
    end
    if params.feedbackDistance then
      if goalConditionsMet then
        distanceStunt = {
          stuntText = "ID:242923",
          stuntTextValue = nil,
          stuntSlotPass = nil,
          stuntFail = true
        }
      else
        distanceStunt.stuntFail = true
        if not failDistanceSet then
          distanceStunt.stuntTextValue = distance
          failDistanceSet = true
        end
        feedbackSystem.updateStuntFeedback(distanceStunt)
        endTime = g_NetworkTime
        addUserUpdateFunction("removeDistanceStunt", removeDistanceStunt, 4)
      end
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Player hasn't had collision above x force (TEMP)", function(operandA, operandB, UID, params)
  local goalConditionsMet = true
  local goalReportedSuccessful = false
  local previousVehicle, previousVehicleTowing
  local function collisionCheck(collisionData)
    goalConditionsMet = false
  end
  local callbackSettings = {
    callbackFunction = collisionCheck,
    minimumForce = params.force,
    typeOfHit = params.typeOfHit
  }
  local callbackSettingsTrailer = {
    callbackFunction = collisionCheck,
    minimumForce = params.force,
    typeOfHit = params.typeOfHit
  }
  local function update()
    if localPlayer.currentVehicle and localPlayer.currentVehicle ~= previousVehicle then
      if previousVehicle then
        previousVehicle:removeCollisionCallback(callbackSettings)
      end
      localPlayer.currentVehicle:addCollisionCallback(callbackSettings)
      previousVehicle = localPlayer.currentVehicle
      if previousVehicleTowing then
        GameVehicleResource.UnRegisterCollisionCallback(callbackSettingsTrailer)
      end
      if localPlayer.currentVehicle.gameVehicle.isTowing then
        callbackSettingsTrailer.gameVehicle = localPlayer.currentVehicle.gameVehicle.childVehicle
        GameVehicleResource.RegisterCollisionCallback(callbackSettingsTrailer)
        previousVehicleTowing = true
      else
        previousVehicleTowing = false
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
    goalConditionsMet = true
  end
  local function cleanup()
    if previousVehicle then
      previousVehicle:removeCollisionCallback(callbackSettings)
    end
    if previousVehicleTowing then
      GameVehicleResource.UnRegisterCollisionCallback(callbackSettingsTrailer)
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Accelerated from startValue to value", function(operandA, operandB, UID, params, feedback)
  local goalConditionsMet = false
  local goalReportedSuccessful = false
  local beenBelowStartSpeed = false
  local speed = 0
  local speedInMph = 0
  local inSpeedStunt = {
    stuntText = "ID:242735",
    stuntTextValue = nil,
    stuntHide = false,
    stuntSlotPass = nil
  }
  local showingCameraMessage = false
  local function update()
    goalConditionsMet = false
    if localPlayer.currentVehicle then
      if params.displayed then
        speed = localPlayer.currentVehicle.gameVehicle.displayedSpeed
      else
        speed = localPlayer.currentVehicle.speed
      end
      speedInMph = speed * 2.236
    else
      speed = nil
      speedInMph = nil
    end
    if not beenBelowStartSpeed and speedInMph and speedInMph < params.startValue then
      beenBelowStartSpeed = true
    end
    if localPlayer.inZap or params.camera and not isInCorrectCameraMode(params.camera) then
      beenBelowStartSpeed = false
    end
    if params.noAbilities then
      if AbilityController.isAbilityActive("nitro") or AbilityController.isAbilityActive("ram") then
        if beenBelowStartSpeed then
          OneShotSound.Play("HUD_Gen_Currency_Fail", false)
        end
        beenBelowStartSpeed = false
        inSpeedStunt.stuntHide = true
        feedbackSystem.updateStuntFeedback(inSpeedStunt)
        if not feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:245686")
        end
      elseif not feedbackSystem.menusMaster.primaryPromptActive and beenBelowStartSpeed then
        inSpeedStunt.stuntHide = false
      end
    end
    if beenBelowStartSpeed and speedInMph then
      if speedInMph >= params.value then
        goalConditionsMet = true
        OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
        inSpeedStunt.stuntTextValue = params.targetDisplaySpeed
        inSpeedStunt.stuntSlotPass = 2
        if not feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.updateStuntFeedback(inSpeedStunt)
        end
      elseif params.showSpeed then
        inSpeedStunt.stuntTextValue = feedbackSystem.localiseSpeedFromMetersASecond(speed)
        if not feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.updateStuntFeedback(inSpeedStunt)
        end
      end
    end
    if feedback then
      if speedInMph and beenBelowStartSpeed then
        feedback(speedInMph)
      else
        feedback(0)
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    if not goalConditionsMet and beenBelowStartSpeed then
      OneShotSound.Play("HUD_Gen_Currency_Fail", false)
    end
    if localPlayer.currentVehicle then
      localPlayer.currentVehicle:removeCollisionCallback("simpleCheck" .. tostring(UID))
    end
    if params.camera and not isInCorrectCameraMode(params.camera) then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:236453", false, false, true, false, localPlayer.buttonLayout.changeCamera)
    end
    inSpeedStunt.stuntHide = true
    feedbackSystem.updateStuntFeedback(inSpeedStunt)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Button being held", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local downButtonStatus = controlHandler:getStatus(params.button)
  return function()
    goalConditionsMet = false
    downButtonStatus = controlHandler:getStatus(params.button)
    if downButtonStatus == "Pressed" then
      goalConditionsMet = true
    end
    if params.inverse then
      goalConditionsMet = not goalConditionsMet
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
goalSystem.registerGoal("Forgiving against traffic flow", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local exitOncomingTime, enterOncomingTime
  local timeAllowance = 1.5
  local inOncoming
  local requiredTime = params.value
  local currentTime, onJunction
  local inSpeedStunt = {
    stuntText = "ID:242735",
    stuntTextValue = nil,
    stuntHide = false,
    stuntSlotPass = nil,
    stuntFail = nil
  }
  dareSystem.resetTimer()
  local function update()
    if localPlayer.currentVehicle then
      inSpeedStunt.stuntHide = true
      feedbackSystem.updateStuntFeedback(inSpeedStunt)
      onJunction = isVehicleOnJunction(localPlayer.currentVehicle)
      if not onJunction or onJunction and enterOncomingTime then
        inOncoming = not onJunction and Atlas.DoesRoadHaveDrivingLanes(localPlayer.currentVehicle:get_closestRoadIndex()) and not scoreSystem.isPlayerOffRoad(2, localPlayer.localID) and not localPlayer.currentVehicle:get_withTrafficFlow()
        if inOncoming and not enterOncomingTime then
          enterOncomingTime = g_NetworkTime
          dareSystem.resetTimer()
        end
        if not inOncoming and enterOncomingTime and not exitOncomingTime then
          exitOncomingTime = g_NetworkTime
          dareSystem.pauseTimer()
        end
        if inOncoming and enterOncomingTime and exitOncomingTime then
          enterOncomingTime = enterOncomingTime + (g_NetworkTime - exitOncomingTime)
          dareSystem.unpauseTimer()
          exitOncomingTime = nil
        end
        if exitOncomingTime and g_NetworkTime - exitOncomingTime >= timeAllowance then
          enterOncomingTime = false
          exitOncomingTime = false
          dareSystem.resetTimer()
          OneShotSound.Play("HUD_Gen_Currency_Fail", false)
        end
        currentTime = 0
        if enterOncomingTime then
          if exitOncomingTime then
            currentTime = exitOncomingTime - enterOncomingTime
            dareSystem.setTimePassed(currentTime)
          else
            currentTime = g_NetworkTime - enterOncomingTime
            dareSystem.setTimePassed(currentTime)
          end
          if currentTime >= requiredTime then
            OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
            goalConditionsMet = true
          end
        end
      end
      if feedback then
        feedback(currentTime)
      end
      if goalConditionsMet and not goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = true
      elseif not goalConditionsMet and goalReportedSuccessful then
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = false
      end
    end
  end
  local function cleanup()
    if not goalConditionsMet then
      OneShotSound.Play("HUD_Gen_Currency_Fail", false)
    end
    dareSystem.clearTimer()
    feedbackSystem.removeSlot(3)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Prompted if in invalid camera mode", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  if not isInCorrectCameraMode(params.value) then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:236453", false, false, false, false, localPlayer.buttonLayout.changeCamera, nil, {
      button = "Camera_Change",
      pressType = "JustPressed"
    })
  end
  return function()
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
local wpDriftStunt = {
  stuntText = "ID:245410",
  stuntTextValue = nil,
  stuntSlotPass = nil,
  stuntFail = true
}
local wpJumpStunt = {
  stuntText = "ID:243808",
  stuntTextValue = nil,
  stuntSlotPass = nil,
  stuntFail = true
}
goalSystem.registerGoal("willpower collection", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local willpowerTotal = 0
  local willpowerInc = 0
  local baseWillpower = ProfileSettings.GetWillpower()
  local baseTokenCount = getTokensCollected()
  local currentTokenCount = getTokensCollected()
  local tokenWillpowerDiff = 0
  local willpowerPerToken = 2000
  local baseGarageWillpower = garage.garageWillpower
  local garageWillpowerDiff = 0
  local pointsParams = {
    pointsText = "+" .. tostring(1),
    pointsSlotPass = 2
  }
  local function update()
    currentTokenCount = getTokensCollected()
    if currentTokenCount > baseTokenCount then
      tokenWillpowerDiff = (currentTokenCount - baseTokenCount) * willpowerPerToken
    end
    if garage.garageWillpower > baseGarageWillpower then
      garageWillpowerDiff = garage.garageWillpower - baseGarageWillpower
    end
    local nonDareWillpower = tokenWillpowerDiff + garageWillpowerDiff
    if ProfileSettings.GetWillpower() > baseWillpower + nonDareWillpower then
      willpowerInc = ProfileSettings.GetWillpower() - baseWillpower - nonDareWillpower
      willpowerTotal = willpowerTotal + willpowerInc
      baseWillpower = ProfileSettings.GetWillpower() - nonDareWillpower
      pointsParams = {
        pointsText = "+" .. tostring(willpowerInc),
        pointsSlotPass = 2,
        willpowerIcon = true
      }
      feedbackSystem.updatePointsFeedback(pointsParams)
    end
    if params.value < willpowerTotal then
      goalConditionsMet = true
    end
    if feedback then
      feedback(willpowerTotal)
    end
    if goalConditionsMet and not goalReportedSuccessful then
      OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local function cleanup()
    pointsParams = {
      pointsHide = true,
      pointsText = nil,
      pointsSlotPass = nil,
      willpowerIcon = false
    }
    feedbackSystem.updatePointsFeedback(pointsParams)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Dare above speed feedback", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local inverse = params.inverse or false
  local requiredSpeed = params.value
  local currentSpeed
  local previousSpeed = 300
  local currentSpeedInMph
  local checkOncoming = params.oncoming or false
  local previouslyInZap = localPlayer.inZap
  local inSpeedStunt = {
    stuntText = "ID:242735",
    stuntTextValue = nil,
    stuntHide = true,
    stuntSlotPass = nil,
    stuntFail = nil
  }
  local startedToSlowdown = false
  local timerCheck = false
  local timeOfSlowdown = 0
  local speedDifference, inOncoming
  local wasInNormalTraffic = true
  local disappearTime = 1
  local aboveRequiredSpeed = false
  local function updateSpeedBar()
    if not startedToSlowdown and speedDifference >= 0.15 or inOncoming and wasInNormalTraffic and speedDifference >= 0.15 then
      startedToSlowdown = true
      timerCheck = true
      timeOfSlowdown = g_NetworkTime
      wasInNormalTraffic = false
    elseif startedToSlowdown and speedDifference <= -0.15 or inOncoming and wasInNormalTraffic and speedDifference <= -0.15 then
      startedToSlowdown = false
      inSpeedStunt.stuntFail = false
      inSpeedStunt.stuntHide = false
      timerCheck = false
      disappearTime = 1
      wasInNormalTraffic = false
    end
    if timerCheck and g_NetworkTime - timeOfSlowdown >= disappearTime then
      inSpeedStunt.stuntHide = true
      timerCheck = false
      inSpeedStunt.stuntFail = false
      disappearTime = 1
    end
    inSpeedStunt.stuntTextValue = feedbackSystem.localiseSpeedFromMetersASecond(currentSpeed)
    feedbackSystem.updateStuntFeedback(inSpeedStunt)
  end
  local function update()
    goalConditionsMet = false
    if checkForChangeInZap then
      if previouslyInZap and not localPlayer.inZap then
        if localPlayer.currentVehicle.gameVehicle.displayedTopSpeed < requiredSpeed then
          local fasterHint = {"ID:246535", 0}
          feedbackSystem.menusMaster.setHintText(fasterHint, true)
        end
        previouslyInZap = false
      elseif not previouslyInZap and localPlayer.inZap then
        previouslyInZap = true
      end
    end
    if localPlayer.currentVehicle then
      currentSpeed = localPlayer.currentVehicle.gameVehicle.displayedSpeed
      currentSpeedInMph = currentSpeed * 2.236
      speedDifference = previousSpeed - currentSpeedInMph
      if checkOncoming then
        inOncoming = not isVehicleOnJunction(localPlayer.currentVehicle) and Atlas.DoesRoadHaveDrivingLanes(localPlayer.currentVehicle:get_closestRoadIndex()) and not scoreSystem.isPlayerOffRoad(2, localPlayer.localID) and not localPlayer.currentVehicle:get_withTrafficFlow()
        if not inOncoming then
          wasInNormalTraffic = true
        end
      end
      if currentSpeedInMph >= requiredSpeed then
        goalConditionsMet = true
        if goalConditionsMet and not checkOncoming and not feedbackSystem.menusMaster.primaryPromptActive then
          inSpeedStunt.stuntTextValue = params.targetDisplaySpeed
          inSpeedStunt.stuntSlotPass = 2
          feedbackSystem.updateStuntFeedback(inSpeedStunt)
        end
        aboveRequiredSpeed = true
        disappearTime = 2
      else
        if aboveRequiredSpeed then
          aboveRequiredSpeed = false
          inSpeedStunt.stuntFail = true
          inSpeedStunt.stuntHide = false
        end
        if checkOncoming and not inOncoming then
          inSpeedStunt.stuntHide = true
          if not feedbackSystem.menusMaster.primaryPromptActive then
            feedbackSystem.updateStuntFeedback(inSpeedStunt)
          end
        end
        if not feedbackSystem.menusMaster.primaryPromptActive then
          updateSpeedBar()
        end
      end
      if speedDifference >= 0.15 or speedDifference <= -0.15 then
        previousSpeed = currentSpeedInMph
      end
      if params.inverse then
        goalConditionsMet = not goalConditionsMet
      end
      if feedback then
        feedback(currentSpeedInMph)
      end
      if goalConditionsMet and not goalReportedSuccessful then
        OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = true
      elseif not goalConditionsMet and goalReportedSuccessful then
        if feedback then
          OneShotSound.Play("HUD_Gen_Currency_Fail", false)
        end
        goalSystem.callbackHandler(UID)
        goalReportedSuccessful = false
      end
    end
  end
  local function cleanup()
    inSpeedStunt.stuntHide = true
    feedbackSystem.updateStuntFeedback(inSpeedStunt)
  end
  return update, cleanup
end)
goalSystem.registerGoal("Prompt upgrade", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = true
  local inZap = localPlayer.inZap
  function checkVehicle()
    if params.promptType == "Faster" then
      if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle.displayedTopSpeed < params.value then
        local fasterHint = {"ID:246535", 0}
        feedbackSystem.menusMaster.setHintText(fasterHint, true)
        feedbackSystem.menusMaster.primaryTextPrompt("ID:246535", nil, false, true)
      end
    elseif params.promptType == "Car type" then
      if params.requiresTransporter then
        local carTransporter = 298
        if not ProfileSettings.GetVehicleOwned(carTransporter) then
          local buyHint = {"ID:246536", 0}
          feedbackSystem.menusMaster.setHintText(buyHint, true)
        end
      end
      if params.carModel then
        local found = false
        for k, modelID in next, params.carModel, nil do
          if localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle.model_id == modelID then
            found = true
            break
          end
        end
        if not found and params.vehType then
          if params.vehType == "Tow truck" then
            feedbackSystem.menusMaster.primaryTextPrompt("ID:246529", nil, false, true)
          elseif params.vehType == "Bus" then
            feedbackSystem.menusMaster.primaryTextPrompt("ID:246532", nil, false, true)
          elseif params.vehType == "Taxi" then
            feedbackSystem.menusMaster.primaryTextPrompt("ID:246534", nil, false, true)
          elseif params.vehType == "Haulier" then
            feedbackSystem.menusMaster.primaryTextPrompt("ID:248702", nil, false, true)
          elseif params.vehType == "Big rig" then
            feedbackSystem.menusMaster.primaryTextPrompt("ID:246533", nil, false, true)
          elseif params.vehType == "Truck" then
            feedbackSystem.menusMaster.primaryTextPrompt("ID:246685", nil, false, true)
          end
        end
      end
    elseif params.promptType == "Ability" then
      if not abilities.nitro.getLevel() then
        local upgradeHint = {"ID:247187", 0}
        feedbackSystem.menusMaster.setHintText(upgradeHint, true)
        feedbackSystem.menusMaster.primaryTextPrompt("ID:247187", nil, false, true)
      else
        local level
        local upgradeLevel = abilities.abilityBarUpgrade.getLevel()
        if upgradeLevel then
          for abilityLevel, upgradeAmount in next, abilities.abilityBarUpgrade.settings, nil do
            if upgradeLevel == upgradeAmount then
              level = abilityLevel
              break
            end
          end
        end
        if not level or level and level < params.abilityLevel then
          local upgradeHint = {"ID:246537", 0}
          feedbackSystem.menusMaster.setHintText(upgradeHint, true)
          feedbackSystem.menusMaster.primaryTextPrompt("ID:246537", nil, false, true)
        end
      end
    elseif params.promptType == "Thrillcam" and not abilities.thrillCam.getActiveLevel() then
      local upgradeHint = {"ID:248621", 0}
      feedbackSystem.menusMaster.setHintText(upgradeHint, true)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:248621", nil, false, true)
    end
  end
  checkVehicle()
  local function update()
    if params.promptType then
      if inZap and not localPlayer.inZap then
        inZap = false
        checkVehicle()
      elseif not inZap and localPlayer.inZap then
        inZap = true
        dareSystem.setDareHint(false)
        if feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        end
      end
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
  local cleanup = function()
    dareSystem.setDareHint(false)
    if feedbackSystem.menusMaster.primaryPromptActive then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    end
  end
  return update, cleanup
end)
goalSystem.registerGoal("Dare started driving", function(operandA, operandB, UID, params, feedback)
  local goalReportedSuccessful = false
  local goalConditionsMet = false
  local dareStarted = false
  return function()
    if not dareStarted and localPlayer.currentVehicle and localPlayer.currentVehicle.gameVehicle.speed > 0.1 then
      dareStarted = true
      goalConditionsMet = true
    end
    if goalConditionsMet and not goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = true
    elseif not goalConditionsMet and goalReportedSuccessful then
      goalSystem.callbackHandler(UID)
      goalReportedSuccessful = false
    end
  end
end)
