module("cardSystem.logic")
missionSetupData["Multiplayer sprint race"] = {}
mpSprintRaceScoreTable = {
  [1] = {10},
  [2] = {10, 5},
  [3] = {
    10,
    5,
    3
  },
  [4] = {
    10,
    5,
    3,
    2
  },
  [5] = {
    10,
    7,
    4,
    2,
    2
  },
  [6] = {
    10,
    7,
    5,
    4,
    2,
    2
  },
  [7] = {
    10,
    8,
    6,
    4,
    3,
    2,
    2
  },
  [8] = {
    10,
    8,
    6,
    5,
    4,
    3,
    2,
    2
  }
}
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
    trafficExclusion = {
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
    vehicleSet = OnlineModeSettings.vehicleTypePureRally,
    moods = {
      [1] = "OnlineComa"
    },
    trafficSet = 6,
    propData = {
      name = "SprintRace12"
    }
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
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8,
  [9] = 9,
  [10] = 10,
  [11] = 11,
  [12] = 12,
  [13] = 13,
  [14] = 14,
  [15] = 15,
  [16] = 16,
  [17] = 17,
  [18] = 18,
  [19] = 19,
  [20] = 20,
  [21] = 21,
  [22] = 22,
  [23] = 23,
  [24] = 24,
  [25] = 25
}
mpSprintRaceTimeLimit = 45
mpSprintRaceEndTimeLimit = 15
mpSprintRaceNumRounds = 0
local playerTasks = function(goalParams, HUDFile)
  return {
    [1] = {
      [1] = {
        task = "MP race end",
        coreData = {stdRace = false, playerTO = false},
        goalConditions = {
          {
            {
              goal = "MP Player 2 Active",
              params = {value = false}
            },
            {
              goal = "Race finished",
              params = {value = true, playerTO = false}
            },
            {
              goal = "Race end screen set",
              params = {value = false}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "MP Player 2 Active",
              params = {value = false}
            },
            {
              goal = "Race end screen set",
              params = {value = true}
            }
          },
          {
            {
              goal = "MP Player 2 Active",
              params = {value = true}
            },
            {
              goal = "Race finished",
              params = {value = true, playerTO = false}
            }
          }
        },
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
    },
    [2] = {
      [1] = {
        task = "MP race end timer",
        specialName = "overTime",
        goalConditions = {
          {
            {
              goal = "End race timer set",
              params = {value = false}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "End race timer set",
              params = {value = true}
            },
            {
              goal = "End race time above",
              params = {value = mpSprintRaceEndTimeLimit}
            }
          },
          {
            {
              goal = "All players finished race",
              params = {playerTO = false}
            }
          }
        }
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
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {coreValue = "totalLaps"}
            }
          },
          {
            {
              goal = "Instance start time valid"
            },
            {
              goal = "Instance time above",
              params = {value = mpSprintRaceTimeLimit}
            }
          },
          {
            {
              goal = "End race timer set",
              params = {value = true}
            },
            {
              goal = "End race time above",
              params = {value = mpSprintRaceEndTimeLimit}
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
missionSetupData["Multiplayer sprint race"].onlineProgressionData = {
  localPlayer = {
    {
      autoRefresh = true,
      progressionData = {
        exp = onlineProgressionSystem.sprintRaceCheckpointXP,
        completeText = "ID:243727",
        minShowXP = 0,
        groupXP = true,
        groupLimit = 3
      },
      {
        goal = "Checkpoint crossed",
        params = {value = true}
      }
    },
    getMatchBonus = function(timeInMode, threshold, baseXPValue, gainedXP)
      local playerRank = 1
      local playerRankMultiplier = 0
      local playerTO = localPlayer.getTaskObject()
      if playerTO and playerTO.coreData.instance then
        local instance = playerTO.coreData.instance
        local localPlayerScore = instance.playerScores[localPlayer.playerID + 1]
        for i = 1, 8 do
          if localPlayer.playerID + 1 ~= i and playerManager.players[i - 1] and localPlayerScore < instance.playerScores[i] then
            playerRank = playerRank + 1
          end
        end
      end
      if playerRank and playerRank <= 8 then
        playerRankMultiplier = onlineProgressionSystem.onlineRaceRankMultiplier[playerRank]
      end
      local matchBonus = timeInMode * baseXPValue * playerRankMultiplier
      if gainedXP < threshold then
        return math.max(gainedXP / threshold, onlineProgressionSystem.minimumPercentMatchBonus) * matchBonus
      end
      return matchBonus
    end
  }
}
missionSetupData["Multiplayer sprint race"].stepHighlightColours = function(instance)
  if not instance.playersColours then
    instance.playersColours = {
      [1] = {playerColourSet = false, ID = -1},
      [2] = {playerColourSet = false, ID = -1},
      [3] = {playerColourSet = false, ID = -1},
      [4] = {playerColourSet = false, ID = -1},
      [5] = {playerColourSet = false, ID = -1},
      [6] = {playerColourSet = false, ID = -1},
      [7] = {playerColourSet = false, ID = -1},
      [8] = {playerColourSet = false, ID = -1}
    }
    for playerID, player in next, playerManager.players, nil do
      Menu.SetPlayerColour(player.playerID, OnlineModeSettings.pink128)
    end
  end
  for playerID, data in next, instance.playersColours, nil do
    if data.ID ~= -1 and (not vehicleManager.vehiclesBySNVID[data.ID] or not playerManager.players[playerID - 1]) then
      data.ID = -1
      data.playerColourSet = false
    end
  end
  for playerID, player in next, playerManager.players, nil do
    if not instance.playersColours[player.playerID + 1].playerColourSet then
      Menu.SetPlayerColour(player.playerID, OnlineModeSettings.red128)
      instance.playersColours[player.playerID + 1].playerColourSet = true
    end
    if player.currentVehicle and playerID ~= localPlayer.playerID then
      if instance.playersColours[player.playerID + 1].ID == -1 then
        instance.playersColours[player.playerID + 1].ID = player.currentVehicle.SNVID
        player.currentVehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
      elseif instance.playersColours[player.playerID + 1].ID ~= player.currentVehicle.SNVID then
        instance.playersColours[player.playerID + 1].ID = player.currentVehicle.SNVID
        player.currentVehicle:setDisplayColour(OnlineModeSettings.red32, OnlineModeSettings.red128)
      end
    end
  end
end
missionSetupData["Multiplayer sprint race"].onlineStatisticsData = function(syncedScoreTable, instance, additionalSyncData)
  if instance.networkVars.roundOn == instance.challenge.settings.numRounds then
    local localPlayerScore = syncedScoreTable[localPlayer.playerID]
    local rank = 1
    local opponentScore = 0
    for playerID, players in next, playerManager.players, nil do
      if playerID ~= localPlayer.playerID then
        opponentScore = syncedScoreTable[playerID]
        if localPlayerScore < opponentScore then
          rank = rank + 1
        end
      end
    end
    assert(rank and rank > 0 and rank < 9, "Sprint Race Statistic Gen Error: Race position must be between [0,8], value " .. tostring(rank))
    local winValue = onlineStatistics.getWinStatistic()
    local lossValue = onlineStatistics.getLossStatistic()
    local specific = onlineStatistics.getSpecificStatistic()
    onlineStatistics.updateSpecificStatistic(specific * -1)
    local numOfRaces = winValue + lossValue
    assert(numOfRaces > 0, "Sprint Race Statistic Gen Error: Number of races should be at least 1 as you just completed a Race: " .. tostring(winValue) .. "  " .. tostring(lossValue))
    local positionTotal = specific * (numOfRaces - 1)
    positionTotal = positionTotal + rank
    local average = positionTotal / numOfRaces
    assert(average > 0 and average < 9, "Sprint Race Statistic Gen Error: average must be between [0,8], value " .. tostring(average))
    onlineStatistics.updateSpecificStatistic(average)
    onlineStatistics.updateScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
  end
end
missionSetupData["Multiplayer sprint race"].missionCompleteData = function(instance, syncedScoreTable, teamSync, additionalSyncData)
  localPlayer.mpEndOfRaceSetDestination = true
  local taskObject = false
  local totalScore = false
  local prevScore = false
  local roundScore = false
  for playerID, player in next, playerManager.players, nil do
    assert(syncedScoreTable[playerID], "players score not found in synced score table")
    assert(additionalSyncData[playerID], "players score not found in synced additional table")
    onlineScreenManager.updatePlayerScore(playerID, syncedScoreTable[playerID])
    onlineScreenManager.updatePlayerRoundScore(playerID, syncedScoreTable[playerID] - additionalSyncData[playerID])
    onlineScreenManager.updatePlayerSecondaryScore(playerID, onlineRaceManager.getPlayerRank(playerID))
  end
  onlineScreenManager.setForceSortType(onlineScreenManager.screenSortTypes.race)
  if instance and instance.networkVars.roundOn == instance.challenge.settings.numRounds then
    local results = onlineScreenManager.getScreenCurrentPlayerTable(onlineScreenManager.screenSortTypes.score)
    for i, player in ipairs(results) do
      assert(player, "Player not found, an error in sorting of players in onlineScreenManager.getScreenCurrentPlayerTable. i = " .. tostring(i) .. " #results = " .. tostring(results) .. " numPlayers = " .. tostring(playerManager.numberOfPlayers))
      if i == 1 then
        if player.id == localPlayer.playerID then
          onlineProgressionSystem.progressionMissionComplete(true)
          onlineStatistics.updateWinStatistic(1)
          onlineStatistics.updateModeProfileWinStatistic("MP sprint race")
        else
          onlineProgressionSystem.progressionMissionComplete(false)
          onlineStatistics.updateLossStatistic(1)
        end
      end
      if player.id == localPlayer.playerID then
        if gameStatus.onlineSessionType == gameStatus.onlineSessionID.public and i <= 3 then
          local value = ProfileSettings.GetNumSprintRaceTopThree() + 1
          ProfileSettings.SetNumSprintRaceTopThree(value)
          OnlineAchievements.onValueChange("Sprint Race Top 3", value)
        end
        onlineStatistics.updatePlayerLastPositionInMode("MP sprint race", i)
        break
      end
    end
  end
end
missionSetupData["Multiplayer sprint race"].getPlayerFinalScore = function(instance, playerID)
  return instance.playerScores[playerID + 1] or -1
end
missionSetupData["Multiplayer sprint race"].getPlayerAdditionalSyncData = function(instance, playerID)
  local taskObject = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[playerID + 1]]
  if taskObject and taskObject.namedTasks and taskObject.namedTasks.score then
    return taskObject.namedTasks.score.networkVars.payload
  end
  return 0
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
      lockZapWeapons = true,
      additionalSyncData = true
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
missionSetupData["Multiplayer sprint race"].onPlayerJoinInProgress = function(remotePlayer)
  if remotePlayer then
    local function setNewPlayerVehicleMaxDamage()
      if remotePlayer.currentVehicle then
        remotePlayer.currentVehicle.gameVehicle.maxAllowedDamage = 0.74
        local hasFinished = onlineRaceManager.getLocalPlayerActualFinishPosition()
        if hasFinished then
          PlayerGamePlay.sendMessage(remotePlayer.playerID, 30, tostring(hasFinished))
        end
        removeUserUpdateFunction("setNewPlayerVehicleMaxDamage")
      end
    end
    addUserUpdateFunction("setNewPlayerVehicleMaxDamage", setNewPlayerVehicleMaxDamage, 1)
  else
    feedbackSystem.menusMaster.primaryTextPrompt("ID:243748")
  end
end
missionSetupData["Multiplayer sprint race"].missionEnd = function(instance)
  removeUserUpdateFunction("setNewPlayerVehicleMaxDamage")
end
missionSetupData["Multiplayer sprint race"].missionStart = function(instance)
  if not instance.missionStartCalled then
    local routeIndex = instance.networkVars.routeIndex
    local route = instance.challenge.spawnPositions[routeIndex].route
    checkpointSystem.clearNoneSyncronisedCheckpoint()
    for i, checkpointData in ipairs(route) do
      checkpointSystem.createNoneSyncronisedCheckpoint(instance.instanceID, 1, checkpointData)
    end
  end
  for playerID, player in next, playerManager.players, nil do
    if player and player.currentVehicle then
      player.currentVehicle.gameVehicle.maxAllowedDamage = 0.74
    end
  end
  feedbackSystem.menusMaster.disableDamageBar(localPlayer)
  instance.missionStartCalled = true
  if instance.networkVars.roundOn / instance.challenge.settings.numRounds >= phaseManager.timeToJoinExceptionValues.sprintRace then
    phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.modeException)
  end
end
missionSetupData["Multiplayer sprint race"].modeReadyCheck = function(instance)
  for playerID, player in next, playerManager.players, nil do
    local racerTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]]
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
  for i = 1, 8 do
    local taskObject = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
    if taskObject and not playerManager.players[i - 1] and taskObject.coreData.isLocal and taskObject:canBeDeleted() then
      taskObject:delete()
    end
  end
  onlineProgressionSystem.progressionUpdate()
