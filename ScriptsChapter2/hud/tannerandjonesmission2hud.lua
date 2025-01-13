local warningZap = false
feedbackSystem.registerHUD("Tanner & Jones Mission 2 HUD", function(task, settings)
end, function(task)
  local timer, suspicionTable, warningProximity, eyeMarker, previousSpeed, slowDownSpeed, outsideRadius, firstSuspicion
  if task.specialName == "Tail suspicion" then
    suspicionTable = {
      slot = 1,
      title = "ID:184852",
      barTitle = "ID:184426",
      value = -1
    }
    timer = g_NetworkTime
  elseif task.specialName == "Tail warning" then
    warningProximity = false
    eyeMarker = false
    previousSpeed = 80
    slowDownSpeed = 35
    outsideRadius = false
    firstSuspicion = true
  end
  local function update()
    if suspicionTable then
      if g_NetworkTime - timer > 95 then
        suspicionTable.title = "ID:184100"
        feedbackSystem.updateDangerBar(suspicionTable)
      end
      if task.networkVars.payload ~= suspicionTable.value then
        Sound.SetRTPC("Paranoia_Meter", suspicionTable.value)
        suspicionTable.value = task.networkVars.payload
        feedbackSystem.updateDangerBar(suspicionTable)
      end
    end
  end
  local clearSuspicionPrompt = function()
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    removeUserUpdateFunction("clearSuspicionPrompt")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Tail warning" then
      if conditionKey == 1 then
        removeUserUpdateFunction("clearSuspicionPrompt")
        if not eyeMarker and task.instance.taskObjectsByActorID.Leila then
          eyeMarker = feedbackSystem.newTarget(task.instance.taskObjectsByActorID.Leila.coreData.agent, "Spotted marker")
          if task.agent:getTaskObject().namedTasks["Tail suspicion"] and task.agent:getTaskObject().namedTasks["Tail suspicion"].networkVars.payload and task.agent:getTaskObject().namedTasks["Tail suspicion"].networkVars.payload >= 80 then
            feedbackSystem.menusMaster.primaryTextPromptParam({
              prompt = "ID:245319",
              delay = false,
              permanent = true,
              priority = 1
            })
          else
            feedbackSystem.menusMaster.primaryTextPromptParam({
              prompt = "ID:245317",
              delay = false,
              permanent = true,
              priority = 1
            })
          end
          Sound.SetState("Suspicion_State", "On")
          local Leila = task.instance.taskObjectsByActorID.Leila.coreData.agent
          if Leila.markers and Leila.markers.radius then
            Leila.markers.radius.colour = vec.vector(255, 0, 0, 150)
          end
        end
      elseif conditionKey == 2 then
        if not warningProximity then
          warningProximity = true
        end
      elseif conditionKey == 3 then
        if warningProximity then
          feedbackSystem.menusMaster.clearPrimaryTextPrompt()
          warningProximity = false
          if outsideRadius then
            outsideRadius = false
            task.instance.taskObjectsByActorID.Leila.coreData.actor.rubberbandingToPlayerStrength = "Weaker"
            task.instance.taskObjectsByActorID.Leila.coreData.actor.desiredSpeed = previousSpeed + (task.instance.taskObjectsByActorID.Leila.coreData.actor.desiredSpeed - slowDownSpeed)
            task.instance.taskObjectsByActorID.Leila.coreData.agent:stopHighSpeedDriving()
            if #task.instance.taskObjectsByActorID.Leila.namedTasks["Chased by player"].dynamicTargets ~= 0 then
              task.instance.taskObjectsByActorID.Leila.coreData.agent:highSpeedDrive({
                traits = taskSystem.buildDriveTraits(task.instance.taskObjectsByActorID.Leila.coreData),
                destinationPosition = task.instance.taskObjectsByActorID.Leila.namedTasks["Chased by player"].dynamicTargets[1].position
              })
            else
              task.instance.taskObjectsByActorID.Leila.coreData.agent:highSpeedDrive({
                traits = taskSystem.buildDriveTraits(task.instance.taskObjectsByActorID.Leila.coreData)
              })
            end
            task.instance.taskObjectsByActorID.Leila.coreData.agent.gameVehicle.performance = 2
          end
        end
        if eyeMarker then
          Sound.SetState("Suspicion_State", "Off")
          feedbackSystem.clearTarget(eyeMarker)
          eyeMarker = false
          local Leila = task.instance.taskObjectsByActorID.Leila.coreData.agent
          if Leila.markers and Leila.markers.radius then
            Leila.markers.radius.colour = vec.vector(0, 0, 255, 150)
          end
          if firstSuspicion then
            feedbackSystem.menusMaster.primaryTextPromptParam({
              prompt = "ID:245318",
              delay = false,
              priority = 1
            })
            feedbackSystem.menusMaster.setCurrentFocusString(2)
            firstSuspicion = false
          else
            addUserUpdateFunction("clearSuspicionPrompt", function()
              clearSuspicionPrompt()
            end, 120, true)
          end
        end
      elseif conditionKey == 4 and not outsideRadius then
        outsideRadius = true
        previousSpeed = task.instance.taskObjectsByActorID.Leila.coreData.actor.desiredSpeed
        task.instance.taskObjectsByActorID.Leila.coreData.actor.rubberbandingToPlayerStrength = "None"
        task.instance.taskObjectsByActorID.Leila.coreData.actor.desiredSpeed = slowDownSpeed
        task.instance.taskObjectsByActorID.Leila.coreData.agent:stopHighSpeedDriving()
        if #task.instance.taskObjectsByActorID.Leila.namedTasks["Chased by player"].dynamicTargets ~= 0 then
          task.instance.taskObjectsByActorID.Leila.coreData.agent:highSpeedDrive({
            traits = taskSystem.buildDriveTraits(task.instance.taskObjectsByActorID.Leila.coreData),
            destinationPosition = task.instance.taskObjectsByActorID.Leila.namedTasks["Chased by player"].dynamicTargets[1].position
          })
        else
          task.instance.taskObjectsByActorID.Leila.coreData.agent:highSpeedDrive({
            traits = taskSystem.buildDriveTraits(task.instance.taskObjectsByActorID.Leila.coreData)
          })
        end
      end
    elseif suspicionTable and conditionKey == 5 then
      feedbackSystem.menusMaster.primaryTextPromptParam({
        prompt = "ID:245319",
        delay = false,
        permanent = true,
        priority = 1
      })
    end
  end
  local function taskComplete(conditionKey)
    if task.specialName == "Show dest prompt" then
      feedbackSystem.menusMaster.primaryTextPromptParam({
        prompt = "ID:245533",
        delay = false,
        priority = 1
      })
    elseif task.specialName == "Wait for follow prompt" then
      feedbackSystem.menusMaster.primaryTextPromptParam({
        prompt = "ID:184412",
        delay = false,
        priority = 1
      })
    elseif suspicionTable then
      feedbackSystem.removeSlot(1)
    elseif task.specialName == "Stopped before the boundary" and feedbackSystem.menusMaster.primaryPromptActive then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    end
  end
  local function cleanup()
    if eyeMarker then
      feedbackSystem.clearTarget(eyeMarker)
      eyeMarker = false
    end
  end
  return update, goalComplete, taskComplete, cleanup
end)
