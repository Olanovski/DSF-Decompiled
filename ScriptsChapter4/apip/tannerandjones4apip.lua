feedbackSystem.registerAudioPIP("Tanner and Jones Mission 4 APIP", function(task)
  local instance = task.instance
  local taskObject = instance.taskObjectsByActorID["Tanner and Jones"]
  local playInZapAudio = true
  local conversationNumber = 2
  local sequenceNumber = 0
  local pipNumber = 0
  local workingVector = vec.vector()
  local tailTooClose = 35
  local losingRadius = 100
  local distanceCount = 0
  local tooFarAlreadyPlayed = false
  local waitForConversation, waitStartTime
  local conversationAllowed = false
  local musicStarted = false
  local callAlreadyMade = false
  local callAlreadyReceived = false
  local phoneWait = "phoneWait"
  local firstPipAlreadyPlayed = false
  local firstDialoguePlayed = false
  local isPipPlaying = false
  local chaseZapPlayed = false
  local krugActor = task.instance.taskObjectsByActorID.Krug.coreData.actor
  local krugAgent = task.instance.taskObjectsByActorID.Krug.coreData.agent
  local function unlockTheBrakes()
    instance.taskObjectsByActorID["Tanner and Jones"].coreData.agent:unlockEmergencyBrakes()
    localPlayer:blockAbility("zap", false)
  end
  if task.specialName == "Conversation manager" then
    unlockTheBrakes()
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2")
    firstDialoguePlayed = true
    conversationNumber = 2
    sequenceNumber = 0
    pipNumber = 0
    waitForConversation = 5
    waitStartTime = g_NetworkTime
  end
  if task.specialName == "Conversation manager PART DUEX" then
    conversationNumber = 3
    waitForConversation = 5
    waitStartTime = g_NetworkTime
  end
  local function conversationPause(waitTime)
    waitForConversation = waitTime
    waitStartTime = g_NetworkTime
  end
  local function triggerPiP()
    if not localPlayer.challenge.showingEndScreen then
      if pipNumber == 1 then
        isPipPlaying = true
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01", function()
          isPipPlaying = false
        end, "missionCritical")
        firstPipAlreadyPlayed = true
      elseif pipNumber == 2 then
        isPipPlaying = true
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP02", function()
          isPipPlaying = false
        end, "missionCritical")
      elseif pipNumber == 3 then
        isPipPlaying = true
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP05", function()
          isPipPlaying = false
        end, "missionCritical")
      end
    end
  end
  local function triggerToClose(pipNeeded, hangUpNeeded)
    if not localPlayer.challenge.showingEndScreen and task.agent.controlled and task.instance.taskObjectsByActorID.Krug then
      local distance = workingVector:sub(localPlayer.currentVehicle.position, task.instance.taskObjectsByActorID.Krug.coreData.agent.position):length()
      if conversationNumber == 1 and sequenceNumber == 0 and hangUpNeeded and distance < losingRadius then
        OneShotSound.Play("Krug_HangsUpPhone")
      elseif conversationNumber == 2 and sequenceNumber == 0 and hangUpNeeded and distance < losingRadius then
        OneShotSound.Play("Jericho_HangsUpPhone")
      end
      if distance <= tailTooClose then
        if pipNeeded then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_8A", triggerPiP, "timeSensitive")
        else
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_8A", nil, "timeSensitive")
        end
      elseif pipNeeded and distance < losingRadius then
        triggerPiP()
      end
    end
  end
  local playAudio = function(audio)
    if not isEventActive() then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, audio, nil, "missionCritical")
      removeUserUpdateFunction("playAudio")
    end
  end
  local function goalComplete(conditionKey)
    if string.find(task.specialName, "In zap") and conditionKey == 1 and playInZapAudio then
      playInZapAudio = false
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_1")
    elseif string.find(task.specialName, "In zap") and conditionKey == 2 and not playInZapAudio then
      playInZapAudio = true
    elseif task.specialName == "CHASE zap" and conditionKey == 1 and playInZapAudio then
      playInZapAudio = false
      if not chaseZapPlayed then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_2")
        chaseZapPlayed = true
      end
    elseif task.specialName == "CHASE zap" and conditionKey == 2 and not playInZapAudio then
      playInZapAudio = true
    elseif string.find(task.specialName, "Get to point") and conditionKey == 1 then
      feedbackSystem.stopMusic("Uid05890_CH04_TJ_TheConversation_Stop")
      Commentary.StopCommentary()
    elseif task.specialName == "Drive to speech" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_1", nil, "missioncritical")
      addUserUpdateFunction("playAudio", function()
        playAudio("GPMV01_SEQUENCE_R_1")
      end, 1)
    elseif task.specialName == string.find(task.specialName, "Conversation manager") and conditionKey == 5 then
      if conversationNumber == 0 then
        conversationNumber = 1
      elseif conversationNumber == 1 then
        if sequenceNumber < 3 then
          sequenceNumber = sequenceNumber + 1
        else
          sequenceNumber = 0
          conversationNumber = conversationNumber + 1
        end
      elseif conversationNumber == 2 then
        if sequenceNumber == 0 or sequenceNumber == 4 then
          pipNumber = pipNumber + 1
        end
        if sequenceNumber < 4 then
          sequenceNumber = sequenceNumber + 1
        else
          sequenceNumber = 0
          conversationNumber = conversationNumber + 1
        end
      elseif conversationNumber == 3 then
        if sequenceNumber == 0 then
          pipNumber = pipNumber + 1
        end
        if sequenceNumber < 5 then
          sequenceNumber = sequenceNumber + 1
        else
          sequenceNumber = 0
          conversationNumber = conversationNumber + 1
        end
      end
    elseif string.find(task.specialName, "Conversation manager") and conditionKey == 1 then
      tooFarAlreadyPlayed = false
      firstDialoguePlayed = true
      if waitForConversation and g_NetworkTime - waitStartTime >= waitForConversation then
        if (conversationNumber == 2 or conversationNumber == 3) and sequenceNumber == 0 and not callAlreadyMade then
          callAlreadyMade = true
          OneShotSound.Play("Krug_MakesACall")
          conversationPause(6)
        elseif conversationNumber == 1 and sequenceNumber == 0 and not callAlreadyReceived then
          callAlreadyReceived = true
          OneShotSound.Play("Krug_ReceivesACall")
          conversationPause(4)
        else
          waitForConversation = nil
          conversationAllowed = true
          callAlreadyMade = false
          callAlreadyReceived = false
        end
      elseif not waitForConversation and not conversationAllowed then
        conversationPause(5)
      end
      if conversationAllowed then
        if conversationNumber == 0 then
          firstDialoguePlayed = true
          conversationAllowed = false
          conversationPause(5)
          conversationNumber = 1
          sequenceNumber = 0
        elseif conversationNumber == 1 then
          if sequenceNumber == 0 then
            sequenceNumber = sequenceNumber + 1
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3A", triggerToClose, "missionCritical")
          elseif sequenceNumber == 1 then
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3B", triggerToClose, "missionCritical")
            sequenceNumber = sequenceNumber + 1
          elseif sequenceNumber == 2 then
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3C", triggerToClose, "missionCritical")
            sequenceNumber = sequenceNumber + 1
          elseif sequenceNumber == 3 then
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3D", triggerToClose(false, true), "missionCritical")
            sequenceNumber = sequenceNumber + 1
          elseif sequenceNumber == 4 then
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_11", triggerToClose(false, true), "missionCritical")
            sequenceNumber = 0
            conversationAllowed = false
          end
        elseif conversationNumber == 2 then
          if sequenceNumber == 0 then
            sequenceNumber = sequenceNumber + 1
            pipNumber = 1
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4A", function()
              triggerToClose(true, false)
            end, "missionCritical")
          elseif sequenceNumber == 1 then
            if firstPipAlreadyPlayed then
              feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4B", triggerToClose, "missionCritical")
            else
              feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4B", function()
                triggerToClose(true)
              end, "missionCritical")
            end
            sequenceNumber = sequenceNumber + 1
          elseif sequenceNumber == 2 then
            if firstPipAlreadyPlayed then
              feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4C", triggerToClose, "missionCritical")
            else
              feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4C", function()
                triggerToClose(true)
              end, "missionCritical")
            end
            sequenceNumber = sequenceNumber + 1
          elseif sequenceNumber == 3 then
            if firstPipAlreadyPlayed then
              feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4D", triggerToClose, "missionCritical")
            else
              feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4D", function()
                triggerToClose(true)
              end, "missionCritical")
            end
            sequenceNumber = sequenceNumber + 1
          elseif sequenceNumber == 4 then
            pipNumber = 2
            conversationAllowed = false
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_4E", function()
              triggerToClose(true, true)
            end, "missionCritical")
            sequenceNumber = 0
            conversationNumber = 1
            conversationPause(10)
          end
        elseif conversationNumber == 3 then
          if sequenceNumber == 0 then
            sequenceNumber = sequenceNumber + 1
            pipNumber = 3
            feedbackSystem.startMusic("Uid05890_CH04_TJ_TheConversation_Play")
            musicStarted = true
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_6A", function()
              triggerToClose(true, false)
            end, "missionCritical")
          elseif sequenceNumber == 1 then
            if not musicStarted then
              musicStarted = true
              feedbackSystem.startMusic("Uid05890_CH04_TJ_TheConversation_Play")
            end
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_6B", triggerToClose, "missionCritical")
            sequenceNumber = sequenceNumber + 1
          elseif sequenceNumber == 2 then
            if not musicStarted then
              musicStarted = true
              feedbackSystem.startMusic("Uid05890_CH04_TJ_TheConversation_Play")
            end
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_6C", triggerToClose, "missionCritical")
            sequenceNumber = sequenceNumber + 1
          elseif sequenceNumber == 3 then
            if not musicStarted then
              musicStarted = true
              feedbackSystem.startMusic("Uid05890_CH04_TJ_TheConversation_Play")
            end
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_6D", triggerToClose, "missionCritical")
            sequenceNumber = sequenceNumber + 1
          elseif sequenceNumber == 4 then
            if not musicStarted then
              musicStarted = true
              feedbackSystem.startMusic("Uid05890_CH04_TJ_TheConversation_Play")
            end
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_6E", triggerToClose, "missionCritical")
            sequenceNumber = sequenceNumber + 1
          elseif sequenceNumber == 5 then
            if not musicStarted then
              musicStarted = true
              feedbackSystem.startMusic("Uid05890_CH04_TJ_TheConversation_Play")
            end
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_6F", triggerToClose, "missionCritical")
            sequenceNumber = 0
            conversationNumber = conversationNumber + 1
          end
        end
      end
    elseif string.find(task.specialName, "Tracking Player Position") and conditionKey == 1 then
      OneShotSound.Play("Krugs_Vehicle_InRange")
    elseif string.find(task.specialName, "Tracking Player Position") and conditionKey == 2 then
      OneShotSound.Play("Krugs_Vehicle_OutOfRange")
      if task.specialName == "Tracking Player Position 2" then
        Commentary.StopCommentary()
      end
    elseif string.find(task.specialName, "Conversation manager") and conditionKey == 2 and not tooFarAlreadyPlayed and firstDialoguePlayed and not isPipPlaying then
      tooFarAlreadyPlayed = true
      Commentary.StopCommentary()
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_8B", nil, "missionCritical")
    elseif task.specialName == "Speed change" then
      if conditionKey == 1 then
        krugActor.desiredSpeed = 65
      elseif conditionKey == 2 then
        krugActor.desiredSpeed = 70
      elseif conditionKey == 3 then
        krugActor.desiredSpeed = 75
      elseif conditionKey == 4 then
        krugActor.desiredSpeed = 80
      end
      krugAgent:stopHighSpeedDriving()
      local behaviour = {
        traits = taskSystem.buildDriveTraits(task.instance.taskObjectsByActorID.Krug.coreData),
        roadRoute = routes[krugActor.routeName].roads,
        routeName = krugActor.routeName
      }
      behaviour.traits.desiredSpeed = krugActor.desiredSpeed
      krugAgent:highSpeedDrive(behaviour)
    end
  end
  local function taskComplete()
    if task.specialName == "Spawn Attacker Wave" then
    elseif task.specialName == "Use shift to take them down prompt" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_12", nil, "missionCritical")
    elseif task.specialName == "CHASE during attack" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_13", nil, "missionCritical")
    end
  end
  local function cleanup()
    removeUserUpdateFunction(phoneWait)
    removeUserUpdateFunction("playAudio")
  end
  return nil, goalComplete, taskComplete, cleanup
end)
