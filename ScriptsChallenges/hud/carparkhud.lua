local audioTime = 0
feedbackSystem.registerHUD("Car park hud", function(task, settings)
end, function(task, settings)
  local instance = task.instance
  local taskObject = task.agent:getTaskObject()
  local countdownStarted = false
  local currentTime = 100
  local previousTime = 0
  local reductionTime = 0
  local startTime = false
  feedbackSystem.removeTimer()
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Watch", 100)
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike01", 0)
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike02", 0)
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike03", 0)
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike04", 0)
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike05", 0)
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike06", 0)
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike07", 0)
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike08", 0)
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Cross01", 0)
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Cross02", 0)
  feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Cross03", 0)
  local function update()
    if not gameStatus.simulationPaused then
      if task.specialName == "Wait for countdown" then
        if not countdownStarted then
          feedbackSystem.menusMaster.singlePlayer321Countdown()
          feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Display", 1)
          countdownStarted = true
          audioTime = 1
        end
      elseif not localPlayer.inCutscene then
        if not startTime then
          startTime = g_NetworkTime
        end
        currentTime = math.floor((g_NetworkTime - startTime) * 1.666)
        reductionTime = 100 - currentTime
        newaudiotime = math.ceil(currentTime)
        if newaudiotime == audioTime then
          if newaudiotime ~= 0 then
            OneShotSound.PlayCountdown("HUD_Gen_Timer_01_OneShot")
          end
          audioTime = newaudiotime + 1
        end
        feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Watch", reductionTime)
      end
    end
  end
  local goalComplete = function(goalConditionKey)
  end
  local function taskComplete()
    if task.specialName == "Speed" then
      OneShotSound.Play("HUD_Gen_Positive", false)
      feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike01", 1)
    elseif task.specialName == "Brake" then
      OneShotSound.Play("HUD_Gen_Positive", false)
      feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike02", 1)
    elseif task.specialName == "Burnout" then
      OneShotSound.Play("HUD_Gen_Positive", false)
      feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike03", 1)
    elseif task.specialName == "Handbrake turn" then
      OneShotSound.Play("HUD_Gen_Positive", false)
      feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike04", 1)
    elseif task.specialName == "Reverse 180" then
      OneShotSound.Play("HUD_Gen_Positive", false)
      feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike05", 1)
    elseif task.specialName == "360 spin" then
      OneShotSound.Play("HUD_Gen_Positive", false)
      feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike08", 1)
    elseif task.specialName == "Slalom" then
      OneShotSound.Play("HUD_Gen_Positive", false)
      feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike06", 1)
    elseif task.specialName == "Lap" then
      OneShotSound.Play("HUD_Gen_Positive", false)
      feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Strike07", 1)
    elseif task.specialName == "All stunts completed" or task.specialName == "Fail conditions" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      feedbackSystem.menusMaster.masterSetVariable("iCar_Park_Display", 0)
    end
  end
  local cleanup = function()
  end
  return update, nil, taskComplete, nil
end)
