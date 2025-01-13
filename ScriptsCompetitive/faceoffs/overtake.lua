faceOffData = faceOffData or {}
faceOffData["Overtake cars"] = {}
faceOffData["Overtake cars"].usableRouteIndicies = {}
faceOffSystem.registerFaceOff("overtake", {
  endWillpowerMultiplier = 1,
  title = "Overtake cars",
  prompt = "ID:169893",
  gridStyle = 1,
  moodStyle = 2,
  trafficSet = 0,
  areas = {
    [1] = {
      routeName = "RouteData\\MP_Qualifying_Overtake01.lua",
      vehicleSet = OnlineModeSettings.vehicleTypeRoad,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 50
    },
    [2] = {
      routeName = "RouteData\\MP_Qualifying_Overtake02.lua",
      vehicleSet = OnlineModeSettings.vehicleTypeRoad,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 50
    },
    [3] = {
      routeName = "RouteData\\MP_Qualifying_Overtake03.lua",
      vehicleSet = OnlineModeSettings.vehicleTypeRoad,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 50
    }
  },
  areaBuildFunctions = {
    [1] = function(area)
      area.target = routes["Qualifying Overtake 01"].checkpoints[1].position
      area.positionA = routes["Qualifying Overtake 01"].checkpoints[1].position
      area.headingA = routes["Qualifying Overtake 01"].checkpoints[1].heading
    end,
    [2] = function(area)
      area.target = routes["Qualifying Overtake 02"].checkpoints[1].position
      area.positionA = routes["Qualifying Overtake 02"].checkpoints[1].position
      area.headingA = routes["Qualifying Overtake 02"].checkpoints[1].heading
    end,
    [3] = function(area)
      area.target = routes["Qualifying Overtake 03"].checkpoints[1].position
      area.positionA = routes["Qualifying Overtake 03"].checkpoints[1].position
      area.headingA = routes["Qualifying Overtake 03"].checkpoints[1].heading
    end
  },
  clearRouteFunction = function(area)
    area.target = nil
    area.positionA = nil
    area.headingA = nil
  end,
  betweenFeedbackDelay = 0,
  feedbackDisplayTime = 2,
  feedbackMultiplier = 1,
  marathonBVFeedback = false
}, {
  {
    {
      goal = "Agent in zap",
      params = {value = false}
    },
    {
      goal = "Overtakes",
      params = {value = 1}
    }
  }
}, function(instance)
end)