end
missionSetupData["Multiplayer sprint race"].onRacePositionsFinalised = function(instance)
  local numPlayers = playerManager.numberOfPlayers
  local totalCheckpoints = #instance.challenge.spawnPositions[instance.networkVars.routeIndex].route
  NetworkLog.Write(">[LUA] - SPRINT RACE ASSIGN POINTS")
  NetworkLog.Write(">[LUA] - SPRINT RACE ASSIGN POINTS ----- assign race points: round  = " .. tostring(instance.networkVars.roundOn))
  for i = 1, 8 do
    local playerTO = instance.taskObjectsByActorID[PLAYER_STRING_TABLE[i]]
    local vehicleTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
    if playerTO and vehicleTO then
      local playerPosition = onlineRaceManager.getPlayerRank(playerTO.coreData.agent.playerID)
      local gatesPassed = vehicleTO.namedTasks.checkpoints.networkVars.checkpoints - 1 + totalCheckpoints * vehicleTO.namedTasks.checkpoints.networkVars.laps
      local weight = gatesPassed / totalCheckpoints
      if numPlayers < playerPosition then
        playerPosition = numPlayers
      end
      local baseScore = mpSprintRaceScoreTable[numPlayers][playerPosition]
      local finalScore = 0
      if weight >= 0.5 then
        finalScore = baseScore
      else
        finalScore = math.ceil(baseScore * weight * 2)
      end
      NetworkLog.Write(">[LUA] - SPRINT RACE ASSIGN POINTS ----- assign player: " .. tostring(i) .. "   " .. tostring(finalScore) .. "  points          isLocal = " .. tostring(playerTO.coreData.isLocal) .. "      isLocal2 = " .. tostring(vehicleTO.coreData.isLocal))
      instance.playerScores[i] = instance.playerScores[i] + finalScore
    end
  end
  NetworkLog.Write(">[LUA] - END SPRINT RACE ASSIGN POINTS")
