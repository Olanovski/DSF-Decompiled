module("cardSystem.logic")
missionSetupData = missionSetupData or {}
missionSetupData["Multiplayer general mechanics tutorial"] = {}
missionSetupData["Multiplayer general mechanics tutorial"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.target = routes.Tutorial_Start_Locations.checkpoints[1].position
    spawnPosition.positionA = routes.Tutorial_Start_Locations.checkpoints[1].position
    spawnPosition.headingA = routes.Tutorial_Start_Locations.checkpoints[1].heading
    spawnPosition.positionB = routes.Tutorial_Start_Locations.checkpoints[2].position
    spawnPosition.headingB = routes.Tutorial_Start_Locations.checkpoints[2].heading
    spawnPosition.route = routes.TutorialGates01.checkpoints
    spawnPosition.route2 = routes.TutorialGates02.checkpoints
    spawnPosition.route3 = routes.TutorialGates03.checkpoints
    spawnPosition.route4 = routes.TutorialGates04.checkpoints
    spawnPosition.routeStartP = routes.TutorialStart01.checkpoints[1].position
    spawnPosition.routeStartH = routes.TutorialStart01.checkpoints[1].heading
  end
}
missionSetupData["Multiplayer general mechanics tutorial"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
  spawnPosition.positionB = nil
  spawnPosition.headingB = nil
  spawnPosition.route = nil
  spawnPosition.route2 = nil
  spawnPosition.route3 = nil
  spawnPosition.route4 = nil
  spawnPosition.routeStartP = nil
  spawnPosition.routeStartH = nil
end
missionSetupData["Multiplayer general mechanics tutorial"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\MP_Tutorials.lua",
    positionC = vec.vector(564.32, 18.16729, 1938.614, 1),
    vehicleSet = {
      {
        vehicleID = 62,
        shader = {
          [0] = 0
        }
      }
    },
    trafficSet = 2,
    trafficFrequency = 1,
    moods = {
      [1] = "OnlineDefault"
    },
    lockingZoneData = {
      name = "Online_Tutorial"
    }
  }
}
missionSetupData["Multiplayer general mechanics tutorial"].usableRouteIndicies = {
  [1] = 1
}
local wellDoneObjectiveTimer = 3
local showObjectiveTimer = 3.5
local blockTextTimer = 2
local showPanelDelay = 1
local errorTimer = 0.1
local completeTimer = 4
local getRampTruckTaskList = function()
  return {
    [1] = {
      [1] = {
        task = "Follow Route"
      }
    }
  }
end
local getStationaryVehicleTaskList = function()
  return {
    [1] = {
      [1] = {task = "No target"}
    }
  }
