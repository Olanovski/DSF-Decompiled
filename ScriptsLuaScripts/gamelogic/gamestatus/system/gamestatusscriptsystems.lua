module("gameStatus.scriptSystems", package.seeall)
local initiators = {
  {
    systemName = "localPlayerManager"
  },
  {
    systemName = "phaseManager"
  },
  {
    systemName = "onlineRaceManager"
  }
}
local updates = {
  singlePlayer = {
    {
      updateRate = 1,
      systemName = "localPlayerManager"
    },
    {
      updateRate = 2,
      systemName = "scoreSystem"
    },
    {
      updateRate = 1,
      systemName = "vehicleManager"
    },
    {
      updateRate = 1,
      systemName = "challengeSystem"
    },
    {
      updateRate = 6,
      systemName = "feedbackSystem"
    },
    {updateRate = 5, systemName = "taskSystem"},
    {updateRate = 12, systemName = "goalSystem"}
  },
  multiPlayer = {
    {
      updateRate = 1,
      systemName = "localPlayerManager"
    },
    {
      updateRate = 2,
      systemName = "scoreSystem"
    },
    {
      updateRate = 1,
      systemName = "remotePlayers"
    },
    {
      updateRate = 1,
      systemName = "vehicleManager"
    },
    {
      updateRate = 4,
      systemName = "phaseManager"
    },
    {
      updateRate = 1,
      systemName = "challengeSystem"
    },
    {
      updateRate = 6,
      systemName = "feedbackSystem"
    },
    {
      updateRate = 60,
      systemName = "onlineSideBar"
    },
    {updateRate = 5, systemName = "taskSystem"},
    {updateRate = 12, systemName = "goalSystem"},
    {
      updateRate = 4,
      systemName = "packageManager"
    }
  },
  splitScreen = {
    {
      updateRate = 1,
      systemName = "localPlayerManager"
    },
    {
      updateRate = 2,
      systemName = "scoreSystem"
    },
    {
      updateRate = 1,
      systemName = "remotePlayers"
    },
    {
      updateRate = 1,
      systemName = "vehicleManager"
    },
    {
      updateRate = 4,
      systemName = "phaseManager"
    },
    {
      updateRate = 1,
      systemName = "challengeSystem"
    },
    {
      updateRate = 6,
      systemName = "feedbackSystem"
    },
    {updateRate = 5, systemName = "taskSystem"},
    {updateRate = 12, systemName = "goalSystem"},
    {
      updateRate = 4,
      systemName = "packageManager"
    }
  }
}
local purges = {
  {
    systemName = "phaseManager"
  },
  {
    systemName = "faceOffSystem"
  },
  {
    systemName = "challengeSystem"
  },
  {
    systemName = "activeChallenges"
  },
  {
    systemName = "feedbackSystem"
  },
  {
    systemName = "onlineSideBar"
  },
  {systemName = "taskSystem"},
  {
    systemName = "packageManager"
  },
  {
    systemName = "checkpointSystem"
  },
  {
    systemName = "scoreSystem"
  },
  {
    systemName = "vehicleManager"
  },
  {systemName = "goalSystem"},
  {
    systemName = "playerManager"
  },
  {
    systemName = "scoreSystem"
  },
  {
    systemName = "localPlayerManager"
  },
  {systemName = "coopSystem"},
  {
    systemName = "onlineRaceManager"
  },
  {
    systemName = "controlHandler"
  },
  {
    systemName = "challengeLoading"
  },
  {
    systemName = "chapterBookendLoading"
  },
  {
    systemName = "chapterLoading"
  },
  {
    systemName = "endScreenLoading"
  },
  {
    systemName = "loadingSystem"
  },
  {
    systemName = "missionEndLoading"
  },
  {
    systemName = "missionStartLoading"
  },
  {
    systemName = "tutorialLoading"
  }
}
function runInitiators(isSessionHost)
  for i, initiateData in ipairs(initiators) do
    assert(_G[initiateData.systemName], "GAMESTATUS SCRIPTSYSTEMS - runInitiators: System '" .. tostring(initiateData.systemName) .. "' not found in global table.")
    local initiateFunc = _G[initiateData.systemName].initiate
    assert(initiateFunc, "GAMESTATUS SCRIPTSYSTEMS - runInitiators: System '" .. tostring(initiateData.systemName) .. "' doesn't have an initiate function")
    initiateFunc(isSessionHost)
  end
end
function registerUpdates()
  local sessionUpdates = updates.singlePlayer
  if Network.isOnlineGame() then
    sessionUpdates = updates.multiPlayer
  elseif Network.isSplitScreenMode() then
    sessionUpdates = updates.splitScreen
  end
  for i, updateData in ipairs(sessionUpdates) do
    assert(_G[updateData.systemName], "GAMESTATUS SCRIPTSYSTEMS - registerUpdates: System '" .. tostring(updateData.systemName) .. "' not found in global table.")
    local updateFunc = _G[updateData.systemName].update
    assert(updateFunc, "GAMESTATUS SCRIPTSYSTEMS - registerUpdates: System '" .. tostring(updateData.systemName) .. "' doesn't have an update function")
    addUserUpdateFunction(updateData.systemName, updateFunc, updateData.updateRate)
  end
end
function runPurges()
  print("runPurges")
  for i, purgeData in ipairs(purges) do
    assert(_G[purgeData.systemName], "GAMESTATUS SCRIPTSYSTEMS - runPurges: System '" .. tostring(purgeData.systemName) .. "' not found in global table.")
    local purgeFunc = _G[purgeData.systemName].purge
    assert(purgeFunc, "GAMESTATUS SCRIPTSYSTEMS - runPurges: System '" .. tostring(purgeData.systemName) .. "' doesn't have a purge function")
    purgeFunc()
  end
end