end
taskCompleteData["Multiplayer sprint race"] = {}
local taskCompleteFired = false
taskCompleteData["Multiplayer sprint race"].taskComplete = function(taskObject, task)
  if task.taskName == "Linear Checkpoints No AI" and task.condition == 1 and taskObject.coreData.isLocal then
    onlineRaceManager.onLocalPlayerFinishRace()
  elseif task.taskName == "Linear Checkpoints No AI" and task.condition ~= 1 or task.taskName == "MP race end timer" and task.condition > 0 or task.taskName == "MP race end" and task.condition == 2 then
    for id, player in next, localPlayerManager.players, nil do
      scoreSystem.stopAbilityDrain(player.localID, false)
    end
    onlineRaceManager.onLocalPlayerFinishRace()
    feedbackSystem.eventMessages.pushXPGroup()
    removeUserUpdateFunction("setNewPlayerVehicleMaxDamage")
    if task.taskName == "MP race end timer" and task.condition > 0 then
      print("------------------- taskObject.coreData.instance.isLocal = " .. tostring(taskObject.coreData.instance.isLocal) .. " taskObject.coreData.agent.playerID = " .. tostring(taskObject.coreData.agent.playerID) .. " localID = " .. tostring(localPlayer.playerID))
    end
    taskObject.coreData.instance:initiateOverTimePhase()
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
