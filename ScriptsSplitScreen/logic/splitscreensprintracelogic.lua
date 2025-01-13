module("cardSystem.logic")
missionSetupData["Multiplayer sprint race"] = {}
missionSetupData["Multiplayer sprint race"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 01"].roads
    spawnPosition.route = routes["Sprint Race 01"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 01"].arrows
    spawnPosition.target = routes["Sprint Race Start 01"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 01"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 01"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 01"].roads
  end,
  [2] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 02"].roads
    spawnPosition.route = routes["Sprint Race 02"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 02"].arrows
    spawnPosition.target = routes["Sprint Race Start 02"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 02"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 02"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 02"].roads
  end,
  [3] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 03"].roads
    spawnPosition.route = routes["Sprint Race 03"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 03"].arrows
    spawnPosition.target = routes["Sprint Race Start 03"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 03"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 03"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 03"].roads
  end,
  [4] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 04"].roads
    spawnPosition.route = routes["Sprint Race 04"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 04"].arrows
    spawnPosition.target = routes["Sprint Race Start 04"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 04"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 04"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 04"].roads
  end,
  [5] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 05"].roads
    spawnPosition.route = routes["Sprint Race 05"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 05"].arrows
    spawnPosition.target = routes["Sprint Race Start 05"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 05"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 05"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 05"].roads
  end,
  [6] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 06"].roads
    spawnPosition.route = routes["Sprint Race 06"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 06"].arrows
    spawnPosition.target = routes["Sprint Race Start 06"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 06"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 06"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 06"].roads
  end,
  [7] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 07"].roads
    spawnPosition.route = routes["Sprint Race 07"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 07"].arrows
    spawnPosition.target = routes["Sprint Race Start 07"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 07"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 07"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 07"].roads
  end,
  [8] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 08"].roads
    spawnPosition.route = routes["Sprint Race 08"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 08"].arrows
    spawnPosition.target = routes["Sprint Race Start 08"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 08"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 08"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 08"].roads
  end,
  [9] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 09"].roads
    spawnPosition.route = routes["Sprint Race 09"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 09"].arrows
    spawnPosition.target = routes["Sprint Race Start 09"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 09"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 09"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 09"].roads
  end,
  [10] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 10"].roads
    spawnPosition.route = routes["Sprint Race 10"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 10"].arrows
    spawnPosition.target = routes["Sprint Race Start 10"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 10"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 10"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 10"].roads
  end,
  [11] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 11"].roads
    spawnPosition.route = routes["Sprint Race 11"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 11"].arrows
    spawnPosition.target = routes["Sprint Race Start 11"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 11"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 11"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 11"].roads
  end,
  [12] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 12"].roads
    spawnPosition.route = routes["Sprint Race 12"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 12"].arrows
    spawnPosition.target = routes["Sprint Race Start 12"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 12"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 12"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 12"].roads
  end,
  [13] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 13"].roads
    spawnPosition.route = routes["Sprint Race 13"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 13"].arrows
    spawnPosition.target = routes["Sprint Race Start 13"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 13"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 13"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 13"].roads
  end,
  [14] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 14"].roads
    spawnPosition.route = routes["Sprint Race 14"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 14"].arrows
    spawnPosition.target = routes["Sprint Race Start 14"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 14"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 14"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 14"].roads
  end,
  [15] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 15"].roads
    spawnPosition.route = routes["Sprint Race 15"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 15"].arrows
    spawnPosition.target = routes["Sprint Race Start 15"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 15"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 15"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 15"].roads
  end,
  [16] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 16"].roads
    spawnPosition.route = routes["Sprint Race 16"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 16"].arrows
    spawnPosition.target = routes["Sprint Race Start 16"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 16"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 16"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 16"].roads
  end,
  [17] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 17"].roads
    spawnPosition.route = routes["Sprint Race 17"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 17"].arrows
    spawnPosition.target = routes["Sprint Race Start 17"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 17"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 17"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 17"].roads
  end,
  [18] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 18"].roads
    spawnPosition.route = routes["Sprint Race 18"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 18"].arrows
    spawnPosition.target = routes["Sprint Race Start 18"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 18"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 18"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 18"].roads
  end,
  [19] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 19"].roads
    spawnPosition.route = routes["Sprint Race 19"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 19"].arrows
    spawnPosition.target = routes["Sprint Race Start 19"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 19"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 19"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 19"].roads
  end,
  [20] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 20"].roads
    spawnPosition.route = routes["Sprint Race 20"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 20"].arrows
    spawnPosition.target = routes["Sprint Race Start 20"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 20"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 20"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 20"].roads
  end,
  [21] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 21"].roads
    spawnPosition.route = routes["Sprint Race 21"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 21"].arrows
    spawnPosition.target = routes["Sprint Race Start 21"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 21"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 21"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 21"].roads
  end,
  [22] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 22"].roads
    spawnPosition.route = routes["Sprint Race 22"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 22"].arrows
    spawnPosition.target = routes["Sprint Race Start 22"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 22"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 22"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 22"].roads
  end,
  [23] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 23"].roads
    spawnPosition.route = routes["Sprint Race 23"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 23"].arrows
    spawnPosition.target = routes["Sprint Race Start 23"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 23"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 23"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 23"].roads
  end,
  [24] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 24"].roads
    spawnPosition.route = routes["Sprint Race 24"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 24"].arrows
    spawnPosition.target = routes["Sprint Race Start 24"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 24"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 24"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 24"].roads
  end,
  [25] = function(spawnPosition)
    spawnPosition.roads = routes["Sprint Race 25"].roads
    spawnPosition.route = routes["Sprint Race 25"].checkpoints
    spawnPosition.arrows = routes["Sprint Race 25"].arrows
    spawnPosition.target = routes["Sprint Race Start 25"].checkpoints[1].position
    spawnPosition.positionA = routes["Sprint Race Start 25"].checkpoints[1].position
    spawnPosition.headingA = routes["Sprint Race Start 25"].checkpoints[1].heading
    spawnPosition.endTargetRoads = routes["Sprint Race Target 25"].roads
  end
}
missionSetupData["Multiplayer sprint race"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.roads = nil
  spawnPosition.route = nil
  spawnPosition.arrows = nil
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
  spawnPosition.endTargetRoads = nil
end
missionSetupData["Multiplayer sprint race"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\MP_SprintRace01.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeMixed,
    moods = {
      [1] = "OnlineTheDriver"
    },
    trafficSet = 6
  },
  [2] = {
    routeName = "RouteData\\MP_SprintRace02.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = {
      [1] = "OnlineJerichoLite"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace02"
    }
  },
  [3] = {
    routeName = "RouteData\\MP_SprintRace03.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = {
      [1] = "OnlineLAConnection"
    },
    trafficSet = -1
  },
  [4] = {
    routeName = "RouteData\\MP_SprintRace04.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeMixed,
    moods = {
      [1] = "OnlineVanishing"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace04"
    },
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(-2355, 32, 257, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(-2533, 36, 304, 1),
            length = 175,
            width = 175
          },
          [2] = {
            position = vec.vector(-2426, 30, 22, 1),
            length = 225,
            width = 225
          }
        }
      }
    }
  },
  [5] = {
    routeName = "RouteData\\MP_SprintRace05.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRally,
    moods = {
      [1] = "OnlineDukes"
    },
    trafficSet = -1,
    propData = {
      name = "SprintRace05"
    }
  },
  [6] = {
    routeName = "RouteData\\MP_SprintRace06.lua",
    vehicleSet = OnlineModeSettings.vehicleTypePureRally,
    moods = {
      [1] = "OnlineEscape"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace06"
    }
  },
  [7] = {
    routeName = "RouteData\\MP_SprintRace07.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeMuscle,
    moods = {
      [1] = "OnlineBlues"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace07"
    },
    {
      [1] = {
        trigger = {
          position = vec.vector(-1131, 56, 1463, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(-1082, 56, 1370, 1),
            length = 125,
            width = 125
          },
          [2] = {
            position = vec.vector(-1036, 56, 1549, 1),
            length = 125,
            width = 125
          }
        }
      }
    }
  },
  [8] = {
    routeName = "RouteData\\MP_SprintRace08.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = {
      [1] = "OnlineComa"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace08"
    },
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(560, 20, 770, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(454, 33, 759, 1),
            length = 130,
            width = 130
          },
          [2] = {
            position = vec.vector(690, 17, 714, 1),
            length = 175,
            width = 175
          }
        }
      }
    }
  },
  [9] = {
    routeName = "RouteData\\MP_SprintRace09.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRally,
    moods = {
      [1] = "OnlineDukes"
    },
    trafficSet = -1
  },
  [10] = {
    routeName = "RouteData\\MP_SprintRace10.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeMixed,
    moods = {
      [1] = "OnlineBullitt"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace10"
    },
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(-3390, 42, 574, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(-3298, 45, 514, 1),
            length = 120,
            width = 120
          },
          [2] = {
            position = vec.vector(-3447, 60, 688, 1),
            length = 150,
            width = 150
          }
        }
      }
    }
  },
  [11] = {
    routeName = "RouteData\\MP_SprintRace11.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRally,
    moods = {
      [1] = "OnlineLAConnection"
    },
    trafficSet = -1,
    propData = {
      name = "SprintRace11"
    }
  },
  [12] = {
    routeName = "RouteData\\MP_SprintRace12.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeMixed,
    moods = {
      [1] = "OnlineComa"
    },
    trafficSet = 6
  },
  [13] = {
    routeName = "RouteData\\MP_SprintRace13.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeMixed,
    moods = {
      [1] = "OnlineFog"
    },
    trafficSet = -1,
    propData = {
      name = "SprintRace13"
    }
  },
  [14] = {
    routeName = "RouteData\\MP_SprintRace14.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = {
      [1] = "OnlineVanishing"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace14"
    },
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(-4330, 16, 1969, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(-4225, 21, 1845, 1),
            length = 150,
            width = 150
          },
          [2] = {
            position = vec.vector(-4428, 18, 1858, 1),
            length = 150,
            width = 150
          }
        }
      }
    }
  },
  [15] = {
    routeName = "RouteData\\MP_SprintRace15.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeMuscle,
    moods = {
      [1] = "OnlineBullitt"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace15"
    }
  },
  [16] = {
    routeName = "RouteData\\MP_SprintRace16.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeMuscle,
    moods = {
      [1] = "OnlineTheDriver"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace16"
    }
  },
  [17] = {
    routeName = "RouteData\\MP_SprintRace17.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = {
      [1] = "OnlineDefault"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace17"
    }
  },
  [18] = {
    routeName = "RouteData\\MP_SprintRace18.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeMixedRally,
    moods = {
      [1] = "OnlineJerichoLite"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace18"
    }
  },
  [19] = {
    routeName = "RouteData\\MP_SprintRace19.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = {
      [1] = "OnlineFog"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace19"
    },
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(-493, 0, 999, 1),
          length = 150,
          width = 150
        },
        exclusions = {
          [1] = {
            position = vec.vector(-465, 0, 901, 1),
            length = 300,
            width = 300
          }
        }
      }
    }
  },
  [20] = {
    routeName = "RouteData\\MP_SprintRace20.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = {
      [1] = "OnlineLAConnection"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace21"
    },
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(448, 10, 3699, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(520, 10, 3582, 1),
            length = 180,
            width = 180
          },
          [2] = {
            position = vec.vector(521, 10, 3847, 1),
            length = 180,
            width = 180
          }
        }
      }
    }
  },
  [21] = {
    routeName = "RouteData\\MP_SprintRace21.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeMuscle,
    moods = {
      [1] = "OnlineBullitt"
    },
    trafficSet = 6,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(628, 10, 1304, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(615, 10, 1147, 1),
            length = 140,
            width = 140
          },
          [2] = {
            position = vec.vector(781, 10, 1304, 1),
            length = 100,
            width = 100
          }
        }
      }
    }
  },
  [22] = {
    routeName = "RouteData\\MP_SprintRace22.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeMixed,
    moods = {
      [1] = "OnlineCannonBall"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace22"
    }
  },
  [23] = {
    routeName = "RouteData\\MP_SprintRace23.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = {
      [1] = "OnlineWhiteStripe"
    },
    trafficSet = 6
  },
  [24] = {
    routeName = "RouteData\\MP_SprintRace24.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeMuscle,
    moods = {
      [1] = "OnlineTheDriver"
    },
    trafficSet = 6
  },
  [25] = {
    routeName = "RouteData\\MP_SprintRace25.lua",
    vehicleSet = OnlineModeSettings.vehicleTypeRoad,
    moods = {
      [1] = "OnlineComa"
    },
    trafficSet = 6,
    trafficExclusion = {
      [1] = {
        trigger = {
          position = vec.vector(178, 68, 274, 1),
          length = 50,
          width = 50
        },
        exclusions = {
          [1] = {
            position = vec.vector(78, 35, 412, 1),
            length = 150,
            width = 150
          },
          [2] = {
            position = vec.vector(15, 36, 197, 1),
            length = 175,
            width = 175
          }
        }
      }
    }
  }
}
missionSetupData["Multiplayer sprint race"].usableRouteIndicies = {
  [1] = {
    5,
    6,
    9,
    11,
    13,
    18
  },
  [2] = {
    1,
    8,
    10,
    14,
    17,
    23
  },
  [3] = {
    3,
    7,
    15,
    19,
    20,
    21
  },
  [4] = {
    1,
    3,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    13,
    14,
    15,
    17,
    18,
    19,
    20,
    21,
    23
  }
}
mpSprintRaceTimeLimit = 60
local roundScores = {
  [1] = {
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false
  },
  [2] = {
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false
  }
}
local playerTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "No target",
        HUD = {
          {
            style = "MP Sprint Race HUD"
          }
        }
      },
      [2] = {
        task = "Payload Tracking",
        specialName = "score"
      }
    }
  }
end
local vehicleTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "Linear Checkpoints No AI",
        specialName = "checkpoints",
        dynamicTargets = true,
        coreData = {totalLaps = 0},
        goalConditions = {
          {
            {
              goal = "MP Crossed Checkpoint"
            },
            {
              goal = "SS race score event",
              params = {numCheckpoints = 10}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {coreValue = "totalLaps"}
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                ["Checkpoint Gate"] = {noneSyncronisedCheckpoint = true, multiplayerRace = true}
              }
            }
          }
        }
      }
    }
  }
end
missionSetupData["Multiplayer sprint race"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = vehicleTasks,
  ["Player Pool"] = playerTasks
}
missionSetupData["Multiplayer sprint race"].stepHighlightColours = function(instance)
  if not instance.playersColours then
    instance.playersColours = true
    Menu.SetPlayerColour(0, OnlineModeSettings.blue128)
    Menu.SetPlayerColour(1, OnlineModeSettings.orange128)
  end
end
missionSetupData["Multiplayer sprint race"].missionCompleteData = function()
  if localPlayer.getTaskObject() and localPlayer.getTaskObject().coreData then
    local instance = localPlayer.getTaskObject().coreData.instance
    local topScore = 30
    local bronze = 20 / topScore * 100
    local silver = 24 / topScore * 100
    local gold = 27 / topScore * 100
    if instance then
      for i = 1, 2 do
        local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
        if taskObject and taskObject.namedTasks.score then
          local totalScore = instance.playerScores[taskObject.coreData.agent.playerID + 1]
          local prevScore = taskObject.namedTasks.score.networkVars.payload
          local roundScore = totalScore - prevScore
          local round = instance.networkVars.roundOn
          onlineScreenManager.updatePlayerScore(taskObject.coreData.agent.playerID, totalScore)
          onlineScreenManager.updatePlayerRoundScore(taskObject.coreData.agent.playerID, roundScore)
        end
        local objTaskObj = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
        if objTaskObj and objTaskObj.namedTasks.checkpoints then
          roundScores[i][instance.networkVars.roundOn] = objTaskObj.namedTasks.checkpoints.networkVars.checkpoints - 1 + objTaskObj.namedTasks.checkpoints.networkVars.laps * 10
        end
      end
      for i = 1, instance.playerScores[1] do
        feedbackSystem.splitScreenSupport.setRoundWinMarkerHiddenWin(0, i)
      end
      for i = 1, instance.playerScores[2] do
        feedbackSystem.splitScreenSupport.setRoundWinMarkerHiddenWin(1, i)
      end
      local roundNum = 0
      for i, round in ipairs(roundScores[1]) do
        if round then
          roundNum = roundNum + 1
        end
      end
      onlineScreenManager.setSSModeCompDataTable(topScore, bronze, silver, gold, false, true, true, instance.networkVars.roundOn == instance.challenge.settings.numRounds, roundNum)
      if instance.networkVars.roundOn == instance.challenge.settings.numRounds then
        local sortFunc = function(scoreA, scoreB)
          if not scoreA then
            return false
          end
          if not scoreB then
            return true
          end
          return scoreB < scoreA
        end
        table.sort(roundScores[1], sortFunc)
        table.sort(roundScores[2], sortFunc)
        assert(roundScores[1][2] and roundScores[1][1] and roundScores[1][3], "Error in calcualting P1 best of 3 rounds score " .. tostring(roundScores[1][1]) .. "  " .. tostring(roundScores[1][2]) .. "  " .. tostring(roundScores[1][3]))
        assert(roundScores[2][2] and roundScores[2][1] and roundScores[2][3], "Error in calcualting P2 best of 3 rounds score " .. tostring(roundScores[2][1]) .. "  " .. tostring(roundScores[2][2]) .. "  " .. tostring(roundScores[2][3]))
        onlineScreenManager.updatePlayerSecondaryScore(0, roundScores[1][1] + roundScores[1][2] + roundScores[1][3])
        onlineScreenManager.updatePlayerSecondaryScore(1, roundScores[2][1] + roundScores[2][2] + roundScores[2][3])
      end
    end
    onlineScreenManager.setForceSortType(onlineScreenManager.screenSortTypes.round)
  end
end
missionSetupData["Multiplayer sprint race"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 2,
      numRounds = 5,
      gridStyle = 1,
      gridSortStyle = onlineScreenManager.screenSortTypes.reverseRnd,
      missionVehicleStyle = 1,
      moodStyle = 2,
      trackPlayerScores = true,
      spoolStartArea = true,
      persistantScore = "score",
      presetRouteIndex = true,
      raceMode = true,
      zapLock = true,
      introHUD = "MP Sprint Race Start HUD",
      disableZapOnCompletion = true,
      modeTimeLimit = mpSprintRaceTimeLimit,
      gridStagger = 0
    }
  }
end
missionSetupData["Multiplayer sprint race"].assignTaskObjects = function(instance, player, vehicle)
  if player then
    local actor = instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[player.playerID + 1]]
    instance:newActorFromAgent(actor.ID, vehicle)
  else
    for playerID, player in next, playerManager.players, nil do
      if not instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]] then
        local vehicle = vehicleManager.vehiclesBySNVID[phaseManager.vehicleGrid[playerID + 1]]
        assert(vehicle.networkVars.onlineOwnerID == playerID, "SPRINT RACE, Creating taskObject for invalid vehicle")
        local actor = instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]]
        instance:newActorFromAgent(actor.ID, vehicle)
      end
    end
  end
end
missionSetupData["Multiplayer sprint race"].missionEnd = function(instance)
  feedbackSystem.menusMaster.blockDamageBar(localPlayerManager.players[0], false)
  feedbackSystem.menusMaster.blockDamageBar(localPlayerManager.players[1], false)
end
missionSetupData["Multiplayer sprint race"].missionStart = function(instance)
  local routeIndex = instance.networkVars.routeIndex
  local route = instance.challenge.spawnPositions[routeIndex].route
  checkpointSystem.clearNoneSyncronisedCheckpoint()
  for i, checkpointData in ipairs(route) do
    checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, 1, checkpointData)
  end
  for localPlayerID, player in next, localPlayerManager.players, nil do
    player.currentVehicle.gameVehicle.maxAllowedDamage = 0.74
    if localPlayerID == 0 then
      player.currentVehicle:setDisplayColour(OnlineModeSettings.blue32, OnlineModeSettings.blue128)
    else
      player.currentVehicle:setDisplayColour(OnlineModeSettings.orange32, OnlineModeSettings.orange128)
    end
  end
  if instance.networkVars.roundOn == 1 then
    roundScores[1][1] = false
    roundScores[1][2] = false
    roundScores[1][3] = false
    roundScores[1][4] = false
    roundScores[1][5] = false
    roundScores[2][1] = false
    roundScores[2][2] = false
    roundScores[2][3] = false
    roundScores[2][4] = false
    roundScores[2][5] = false
  end
end
missionSetupData["Multiplayer sprint race"].modeReadyCheck = function(instance)
  for localPlayerID, player in next, localPlayerManager.players, nil do
    local racerTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[localPlayerID + 1]]
    if not racerTO then
      return false
    end
    if racerTO and not racerTO.coreData.agent then
      return false
    end
  end
  return true
end
missionSetupData["Multiplayer sprint race"].update = function(instance)
end
taskCompleteData["Multiplayer sprint race"] = {}
local taskCompleteFired = false
taskCompleteData["Multiplayer sprint race"].taskComplete = function(taskObject, task)
  if task.taskName == "Linear Checkpoints No AI" then
    onlineRaceManager.sendLockPlayersPosition()
    for id, player in next, localPlayerManager.players, nil do
      scoreSystem.stopAbilityDrain(player.localID, false)
    end
    if taskObject.coreData.instance.isLocal and task.agent.isLocal then
      if task.agent == localPlayer.currentVehicle then
        for i = 1, 2 do
          local playerTO = task.instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
          local vehicleTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
          if playerTO and vehicleTO then
            local playerPosition = onlineRaceManager.getPlayerRank(playerTO.coreData.agent.playerID)
            if playerPosition == 1 then
              task.instance.playerScores[i] = task.instance.playerScores[i] + 1
              if task.instance.playerScores[i] == 3 then
                task.instance.networkVars.roundOn = task.instance.challenge.settings.numRounds
              end
            end
          end
        end
      end
      taskObject.coreData.instance:initiateOverTimePhase()
    end
  end
end
local getRaceVehicleDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(taskObject.coreData.instance.instanceID, 1)
  if dynamicListID then
    if task.networkVars.checkpoints < #allCheckpoints then
      return {
        allCheckpoints[task.networkVars.checkpoints + 1]
      }, false
    else
      return {
        allCheckpoints[1]
      }, true
    end
  else
    return {
      allCheckpoints[task.networkVars.checkpoints]
    }, false
  end
end
missionSetupData["Multiplayer sprint race"].targetList = {
  ["Objective Team 1"] = getRaceVehicleDynamicTargets
}