end
local function getPlayerTaskList(param1, param2, param3, agent)
  return {
    [1] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 7}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 3}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 1}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 8}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 3, subgroup = 1}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 3, subgroup = 3}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 3, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 3, subgroup = 4}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 3, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 3, complete = true}
            },
            {
              goal = "Time trigger",
              params = {
                value = showObjectiveTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 3, subgroup = 5}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [2] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {clear = true}
              }
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {
                  welldone = true,
                  tick = 2,
                  disableZapIn = true
                }
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "Player can zap"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [3] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 5, subgroup = 1}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 3}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 5, subgroup = 4}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {
                value = showObjectiveTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 5, subgroup = 5}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [4] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {clear = true}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {all = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {welldone = true, tick = 2}
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 3, complete = false}
            },
            {
              goal = "Player in zap",
              params = {levelOfZap = 3}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 10}
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 3, complete = false}
            },
            {
              goal = "Player in zap",
              params = {levelOfZap = 4}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 11}
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 3, complete = false}
            },
            {
              goal = "Player in zap",
              params = {levelOfZap = 3}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 12}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [5] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 0.6}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 6, subgroup = 1}
              }
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 0.6}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 6, subgroup = 6}
              }
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 0.6}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = 0.6}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 3}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 6, subgroup = 4}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {
                value = showObjectiveTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 6, subgroup = 5}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [6] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {clear = true}
              }
            }
          },
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
            },
            {
              goal = "Pass ID",
              params = {
                value = {
                  welldone = true,
                  tick = 2,
                  removeMarkers = true
                }
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "Vehicle selected in shift"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1}
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 2}
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "Player in zap",
              params = {value = true}
            },
            {
              goal = "Vehicle selected in shift",
              params = {inverse = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 4}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [7] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 7, subgroup = 1}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 3}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 7, subgroup = 4}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {
                value = showObjectiveTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 7, subgroup = 5}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [8] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {clear = true}
              }
            }
          },
          {
            {
              goal = "Time trigger",
              params = {value = errorTimer}
            },
            {
              goal = "General mechanics tasks complete",
              params = {all = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {welldone = true, tick = 3}
              }
            }
          },
          {
            triggerCount = 1,
            failCondition = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 7}
              }
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 8}
              }
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 9}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [9] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            },
            {
              goal = "Player objective vehicle created",
              params = {value = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {spawnPlayerVehicle = true}
              }
            }
          },
          {
            {
              goal = "Player objective vehicle created",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {forceZapPlayer = true}
              }
            }
          },
          {
            {
              goal = "In player objective vehicle",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = errorTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {forceTaskDone = true}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [10] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 8, subgroup = 1}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 3}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 8, subgroup = 6}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 8, subgroup = 7}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 8, subgroup = 4}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "Time trigger",
              params = {
                value = showObjectiveTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 8, subgroup = 5}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [11] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        dynamicTargets = true,
        coreData = {totalLaps = 0},
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {clear = true}
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics timeup called",
              params = {value = false}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = false}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Within strip of road",
              params = {value = 10}
            },
            {
              goal = "Pass ID",
              params = {
                value = {
                  welldone = true,
                  tick = 1,
                  removeCheckpoint = true,
                  turnOffBlockFeedback = true
                }
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics fade complete",
              params = {value = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = false}
            },
            {
              goal = "Player objective vehicle created",
              params = {value = true}
            },
            {
              goal = "In player objective vehicle",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {deletePlayerTO = true}
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics is player reseting",
              params = {value = false}
            },
            {
              goal = "Player objective vehicle created",
              params = {value = false}
            },
            {
              goal = "General mechanics timer ran out",
              params = {time = 5}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {createAndForceZapPlayer = true}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        },
        HUD = {
          {
            style = "MP general mechanics tutorial HUD"
          }
        }
      }
    },
    [12] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            },
            {
              goal = "Player objective vehicle created",
              params = {value = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {spawnPlayerVehicle = true}
              }
            }
          },
          {
            {
              goal = "Player objective vehicle created",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {forceZapPlayer = true}
              }
            }
          },
          {
            {
              goal = "In player objective vehicle",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = errorTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {forceTaskDone = true}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [13] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 11, subgroup = 1}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 3}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 11, subgroup = 6}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 11, subgroup = 7}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 11, subgroup = 4}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "Time trigger",
              params = {
                value = showObjectiveTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 11, subgroup = 5}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [14] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        dynamicTargets = true,
        coreData = {totalLaps = 0},
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {clear = true}
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = true}
            },
            {
              goal = "General mechanics timeup called",
              params = {value = false}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = false}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Within strip of road",
              params = {value = 24}
            },
            {
              goal = "Pass ID",
              params = {
                value = {
                  welldone = true,
                  tick = 3,
                  removeCheckpoint = true,
                  turnOffBlockFeedback = true
                }
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics fade complete",
              params = {value = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = false}
            },
            {
              goal = "Player objective vehicle created",
              params = {value = true}
            },
            {
              goal = "In player objective vehicle",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {deletePlayerTO = true}
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics is player reseting",
              params = {value = false}
            },
            {
              goal = "Player objective vehicle created",
              params = {value = false}
            },
            {
              goal = "General mechanics timer ran out",
              params = {time = 10}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {createAndForceZapPlayer = true}
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Player using boost"
            },
            {
              goal = "Pass ID",
              params = {
                value = {boostComplete = true}
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Player above speed",
              params = {value = 10}
            },
            {
              goal = "Pass ID",
              params = {
                value = {speedComplete = true}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        },
        HUD = {
          {
            style = "MP general mechanics tutorial HUD"
          }
        }
      }
    },
    [15] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            },
            {
              goal = "Player objective vehicle created",
              params = {value = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {spawnPlayerVehicle = true}
              }
            }
          },
          {
            {
              goal = "Player objective vehicle created",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {forceZapPlayer = true}
              }
            }
          },
          {
            {
              goal = "In player objective vehicle",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = errorTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {forceTaskDone = true}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [16] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 9, subgroup = 1}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 3}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 9, subgroup = 4}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {
                value = showObjectiveTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 9, subgroup = 5}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [17] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        dynamicTargets = true,
        coreData = {totalLaps = 0},
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {clear = true}
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics timeup called",
              params = {value = false}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = false}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Within strip of road",
              params = {value = 10}
            },
            {
              goal = "Pass ID",
              params = {
                value = {
                  welldone = true,
                  tick = 1,
                  removeCheckpoint = true
                }
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics fade complete",
              params = {value = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = false}
            },
            {
              goal = "Player objective vehicle created",
              params = {value = true}
            },
            {
              goal = "In player objective vehicle",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {deletePlayerTO = true, setZapOutInstrPrompt = true}
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics is player reseting",
              params = {value = false}
            },
            {
              goal = "Player objective vehicle created",
              params = {value = false}
            },
            {
              goal = "General mechanics timer ran out",
              params = {time = 14}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {createAndForceZapPlayer = true}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        },
        HUD = {
          {
            style = "MP general mechanics tutorial HUD"
          }
        }
      }
    },
    [18] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            },
            {
              goal = "Player objective vehicle created",
              params = {value = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {spawnPlayerVehicle = true}
              }
            }
          },
          {
            {
              goal = "Player objective vehicle created",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {forceZapPlayer = true}
              }
            }
          },
          {
            {
              goal = "In player objective vehicle",
              params = {value = true}
            },
            {
              goal = "Time trigger",
              params = {value = errorTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {forceTaskDone = true}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [19] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 10, subgroup = 1}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 3}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 10, subgroup = 4}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {
                value = showObjectiveTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 10, subgroup = 5}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [20] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        dynamicTargets = true,
        coreData = {totalLaps = 0},
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {clear = true}
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics timeup called",
              params = {value = false}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = false}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Within strip of road",
              params = {value = 10}
            },
            {
              goal = "Pass ID",
              params = {
                value = {
                  welldone = true,
                  tick = 1,
                  removeCheckpoint = true,
                  blockZap = true
                }
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics fade complete",
              params = {value = true}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = false}
            },
            {
              goal = "Player objective vehicle created",
              params = {value = true}
            },
            {
              goal = "In player objective vehicle",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {deletePlayerTO = true, setZapOutInstrPrompt = true}
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "General mechanics is player reseting",
              params = {value = false}
            },
            {
              goal = "Player objective vehicle created",
              params = {value = false}
            },
            {
              goal = "General mechanics timer ran out",
              params = {time = 15}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {createAndForceZapPlayer = true}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        },
        HUD = {
          {
            style = "MP general mechanics tutorial HUD"
          }
        }
      }
    },
    [21] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {
                  group = 12,
                  subgroup = 1,
                  stopVehicle = true
                }
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {
                value = blockTextTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 3}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showPanelDelay}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 12, subgroup = 4}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = showObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1, subgroup = 2}
              }
            }
          },
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Time trigger",
              params = {
                value = showObjectiveTimer + errorTimer
              }
            },
            {
              goal = "Tutorial confirm"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 12, subgroup = 5}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    },
    [22] = {
      [1] = {
        task = "MP General Mechanics Tutorial",
        specialName = "EndTask",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 4, complete = true}
            },
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {clear = true}
              }
            }
          },
          {
            {
              goal = "Specified actors selected in zap",
              params = {
                actorIDs = {
                  "Objective Team 1 member 1"
                }
              }
            },
            {
              goal = "Time trigger",
              params = {value = 1.5}
            },
            {
              goal = "Pass ID",
              params = {
                value = {
                  welldone = true,
                  tick = 2,
                  removeMarkers = true
                }
              }
            }
          },
          {
            failCondition = true,
            {
              goal = "Player can zap"
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 1}
              }
            }
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        }
      }
    }
  }
