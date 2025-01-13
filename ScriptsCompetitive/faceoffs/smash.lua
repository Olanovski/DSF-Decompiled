faceOffData = faceOffData or {}
faceOffData["Smash props"] = {}
faceOffData["Smash props"].usableRouteIndicies = {}
faceOffSystem.registerFaceOff("Smash", {
  endWillpowerMultiplier = 1,
  title = "Smash props",
  prompt = "ID:169895",
  moodStyle = 2,
  trafficSet = -1,
  gridStagger = 0,
  areas = {
    [1] = {
      routeName = "RouteData\\MP_Qualifying_Props01.lua",
      gridStyle = 6,
      lockingZoneData = {
        name = "Online_Qualifying_Props01"
      },
      propData = {
        name = "QualifyingProps01",
        smashIcon = false,
        minimapIcon = true
      },
      vehicleSet = OnlineModeSettings.vehicleTypeMuscle,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 50
    },
    [2] = {
      routeName = "RouteData\\MP_Qualifying_Props02.lua",
      gridStyle = 6,
      lockingZoneData = {
        name = "Online_Qualifying_Props02"
      },
      propData = {
        name = "QualifyingProps02",
        smashIcon = false,
        minimapIcon = true
      },
      vehicleSet = OnlineModeSettings.vehicleTypeMuscle,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 50
    },
    [3] = {
      routeName = "RouteData\\MP_Qualifying_Props03.lua",
      gridStyle = 3,
      lockingZoneData = {
        name = "Online_Qualifying_Props03"
      },
      propData = {
        name = "QualifyingProps03",
        smashIcon = false,
        minimapIcon = true
      },
      vehicleSet = OnlineModeSettings.vehicleTypeMuscle,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 50
    }
  },
  areaBuildFunctions = {
    [1] = function(area)
      area.positionA = routes["Qualifying Props 01"].checkpoints[1].position
      area.headingA = routes["Qualifying Props 01"].checkpoints[1].heading
      area.positionB = routes["Qualifying Props 01"].checkpoints[2].position
      area.headingB = routes["Qualifying Props 01"].checkpoints[2].heading
      area.positionC = routes["Qualifying Props 01"].checkpoints[3].position
      area.headingC = routes["Qualifying Props 01"].checkpoints[3].heading
      area.positionD = routes["Qualifying Props 01"].checkpoints[4].position
      area.headingD = routes["Qualifying Props 01"].checkpoints[4].heading
      area.target = routes["Qualifying Props 01"].checkpoints[5].position
    end,
    [2] = function(area)
      area.positionA = routes["Qualifying Props 02"].checkpoints[1].position
      area.headingA = routes["Qualifying Props 02"].checkpoints[1].heading
      area.positionB = routes["Qualifying Props 02"].checkpoints[2].position
      area.headingB = routes["Qualifying Props 02"].checkpoints[2].heading
      area.positionC = routes["Qualifying Props 02"].checkpoints[3].position
      area.headingC = routes["Qualifying Props 02"].checkpoints[3].heading
      area.positionD = routes["Qualifying Props 02"].checkpoints[4].position
      area.headingD = routes["Qualifying Props 02"].checkpoints[4].heading
      area.target = routes["Qualifying Props 02"].checkpoints[5].position
    end,
    [3] = function(area)
      area.positionA = routes["Qualifying Props 03"].arrows[1].position
      area.headingA = routes["Qualifying Props 03"].arrows[1].heading
      area.positionB = routes["Qualifying Props 03"].arrows[2].position
      area.headingB = routes["Qualifying Props 03"].arrows[2].heading
      area.target = routes["Qualifying Props 03"].arrows[3].position
    end
  },
  clearRouteFunction = function(area)
    area.positionA = nil
    area.headingA = nil
    area.positionB = nil
    area.headingB = nil
    area.positionC = nil
    area.headingC = nil
    area.positionD = nil
    area.headingD = nil
    area.target = nil
  end,
  betweenFeedbackDelay = 0,
  feedbackDisplayTime = 1,
  feedbackMultiplier = 1,
  marathonBVFeedback = false
}, {
  {
    {
      goal = "MP Hit prop",
      params = {value = 1}
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
