faceOffData = faceOffData or {}
faceOffData["Drive far"] = {}
faceOffData["Drive far"].usableRouteIndicies = {}
faceOffSystem.registerFaceOff("Marathon", {
  endWillpowerMultiplier = 1,
  title = "Drive far",
  prompt = "ID:169910",
  gridStyle = 1,
  moodStyle = 2,
  trafficSet = 0,
  areas = {
    [1] = {
      routeName = "RouteData\\MP_Qualifying_Distance01.lua",
      vehicleSet = OnlineModeSettings.vehicleTypeRoad,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 100,
      trafficExclusion = {
        [1] = {
          trigger = {
            position = vec.vector(-2476, 0, 3929, 1),
            length = 50,
            width = 50
          },
          exclusions = {
            [1] = {
              position = vec.vector(-3018, 0, 3950, 1),
              length = 50,
              width = 50
            }
          }
        }
      }
    },
    [2] = {
      routeName = "RouteData\\MP_Qualifying_Distance02.lua",
      vehicleSet = OnlineModeSettings.vehicleTypeRoad,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 100,
      trafficExclusion = {
        [1] = {
          trigger = {
            position = vec.vector(-1162, 0, -4553, 1),
            length = 50,
            width = 50
          },
          exclusions = {
            [1] = {
              position = vec.vector(-1200, 0, -4577, 1),
              length = 50,
              width = 50
            }
          }
        }
      }
    },
    [3] = {
      routeName = "RouteData\\MP_Qualifying_Distance03.lua",
      vehicleSet = OnlineModeSettings.vehicleTypeRoad,
      moods = OnlineModeSettings.onlineMoodsQualifying,
      maxPoints = 100,
      trafficExclusion = {
        [1] = {
          trigger = {
            position = vec.vector(-3917, 0, -2727, 1),
            length = 50,
            width = 50
          },
          exclusions = {
            [1] = {
              position = vec.vector(-4008, 0, -2716, 1),
              length = 50,
              width = 50
            }
          }
        }
      }
    }
  },
  areaBuildFunctions = {
    [1] = function(area)
      area.target = routes["Qualifying Distance 01"].checkpoints[1].position
      area.positionA = routes["Qualifying Distance 01"].checkpoints[1].position
      area.headingA = routes["Qualifying Distance 01"].checkpoints[1].heading
    end,
    [2] = function(area)
      area.target = routes["Qualifying Distance 02"].checkpoints[1].position
      area.positionA = routes["Qualifying Distance 02"].checkpoints[1].position
      area.headingA = routes["Qualifying Distance 02"].checkpoints[1].heading
    end,
    [3] = function(area)
      area.target = routes["Qualifying Distance 03"].checkpoints[1].position
      area.positionA = routes["Qualifying Distance 03"].checkpoints[1].position
      area.headingA = routes["Qualifying Distance 03"].checkpoints[1].heading
    end
  },
  clearRouteFunction = function(area)
    area.target = nil
    area.positionA = nil
    area.headingA = nil
  end,
  betweenFeedbackDelay = 0,
  feedbackDisplayTime = 1,
  feedbackMultiplier = 1,
  marathonBVFeedback = false
}, {
  {
    {
      goal = "Above speed",
      params = {value = 60}
    },
    {
      goal = "Agent in zap",
      params = {value = false}
    },
    {
      goal = "Distance travelled",
      params = {value = 25}
    }
  }
}, function(instance)
end)