end
missionSetupData["Multiplayer general mechanics tutorial"].taskCreatorFunctionLookups = {
  ["Player Pool"] = getPlayerTaskList,
  ["Objective Team 1"] = getStationaryVehicleTaskList,
  ["Objective Team 2"] = getRampTruckTaskList
}
missionSetupData["Multiplayer general mechanics tutorial"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 1,
      gridStyle = 1,
      missionVehicleStyle = 1,
      moodStyle = 2,
      introHUD = "MP tutorial start HUD",
      tutorial = true,
      tutorialStatID = 5,
      disableZapOnCompletion = true
    }
  }
end
missionSetupData["Multiplayer general mechanics tutorial"].initiate = function(instance)
  local currentXP = onlineProgressionSystem.getLocalPlayerXP()
  local currentLevel = onlineProgressionSystem.getLocalPlayerLevel()
  onlineProgressionSystem.resetPlayerProgression()
  onlineProgressionSystem.setPlayerLevel(1, true)
  onlineScreenManager.setPlayerXP(localPlayer.playerID, currentXP)
  feedbackSystem.menusMaster.onlineHUDSetTextVariable("multi_willpower_level_number", currentLevel)
end
missionSetupData["Multiplayer general mechanics tutorial"].missionStart = function(instance)
  Presence.setPresence(10, 143)
  localPlayer:blockAbility("zap", true)
  localPlayer:blockAbility("ZapSpawn", true)
  localPlayer:blockAbility("ZapSwap", true)
  localPlayer:blockAbility("ZapAttack", true)
  localPlayer:blockAbility("ZapImpulse", true)
  localPlayer:blockAbility("nitro", true)
  localPlayer:blockAbility("ram", true)
  localPlayer.currentVehicle:set_damageMultiplier(0)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 5)
  localPlayer.controllerInterface:createCallbacks()
  civilianTraffic.setTrafficOnOff(false)
  localPlayer.controllerInterface:removePlayerControl()
  zapWeaponSupport.enableZapWeapons(false)
  scoreSystem.emptyAbility()
  scoreSystem.setTimeAbilityGain(0, false)
  zapcontroller.setZapCameraLocks(0, {
    missile = false,
    low = true,
    mid = false,
    high = false,
    top = true
  })
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Stripes", 1)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Icon", 4)
end
missionSetupData["Multiplayer general mechanics tutorial"].assignTaskObjects = function(instance, player, vehicle)
end
missionSetupData["Multiplayer general mechanics tutorial"].modeReadyCheck = function(instance)
  return true
