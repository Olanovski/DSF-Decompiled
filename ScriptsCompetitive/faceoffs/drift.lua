faceOffData = faceOffData or {}
faceOffData.Drift = {}
faceOffData.Drift.usableRouteIndicies = {}
faceOffSystem.registerFaceOff("Drift", {
  endWillpowerMultiplier = 1,
  title = "Drift",
  prompt = "ID:169875",
  gridStyle = 1,
  moodStyle = 2,
  trafficSet = 0,
  areas = {
    [1] = {
      routeName = "RouteData\\MP_Qualifying_Drift01.lua",
      lockingZoneData = {
        name = "Online_Qualifying_Drift01"
      },
      vehicleSet = OnlineModeSettings.vehicleTypeDriftRally,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 160
    },
    [2] = {
      routeName = "RouteData\\MP_Qualifying_Drift02.lua",
      lockingZoneData = {
        name = "Online_Qualifying_Drift02"
      },
      vehicleSet = OnlineModeSettings.vehicleTypeDriftRally,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 160
    },
    [3] = {
      routeName = "RouteData\\MP_Qualifying_Drift03.lua",
      lockingZoneData = {
        name = "Online_Qualifying_Drift03"
      },
      vehicleSet = OnlineModeSettings.vehicleTypeDriftRally,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 160
    }
  },
  areaBuildFunctions = {
    [1] = function(area)
      area.target = routes["Qualifying Drift 01"].checkpoints[1].position
      area.positionA = routes["Qualifying Drift 01"].checkpoints[1].position
      area.headingA = routes["Qualifying Drift 01"].checkpoints[1].heading
    end,
    [2] = function(area)
      area.target = routes["Qualifying Drift 02"].checkpoints[1].position
      area.positionA = routes["Qualifying Drift 02"].checkpoints[1].position
      area.headingA = routes["Qualifying Drift 02"].checkpoints[1].heading
    end,
    [3] = function(area)
      area.target = routes["Qualifying Drift 03"].checkpoints[1].position
      area.positionA = routes["Qualifying Drift 03"].checkpoints[1].position
      area.headingA = routes["Qualifying Drift 03"].checkpoints[1].heading
    end
  },
  clearRouteFunction = function(area)
    area.target = nil
    area.positionA = nil
    area.headingA = nil
  end,
  betweenFeedbackDelay = 0,
  feedbackDisplayTime = 0.5,
  feedbackMultiplier = 1,
  marathonBVFeedback = false
}, {
  {
    {
      goal = "Agent in zap",
      params = {value = false}
    },
    {
      goal = "Is drifting",
      params = {}
    },
    {
      goal = "Time trigger",
      params = {value = 0.15}
    }
  }
}, function(instance)
  local release = function()
    localPlayer:blockAbility("zap", false)
    scoreSystem.setZapBlocked(0, 0)
  end
  local start = function()
    localPlayer:blockAbility("zap", true)
    for playerID, player in next, playerManager.players, nil do
      if player.currentVehicle then
        player.currentVehicle:set_damageMultiplier(0)
      end
    end
    scoreSystem.setZapBlocked(0, 1)
  end
  local playerJoining = function(player)
    if player.currentVehicle then
      player.currentVehicle:set_damageMultiplier(0)
    end
  end
  return nil, release, start, playerJoining
end)
