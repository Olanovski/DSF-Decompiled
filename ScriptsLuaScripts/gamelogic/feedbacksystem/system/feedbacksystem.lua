module("feedbackSystem", package.seeall)
targetStyleBuilders = {}
targetManagerBuilders = {}
targetList = {}
updatingTargets = {}
HUDBuilders = {}
APIPBuilders = {}
vehicleMarkerTypes = {
  ["Opponent"] = {
    styles = {
      "Vehicle tracking",
      "Light trail"
    }
  },
  ["Opponent (No light trails)"] = {
    styles = {
      "Vehicle tracking"
    }
  },
  ["Opponent (objective)"] = {
    styles = {
      "Vehicle tracking",
      "Light trail"
    }
  },
  ["Objective"] = {
    styles = {
      "Vehicle tracking",
      "Light trail"
    }
  },
  ["Objective (No light trails)"] = {
    styles = {
      "Vehicle tracking"
    }
  },
  ["Red Marker, Racer"] = {
    styles = {
      "Vehicle tracking",
      "Light trail"
    }
  },
  ["Red Marker, Getaway Radius"] = {
    styles = {
      "Vehicle tracking",
      "Light trail"
    }
  },
  ["Red Marker, Fake Felony Radius"] = {
    styles = {
      "Vehicle tracking",
      "Light trail"
    }
  },
  ["Red Marker, No Health Bar"] = {
    styles = {
      "Vehicle tracking",
      "Light trail"
    }
  },
  ["Blue Marker, Cop Radius"] = {
    styles = {
      "Vehicle tracking",
      "Light trail"
    }
  },
  ["Blue Marker, Getaway Radius"] = {
    styles = {
      "Vehicle tracking",
      "Light trail"
    }
  },
  ["Yellow Marker, Getaway Radius"] = {
    styles = {
      "Vehicle tracking",
      "Light trail"
    }
  },
  ["Yellow Marker, Destination Vehicle"] = {
    styles = {
      "Vehicle tracking",
      "Light trail"
    }
  },
  ["Black Marker, No Health Bar"] = {
    styles = {
      "Vehicle tracking"
    }
  },
  ["Jericho Marker"] = {
    styles = {
      "Vehicle tracking"
    }
  },
  ["Jericho not in Vehicle"] = {
    styles = {
      "Vehicle tracking"
    }
  },
  ["Jericho Posessed"] = {
    styles = {
      "Vehicle tracking"
    }
  },
  ["Objective (No light trails/health)"] = {
    styles = {
      "Vehicle tracking"
    }
  }
}
function registerTargetStyle(styleName, styleDefaultAppearance, styleFunction)
  assert(not targetStyleBuilders[styleName], "FEEDBACKSYSTEM TARGETSUPPORT - registerTargetStyle: Attempt to re-register existing target style: " .. tostring(styleName))
  targetStyleBuilders[styleName] = {create = styleFunction, defaultAppearance = styleDefaultAppearance}
end
function registerTargetManager(managerName, managerTrigger, managerFunction)
  assert(not targetManagerBuilders[managerName], "FEEDBACKSYSTEM TARGETSUPPORT - registerTargetManager: Attempt to re-register existing target manager: " .. tostring(managerName))
  targetManagerBuilders[managerName] = {
    create = managerFunction,
    updateOnGoal = managerTrigger == "Goal",
    updateOnInstance = managerTrigger == "Instance",
    updateOnZap = managerTrigger == "Zap",
    updateOnUpdate = managerTrigger == "Update"
  }
end
function registerHUD(HUDName, HUDPreview, HUDFunction)
  assert(not HUDBuilders[HUDName], "FEEDBACKSYSTEM - registerHUD: Attempt to re-register existing HUD: " .. tostring(HUDName))
  HUDBuilders[HUDName] = {}
  HUDBuilders[HUDName].preview = HUDPreview
  HUDBuilders[HUDName].mission = HUDFunction
end
function registerAudioPIP(APIPName, APIPFunction)
  assert(not APIPBuilders[APIPName], "FEEDBACKSYSTEM - registerAudioPIP: Attempt to re-register existing Audio/PIP manager: " .. tostring(APIPName))
  APIPBuilders[APIPName] = APIPFunction
end
function clearMissionFeedbacks()
  for k, v in next, APIPBuilders, nil do
    APIPBuilders[k] = nil
  end
  for k, v in next, HUDBuilders, nil do
    HUDBuilders[k] = nil
  end
end
function update()
  taskSupport.update()
  if gameStatus.onlineSession then
    eventMessages.update()
    onlineScreenManager.update()
  end
  for targetID, targetFuncs in next, updatingTargets, nil do
    targetFuncs.update()
  end
end
function purge()
  if gameStatus.onlineSession then
    eventMessages.clearMessages()
    multiplayerSupport.enabled = false
    onlineInstructionSupport.purge()
  end
  taskSupport.purge()
  faceOffSupport.purge()
end
function newTarget(target, style, overrideStyleParams, task)
  assert(targetStyleBuilders[style], "FEEDBACKSYSTEM - newTarget: Could not find target style: " .. tostring(style))
  local targetStyle = targetStyleBuilders[style]
  local styleParams = {}
  if overrideStyleParams then
    for varName, value in next, overrideStyleParams, nil do
      styleParams[varName] = value
    end
  end
  if targetStyle.defaultAppearance then
    for varName, value in next, targetStyle.defaultAppearance, nil do
      if styleParams[varName] == nil then
        styleParams[varName] = value
      end
    end
  end
  local newTarget = {}
  local marker = false
  newTarget.update, newTarget.cleanup = targetStyle.create(target, styleParams, task)
  local drawListID = 0
  while targetList[drawListID] do
    drawListID = drawListID + 1
  end
  newTarget.drawListID = drawListID
  targetList[drawListID] = newTarget
  if newTarget.update then
    updatingTargets[drawListID] = newTarget
  end
  return drawListID
end
function clearTarget(drawListID)
  if targetList[drawListID] then
    if targetList[drawListID].cleanup then
      targetList[drawListID].cleanup()
    end
    updatingTargets[drawListID] = nil
    targetList[drawListID] = nil
  end
end