end
local lastTaggedVehicle = -1
missionSetupData["Multiplayer general mechanics tutorial"].update = function(instance)
  onlineInstructionSupport.step()
end
local restoreAbilities = function()
  localPlayer:blockAbility("zap", false)
  localPlayer:blockAbility("ZapSpawn", false)
  localPlayer:blockAbility("ZapSwap", false)
  localPlayer:blockAbility("ZapAttack", false)
  localPlayer:blockAbility("ZapImpulse", false)
  localPlayer:blockAbility("nitro", false)
  localPlayer:blockAbility("ram", false)
  scoreSystem.stopAbilityDrain(0, false)
  scoreSystem.stopAbilityGain(0, false)
  scoreSystem.setTimeAbilityGain(0, true)
  scoreSystem.limitedFeedback = false
  localPlayer.scoring.onlineTutorialFeedback = false
  zapcontroller.setZapCameraLocks(0, {
    missile = false,
    low = true,
    mid = false,
    high = false,
    top = true
  })
  zap.enableZapSelection()
  localPlayer.controllerInterface:registerPlayerControl()
end
missionSetupData["Multiplayer general mechanics tutorial"].missionEnd = function(instance)
  restoreAbilities()
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 0)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Continue_Prompt", 2)
  checkpointSystem.deleteInstanceCheckpoints(instance)
  if instance.mpCheckpointGateMinimap then
    Marker:delete(instance.mpCheckpointGateMinimap)
    instance.mpCheckpointGateMinimap = nil
  end
  if instance.mpCheckpointColumn then
    Marker:delete(instance.mpCheckpointColumn)
    instance.mpCheckpointColumn = nil
  end
  if instance.mpCheckpointTargetMarker then
    Marker:delete(instance.mpCheckpointTargetMarker)
    instance.mpCheckpointTargetMarker = nil
  end
  if instance.mpCheckpointGate then
    Marker:delete(instance.mpCheckpointGate)
    instance.mpCheckpointGate = nil
  end
  if instance.markedVehicleWorldMarker then
    Marker:delete(instance.markedVehicleWorldMarker)
    instance.markedVehicleWorldMarker = nil
  end
  if instance.markedVehicleTargetMarker then
    Marker:delete(instance.markedVehicleTargetMarker)
    instance.markedVehicleTargetMarker = nil
  end
  if instance.markedVehicleMinimapMarker then
    Marker:delete(instance.markedVehicleMinimapMarker)
    instance.markedVehicleMinimapMarker = nil
  end
  if instance.markedVehicleMinimapMarkerArrow then
    Marker:delete(instance.markedVehicleMinimapMarkerArrow)
    instance.markedVehicleMinimapMarkerArrow = nil
  end
  removeUserUpdateFunction("tutZapOutDetection")
  removeUserUpdateFunction("returnControl")
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Stripes", 2)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Icon", 0)
  MPZapToAction.reset()
  zap.SetZapInOverride(nil)
  if scoreSystem.blockedFeedbackOn then
    scoreSystem.setZapBlocked(0, false)
  end
