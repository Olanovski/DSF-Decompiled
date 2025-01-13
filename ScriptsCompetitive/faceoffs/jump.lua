faceOffData = faceOffData or {}
faceOffData.Air = {}
faceOffData.Air.usableRouteIndicies = {}
faceOffSystem.registerFaceOff("jump", {
  endWillpowerMultiplier = 1,
  title = "Air",
  prompt = "ID:169873",
  gridStyle = 1,
  moodStyle = 2,
  trafficSet = 5,
  areas = {
    [1] = {
      routeName = "RouteData\\MP_Qualifying_Jump01.lua",
      lockingZoneData = {
        name = "Online_Qualifying_Jump01"
      },
      vehicleSet = OnlineModeSettings.vehicleTypeRoad,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      propData = {
        name = "QualifyingJump01"
      },
      maxPoints = 110
    },
    [2] = {
      routeName = "RouteData\\MP_Qualifying_Jump02.lua",
      lockingZoneData = {
        name = "Online_Qualifying_Jump02"
      },
      vehicleSet = OnlineModeSettings.vehicleTypeRoad,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 90
    },
    [3] = {
      routeName = "RouteData\\MP_Qualifying_Jump03.lua",
      lockingZoneData = {
        name = "Online_Qualifying_Jump03"
      },
      propData = {
        name = "QualifyingJump03"
      },
      vehicleSet = OnlineModeSettings.vehicleTypeRoad,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 130
    }
  },
  areaBuildFunctions = {
    [1] = function(area)
      area.target = routes["Qualifying Jump 01"].checkpoints[1].position
      area.positionA = routes["Qualifying Jump 01"].checkpoints[1].position
      area.headingA = routes["Qualifying Jump 01"].checkpoints[1].heading
    end,
    [2] = function(area)
      area.target = routes["Qualifying Jump 02"].checkpoints[1].position
      area.positionA = routes["Qualifying Jump 02"].checkpoints[1].position
      area.headingA = routes["Qualifying Jump 02"].checkpoints[1].heading
    end,
    [3] = function(area)
      area.target = routes["Qualifying Jump 03"].checkpoints[1].position
      area.positionA = routes["Qualifying Jump 03"].checkpoints[1].position
      area.headingA = routes["Qualifying Jump 03"].checkpoints[1].heading
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
      goal = "Is jumping",
      params = {value = true}
    },
    {
      goal = "Time trigger",
      params = {value = 0.1}
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