end
missionSetupData["Multiplayer general mechanics tutorial"].missionCompleteData = function()
  onlineProgressionSystem.progressionSetup(true)
  onlineProgressionSystem.progressionMissionComplete(true)
end
missionSetupData["Multiplayer general mechanics tutorial"].onlineProgressionData = {
  localPlayer = {
    getMatchBonus = function(timeInMode, threshold, baseXPValue, gainedXP)
      return baseXPValue
    end
  }
}
missionSetupData["Multiplayer general mechanics tutorial"].onlineStatisticsData = function()
  onlineStatistics.updateOverallScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
end
taskCompleteData = taskCompleteData or {}
taskCompleteData["Multiplayer general mechanics tutorial"] = {}
taskCompleteData["Multiplayer general mechanics tutorial"].taskComplete = function(taskObject, task)
  if task.specialName == "EndTask" then
    local instance = task.instance
    checkpointSystem.deleteInstanceCheckpoints(instance)
    if instance.mpCheckpointGateMinimap then
      Marker:delete(instance.mpCheckpointGateMinimap)
      instance.mpCheckpointGateMinimap = nil
    end
    if instance.mpCheckpointColumn then
      Marker:delete(instance.mpCheckpointColumn)
      instance.mpCheckpointColumn = nil
    end
    if instance.mpCheckpointTargetMarker then
      Marker:delete(instance.mpCheckpointTargetMarker)
      instance.mpCheckpointTargetMarker = nil
    end
    if instance.mpCheckpointGate then
      Marker:delete(instance.mpCheckpointGate)
      instance.mpCheckpointGate = nil
    end
    if instance.markedVehicleWorldMarker then
      Marker:delete(instance.markedVehicleWorldMarker)
      instance.markedVehicleWorldMarker = nil
    end
    if instance.markedVehicleTargetMarker then
      Marker:delete(instance.markedVehicleTargetMarker)
      instance.markedVehicleTargetMarker = nil
    end
    restoreAbilities()
    if instance.isLocal then
      instance:initiateOverTimePhase()
    end
  end
end
local getPlayerDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(taskObject.coreData.instance, 0)
  if allCheckpoints then
    if dynamicListID then
      if task.networkVars.checkpoints < #allCheckpoints then
        return {
          allCheckpoints[task.networkVars.checkpoints + 1]
        }, false
      else
        return {
          allCheckpoints[0]
        }, true
      end
    else
      return {
        allCheckpoints[task.networkVars.checkpoints]
      }, false
    end
  else
    return {}, false
  end
end
missionSetupData["Multiplayer general mechanics tutorial"].targetList = {
  ["Objective Team 1"] = false,
  ["Objective Team 2"] = false,
  ["Player Pool"] = getPlayerDynamicTargets
}
