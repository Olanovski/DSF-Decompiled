module("cardSystem.logic")
local scene, groundRavenID, flyingRavenID
local ravenAudioPlayID = 0
local wrongTurns = 0
local prompts = {
  beginMission = "ID:245553",
  exploreArea = "ID:184912",
  spotChaser = "ID:184926",
  endAppear = "ID:245544"
}
local puzzlesInfo = {
  ["In puzzle1"] = {
    index = 99,
    cameraPosition = vec.vector(-61.22173, 90.34513, 1281.099, 1),
    ravenGroundPosition = vec.vector(-148.8958, 34.28448, 1293.54, 1),
    ravenColumnPosition = vec.vector(-148.8958, 44.28448, 1293.54, 1),
    correct = 1,
    startPosition = vec.vector(32.77275, 31.31688, 1241.775, 1),
    startHeading = -1.389512,
    exitPositions = {
      vec.vector(-207.291, 34.81701, 1314.878, 1),
      [20] = vec.vector(82.09404, 31.1546, 1231.272, 1)
    }
  },
  ["In puzzle2"] = {
    index = 100,
    cameraPosition = vec.vector(-1322.856, 81.7898, 207.7792, 1),
    ravenGroundPosition = vec.vector(-1413.298, 22.14032, 131.4295, 1),
    ravenColumnPosition = vec.vector(-1413.298, 22.14032, 131.4295, 1),
    correct = 1,
    startPosition = vec.vector(-1189.759, 16.62109, 151.3016, 1),
    startHeading = -1.410604,
    exitPositions = {
      vec.vector(-1447.003, 17.78995, 86.26773, 1),
      vec.vector(-1148.357, 15.19896, 144.8838, 1),
      [20] = vec.vector(-1416.801, 34.12609, 300.1751, 1)
    },
    relativePoint = vec.vector(-1346.832, 25.46632, 198.4286, 1),
    focusPoint = vec.vector(-1364.361, 25.39816, 192.1524, 1),
    actionRadius = 60
  },
  ["In puzzle3"] = {
    index = 101,
    cameraPosition = vec.vector(893.0892, 69.76649, 1465.325, 1),
    ravenGroundPosition = vec.vector(983.6019, 6.154046, 1441.288, 1),
    ravenColumnPosition = vec.vector(983.6019, 16.15405, 1441.288, 1),
    correct = 1,
    startPosition = vec.vector(849.459, 6.236014, 1365.535, 1),
    startHeading = 0.8789222,
    exitPositions = {
      vec.vector(1070.503, 6.138356, 1369.145, 1),
      vec.vector(824.6367, 6.209488, 1345.423, 1),
      vec.vector(1037.707, 6.118531, 1554.531, 1),
      [20] = vec.vector(869.1453, 6.195293, 1545.623, 1)
    },
    relativePoint = vec.vector(955.8758, 6.235239, 1464.171, 1),
    focusPoint = vec.vector(971.6218, 6.184053, 1451.306, 1),
    actionRadius = 110
  },
  ["In puzzle4"] = {
    index = 102,
    cameraPosition = vec.vector(-243.6774, 46.81792, 1064.339, 1),
    ravenGroundPosition = vec.vector(-139.7065, 20.18733, 976.8966, 1),
    ravenColumnPosition = vec.vector(-139.7065, 20.18733, 976.8966, 1),
    correct = 1,
    startPosition = vec.vector(-317.3901, 19.39408, 1055.222, 1),
    startHeading = 1.766544,
    exitPositions = {
      vec.vector(-108.8454, 27.39926, 945.3904, 1),
      vec.vector(-337.4543, 19.84751, 1057.842, 1),
      vec.vector(-208.5169, 18.29049, 997.3384, 1),
      vec.vector(-169.3049, 18.27539, 1068.82, 1),
      vec.vector(-47.33299, 18.28556, 1020.896, 1),
      vec.vector(-311.603, 18.8812, 1017.74, 1),
      vec.vector(-198.8114, 17.97087, 1072.553, 1),
      [22] = vec.vector(-180.9676, 17.99721, 1080.875, 1)
    },
    relativePoint = vec.vector(-180.3331, 18.26235, 1028.054, 1),
    focusPoint = vec.vector(-167.9958, 17.96127, 1010.836, 1),
    actionRadius = 65
  }
}
local function endOfPuzzle(task, taskObject)
  characterManager.removeRavenGroup(groundRavenID)
  characterManager.removeRavenGroup(flyingRavenID)
  groundRavenID = nil
  flyingRavenID = nil
  taskObject.coreData.agent.blockCamChange = false
  Sound.SetAttenuationFactor("PlayerVehicle", 1)
  Sound.SetAttenuationFactor("Collision", 1)
  Sound.RestoreEnvironment()
  ReplaySystem.StopScriptedCamera()
  CameraSystem.ClearScene()
  OneShotSound.Play("Mis_Alone_Car_Alarm_Play")
  if ravenAudioPlayID ~= 0 then
    OneShotSound.Stop(ravenAudioPlayID, "Mis_Alone_RavenEye_Positive_Stop")
    ravenAudioPlayID = 0
  end
  if localPlayer.cameraMode == "Bumper" then
    VehicleSystem.setPlayerVehicleVisible(0, localPlayer.localID)
  end
  local function endOfPuzzle2()
    if task.specialName == "In puzzle1" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_5B")
    elseif task.specialName == "In puzzle2" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_8B")
    end
    ReplaySystem.StopScriptedCamera()
    localPlayer:showHUDElements(false)
    scoreSystem.blockWillpowerPrompt(true)
    localPlayer.blockHUD = true
  end
  spooling.fadeIn(vec.vector(1, 1, 1, 0), nil, endOfPuzzle2)
end
local createSoftsave = function(goalParams, HUD, audio, number)
  local softsave = {
    {
      task = "No functionality",
      specialName = "softsave" .. tostring(number),
      taskConditions = {
        {
          {
            goal = "Is player controlled"
          }
        }
      },
      audioPIP = audio
    }
  }
  return softsave
end
local function createPuzzle(goalParams, HUD, audio, number)
  local tempSpecialName = "In puzzle" .. tostring(number)
  local puzzle = {
    {
      task = "Non-linear Checkpoints",
      dynamicTargets = true,
      specialName = tempSpecialName,
      goalConditions = {
        {
          {
            goal = "Player teleporting",
            params = {inverse = true}
          },
          {
            goal = "Within strip of road",
            params = {value = 16}
          }
        }
      },
      taskConditions = {
        {
          {
            goal = "Completed lap",
            params = {value = 0}
          }
        },
        {
          forceTaskComplete = true,
          failCondition = true,
          {
            goal = "Damage above",
            params = {value = 1}
          }
        }
      },
      targetManagers = {
        {
          manager = "Instance vehicles"
        }
      },
      audioPIP = audio
    },
    {
      task = "No AI",
      specialName = "raven noise" .. tostring(number),
      goalConditions = {
        {
          {
            goal = "Player within radius of point",
            params = {
              value = 70,
              position = puzzlesInfo[tempSpecialName].exitPositions[1]
            }
          }
        },
        {
          {
            goal = "Player within radius of point",
            params = {
              value = 70,
              position = puzzlesInfo[tempSpecialName].exitPositions[1],
              inverse = true
            }
          }
        }
      },
      audioPIP = audio
    },
    {
      task = "No AI",
      dynamicTargets = true,
      specialName = "raven position" .. tostring(number),
      groupProgression = {importantMinorOrder = false},
      goalConditions = {
        {
          {
            goal = "Player outside then within radius of target",
            params = {value = 25}
          }
        }
      },
      audioPIP = audio
    },
    {
      task = "No AI",
      specialName = "puzzle audio" .. tostring(number),
      groupProgression = {importantMinorOrder = false},
      goalConditions = {
        {
          autoRefresh = true,
          {
            goal = "Time trigger",
            params = {value = 40}
          }
        },
        {
          triggerCount = 1,
          {
            goal = "Time trigger",
            params = {value = 2}
          }
        },
        {
          triggerCount = 1,
          {
            goal = "Button Press",
            params = {
              watchFor = "Pressed",
              button = "Vehicle_Accelerate"
            }
          }
        },
        {
          triggerCount = 1,
          {
            goal = "Button Press",
            params = {
              watchFor = "Pressed",
              button = "Vehicle_Reverse"
            }
          }
        },
        {
          {
            goal = "Time trigger",
            params = {value = 4}
          }
        },
        {
          {
            goal = "Time trigger",
            params = {value = 17}
          }
        }
      },
      HUD = {
        {style = "Alone HUD"}
      },
      audioPIP = audio
    },
    {
      task = "No AI",
      specialName = "tried to shift out puzzle " .. tostring(number),
      groupProgression = {importantMinorOrder = false},
      goalConditions = {
        {
          triggerCount = 1,
          autoRefresh = true,
          {
            goal = "Time trigger",
            params = {value = 1}
          },
          {
            goal = "Button Press",
            params = {watchFor = "Pressed", button = "Zap_In"}
          }
        }
      },
      audioPIP = audio
    }
  }
  if number == 4 then
    puzzle[1].goalConditions[2] = {
      {
        goal = "Player teleporting",
        params = {inverse = true}
      },
      {
        goal = "Within radius",
        params = {value = 10}
      }
    }
  end
  return puzzle
end
local createTimeTrigger = function(goalParams, HUD, audio, number)
  local timeTrigger = {
    {
      task = "No AI",
      specialName = "time delay" .. tostring(number),
      goalConditions = {
        {
          triggerCount = 1,
          {
            goal = "Time trigger",
            params = {value = 5}
          }
        }
      },
      taskConditions = {
        {
          {
            goal = "Time trigger",
            params = {value = 15}
          }
        },
        {
          forceTaskComplete = true,
          failCondition = true,
          {
            goal = "Damage above",
            params = {value = 1}
          }
        }
      },
      audioPIP = audio
    }
  }
  return timeTrigger
end
missionSetupData.Alone = {}
local function tannerTask(goalParams, HUD, audio)
  local task = {
    {
      {
        task = "Non-linear Checkpoints",
        dynamicTargets = true,
        specialName = "drive under bridge",
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 11}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {style = "Alone HUD"}
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "weird audio",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 3,
            {
              goal = "X time has past",
              params = {value = 15}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "GoalConditions empty"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "tried to shift out",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 2,
            autoRefresh = true,
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for cutscene to start",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam"
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "Wait for cutscene to end",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            }
          }
        }
      }
    },
    createSoftsave(goalParams, HUD, audio, 1),
    createPuzzle(goalParams, HUD, audio, 1),
    createTimeTrigger(goalParams, HUD, audio, 1),
    createSoftsave(goalParams, HUD, audio, 2),
    createPuzzle(goalParams, HUD, audio, 2),
    createTimeTrigger(goalParams, HUD, audio, 2),
    createSoftsave(goalParams, HUD, audio, 4),
    createPuzzle(goalParams, HUD, audio, 4),
    createSoftsave(goalParams, HUD, audio, 5),
    {
      {
        task = "No AI",
        specialName = "out of alley after puzzles",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        }
      }
    },
    createSoftsave(goalParams, HUD, audio, 6),
    {
      {
        task = "No AI",
        specialName = "Wait for cutscene2",
        taskConditions = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            }
          }
        }
      }
    },
    {
      {
        task = "No AI",
        specialName = "mass chase",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        targetManagers = {
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {style = "Alone HUD"}
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "Non-linear Checkpoints",
        dynamicTargets = true,
        specialName = "drive to doorway",
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 11}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0, setRaceFinished = true}
            }
          },
          {
            forceTaskComplete = true,
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        },
        targetManagers = {
          {
            manager = "Target list",
            settings = {
              styles = {
                Hotspot = {}
              }
            }
          },
          {
            manager = "Instance vehicles"
          }
        },
        HUD = {
          {style = "Alone HUD"}
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "health2",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            triggerCount = 1,
            {
              goal = "Damage above",
              params = {value = 0.2}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Damage above",
              params = {value = 0.4}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Damage above",
              params = {value = 0.6}
            }
          },
          {
            triggerCount = 1,
            {
              goal = "Damage above",
              params = {value = 0.8}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "GoalConditions empty"
            }
          }
        },
        audioPIP = audio
      },
      {
        task = "No AI",
        specialName = "getting close to doorway",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 300}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "All targets eliminated (Non-linear)"
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "tried to shift out 4",
        groupProgression = {importantMinorOrder = false},
        goalConditions = {
          {
            autoRefresh = true,
            triggerCount = 1,
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "Button Press",
              params = {watchFor = "Pressed", button = "Zap_In"}
            }
          }
        },
        audioPIP = audio
      }
    },
    {
      {
        task = "No AI",
        specialName = "wait for attack cutscene",
        taskConditions = {
          {
            {
              goal = "In cutscene or icam",
              params = {inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            }
          }
        }
      }
    },
    {
      {
        task = "Linear Checkpoints",
        specialName = "alley chase",
        dynamicTargets = true,
        groupProgression = {importantMinorOrder = true},
        goalConditions = {
          {
            {
              goal = "Within strip of road",
              params = {value = 4}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Completed lap",
              params = {value = 0}
            }
          }
        }
      },
      {
        task = "No AI",
        specialName = "alley chase audio",
        groupProgression = {importantMinorOrder = false},
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        audioPIP = audio
      }
    }
  }
  return task
end
local evaderTask = function(goalParams, HUD)
  local task = {
    deleteVehicleOnCompletion = true,
    {
      {
        task = "Non-linear Checkpoints",
        dynamicTargets = true,
        specialName = "criminal drive",
        coreData = {totalLaps = 0},
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 15}
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
            failCondition = true,
            {
              goal = "Damage above",
              params = {value = 1}
            }
          }
        }
      }
    }
  }
  return task
end
local chaserTaskBehind = function(goalParams, HUD)
  local task = {
    deleteVehicleOnCompletion = true,
    {
      {
        task = "Non-linear Chase",
        dynamicTargets = true,
        specialName = "chase tanner",
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 100, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Empty dynamicTargets"
            }
          },
          {
            {
              goal = "Specified actors have finished race",
              params = {
                actors = {"Tanner"},
                value = 1
              }
            }
          }
        }
      }
    }
  }
  return task
end
local chaserTaskAhead = function(goalParams, HUD)
  local task = {
    deleteVehicleOnCompletion = true,
    {
      {
        task = "Non-linear Chase",
        dynamicTargets = true,
        specialName = "chase tanner",
        goalConditions = {
          {
            {
              goal = "Agent within then outside radius of target",
              params = {value = 100}
            }
          },
          {
            {
              goal = "Within radius",
              params = {value = 300, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Empty dynamicTargets"
            }
          },
          {
            {
              goal = "Specified actors have finished race",
              params = {
                actors = {"Tanner"},
                value = 1
              }
            }
          }
        }
      }
    }
  }
  return task
end
local fakeChaserTask = function(goalParams, HUD)
  local task = {
    deleteVehicleOnCompletion = true,
    {
      {
        task = "Non-linear Chase",
        dynamicTargets = true,
        specialName = "chase tanner",
        goalConditions = {
          {
            {
              goal = "Within radius",
              params = {value = 150, inverse = true}
            },
            {
              goal = "Time trigger",
              params = {value = 2}
            }
          }
        },
        taskConditions = {
          {
            {
              goal = "Empty dynamicTargets"
            }
          },
          {
            {
              goal = "Specified actors have finished race",
              params = {
                actors = {"Tanner"},
                value = 1
              }
            }
          }
        }
      }
    }
  }
  return task
end
local alleyChaserTask = function(goalParams, HUD)
  local task = {
    {
      {task = "No AI"}
    }
  }
  return task
end
missionSetupData.Alone.taskCreatorFunctionLookups = {
  ["Tanner team"] = tannerTask,
  ["Evader team"] = evaderTask,
  ["Chaser 1"] = chaserTaskAhead,
  ["Chaser 2"] = chaserTaskAhead,
  ["Chaser 3"] = chaserTaskAhead,
  ["Chaser Temp behind 1"] = fakeChaserTask,
  ["Chaser Temp behind 2"] = fakeChaserTask,
  ["Chase team"] = chaserTaskBehind,
  ["Alley Chaser team"] = alleyChaserTask
}
local spawnActor = function(actorID, instance)
  challengeSystem.spawnActors(instance, "Never", {
    [actorID] = true
  })
  GameVehicleResource.upgradeOccupants(instance.taskObjectsByActorID[actorID].coreData.agent.gameVehicle)
  return true
end
local moodLocation = vec.vector(-1416.6, 38.99934, 1218.256, 1)
local doorwayLocation = vec.vector(433.541, 18.09454, 1759.659, 1)
local doorwayLocation2 = vec.vector(298.9255, 21.62483, 1752.496, 1)
local requiredActors = {}
local top = false
local triggerRavens = true
local puzzleCompleted = false
function missionSetupData.Alone.initiate(instance)
  requiredActors = {}
  local softSaveData = progressionSystem.getSoftSaveData()
  if softSaveData then
    if not puzzleCompleted then
      localPlayer:blockAbility("ram", true)
      localPlayer:blockAbility("nitro", true)
      localPlayer:showHUDElements(false)
      scoreSystem.blockWillpowerPrompt(true)
      localPlayer.blockHUD = true
      feedbackSystem.menusMaster.focusHintButtonState(true)
    else
      table.insert(requiredActors, "Chaser 2")
      table.insert(requiredActors, "Chaser 3")
    end
    spooling.enableTraffic(false)
    characterManager.DisablePeds()
    Sound.OverrideAmbience("Alone")
    feedbackSystem.menusMaster.setNextFocusString()
    GameVehicleResource.setCharacterSpoolingEntityIndex(instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle, 1, "-1")
    if softSaveData.progression < 5 then
      spooling.fadeOut(vec.vector(1, 1, 1, 1))
    else
      feedbackSystem.startMusic("Uid03842_CH07_Story_DejaVu_Play")
      instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 22.35
      feedbackSystem.menusMaster.setCurrentFocusString(4)
    end
    moodSystem.applyMood("Alone")
  else
    if puzzleCompleted then
      puzzleCompleted = false
    end
    createFixedPosition(instance, {moodLocation}, 67)
    createFixedPosition(instance, {
      [8] = vec.vector(-489.7605, 35.39896, 1353.204, 1)
    }, 150)
    createFixedPosition(instance, {
      [8] = vec.vector(-356.9068, 23.42737, 1232.186, 1)
    }, 151)
    createFixedPosition(instance, {
      [8] = vec.vector(-437.0446, 47.43035, 1457.748, 1)
    }, 152)
    createFixedPosition(instance, {
      [8] = vec.vector(-499.921, 32.17048, 1321.589, 1)
    }, 153)
    createFixedPosition(instance, {
      [8] = vec.vector(-449.4713, 32.69183, 1338.666, 1)
    }, 154)
    createFixedPosition(instance, {
      [8] = vec.vector(-465.7425, 42.42625, 1399.481, 1)
    }, 155)
    createFixedPosition(instance, {
      [8] = vec.vector(-549.0428, 38.09527, 1374.62, 1)
    }, 156)
    createFixedPosition(instance, {
      [8] = vec.vector(-369.1158, 22.8484, 1266.76, 1)
    }, 157)
  end
  top = false
  groundRavenID = nil
  flyingRavenID = nil
  localPlayer:blockAbility("zap", true)
  createCheckpoints(instance)
  createFixedPosition(instance, {doorwayLocation}, 68)
  createFixedPosition(instance, {doorwayLocation}, 168)
  createFixedPosition(instance, {doorwayLocation2}, 169)
  createFixedPosition(instance, {
    [8] = vec.vector(-115.8857, 31.45712, 2011.007, 1)
  }, 69)
  propSystem.disablePropType("DO_NOT_USE_shutter_A", "DO_NOT_USE_shutter_B", "DO_NOT_USE_Wall_A")
  Atlas.JerichoAlleyWayActive(true)
  for name, puzzle in next, puzzlesInfo, nil do
    for positionIndex, position in next, puzzle.exitPositions, nil do
      createFixedPosition(instance, {position}, puzzle.index)
    end
  end
  scene = {
    {
      action = "attach",
      lookAt = instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle,
      lookAtOffset = vec.vector(0, 0, 0, 1),
      lookFrom = puzzlesInfo["In puzzle1"].cameraPosition,
      fov = 1.047167,
      infiniteLength = true
    }
  }
end
local respawnVehicles = true
missionSetupData.Alone.update = nil
local workingVector = vec.vector(0, 0, 0, 0)
local distance = vec.vector()
local carPos = vec.vector()
local lookAtVector = vec.vector()
local lookAtPoint = vec.vector()
local lookAtBias
local function tannerDynamicTargets(taskObject, task, dynamicListID)
  local function getOffsetPosition(actionDistance)
    lookAtBias = (actionDistance - distance) / actionDistance
    lookAtBias = lookAtBias * lookAtBias
    lookAtPoint = workingVector:add(carPos, lookAtVector * lookAtBias)
    local vehicleMatrix = task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.transform
    local transposeVehicleMatrix = vehicleMatrix:transpose()
    lookAtPoint = lookAtPoint - vehicleMatrix[3]
    return transposeVehicleMatrix * lookAtPoint
  end
  local function cameraOverride()
    local actionDistance = puzzlesInfo[task.specialName].actionRadius
    CameraSystem.SetAttachmentLookAtOffset(actionDistance)
    CameraSystem.AddScene(scene)
    return function()
      if task.instance.taskObjectsByActorID.Tanner then
        carPos = task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.position
        distance = workingVector:sub(carPos, puzzlesInfo[task.specialName].relativePoint):length()
        lookAtVector = workingVector:sub(puzzlesInfo[task.specialName].focusPoint, carPos)
        if distance < actionDistance then
          CameraSystem.SetAttachmentLookAtOffset(getOffsetPosition(actionDistance))
        else
          scene[1].action = "attach"
          scene[1].lookAt = task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
          CameraSystem.SetAttachmentLookAtOffset(vec.vector(0, 0, 0, 1))
        end
      end
    end
  end
  local function zapPlayer(white, initialSetup, disableFade)
    local function onFadeOut()
      if initialSetup then
        VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
        triggerRavens = true
        groundRavenID = characterManager.addPerchedRavens(puzzlesInfo[task.specialName].ravenGroundPosition, 1, 30, 8)
        flyingRavenID = characterManager.addCirclingRavens(puzzlesInfo[task.specialName].ravenColumnPosition, 12)
        taskObject.coreData.agent.blockCamChange = true
        Sound.SetAttenuationFactor("Collision", 4)
        Sound.SetAttenuationFactor("PlayerVehicle", 4)
        Sound.OverrideEnvironment("AMB_REVERB_RAVENEYE", 1)
        scene[1].lookFrom = puzzlesInfo[task.specialName].cameraPosition
        OneShotSound.Play("Mis_Alone_Car_Alarm_Play")
        CameraSystem.AddScene(scene)
        ReplaySystem.StartScriptedCamera()
      end
    end
    if groundRavenID then
      characterManager.removeRavenGroup(groundRavenID)
    end
    if flyingRavenID then
      characterManager.removeRavenGroup(flyingRavenID)
    end
    if white then
      local function addCameraFunction()
        if task.specialName ~= "In puzzle1" then
          addUserUpdateFunction("cameraOverride", cameraOverride(), 1)
        end
        localPlayer:showHUDElements(false)
        scoreSystem.blockWillpowerPrompt(true)
        localPlayer.blockHUD = true
      end
      ReplaySystem.StartScriptedCamera()
      taskObject.coreData.agent:teleportToPositionAndHeading(puzzlesInfo[task.specialName].startPosition, puzzlesInfo[task.specialName].startHeading, onFadeOut, function()
        taskObject.coreData.agent.gameVehicle.speed = 22.35
      end, addCameraFunction, true, vec.vector(1, 1, 1, 1))
      localPlayer:getTaskObject().coreData.agent:set_damageMultiplier(0)
    else
      triggerRavens = true
      groundRavenID = characterManager.addPerchedRavens(puzzlesInfo[task.specialName].ravenGroundPosition, 1, 30, 8)
      flyingRavenID = characterManager.addCirclingRavens(puzzlesInfo[task.specialName].ravenColumnPosition, 12)
      local function fadeAudio()
        if task.specialName == "In puzzle1" then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_5A")
        elseif task.specialName == "In puzzle2" then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_8A")
        end
        localPlayer:showHUDElements(false)
        scoreSystem.blockWillpowerPrompt(true)
        localPlayer.blockHUD = true
        if wrongTurns == 3 then
          feedbackSystem.menusMaster.primaryTextPrompt("ID:236264", nil, false, false, false)
        end
      end
      ReplaySystem.StartScriptedCamera()
      taskObject.coreData.agent:teleportToPositionAndHeading(puzzlesInfo[task.specialName].startPosition, puzzlesInfo[task.specialName].startHeading, onFadeOut, function()
        taskObject.coreData.agent.gameVehicle.speed = 22.35
      end, fadeAudio, true)
    end
  end
  if task.specialName == "drive under bridge" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 157), false
    end
  elseif string.find(task.specialName, "In puzzle") then
    local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, puzzlesInfo[task.specialName].index)
    if dynamicListID then
      if puzzlesInfo[task.specialName].exitPositions[1] == task.dynamicTargets[dynamicListID].position then
        wrongTurns = 0
        if task.specialName ~= "In puzzle4" then
          spooling.fadeOut(vec.vector(1, 1, 1, 1), nil, function()
            endOfPuzzle(task, taskObject)
          end)
        end
        return false, true
      else
        wrongTurns = wrongTurns + 1
        print("WRONG TURNS +1 = " .. tostring(wrongTurns))
        zapPlayer(false, false, false)
        return {
          task.dynamicTargets[dynamicListID]
        }, false
      end
    else
      local disableFade = false
      if task.specialName == "In puzzle1" then
        disableFade = true
      end
      zapPlayer(true, true, false)
      return allCheckpoints, false
    end
  elseif string.find(task.specialName, "raven position") then
    if dynamicListID then
      if triggerRavens then
        characterManager.OutdoorCharacter_TriggerEvent("TRIGGER_TAKEOFF", "eCharacter_Bird", groundRavenID, -1)
        if ravenAudioPlayID == 0 then
          local position, velocity, direction = vec.vector(0, 0, 0, 0), vec.vector(0, 0, 0, 0), vec.vector(1, 0, 0, 0)
          if task.specialName == "raven position1" then
            position = puzzlesInfo["In puzzle1"].ravenGroundPosition
          elseif task.specialName == "raven position2" then
            position = puzzlesInfo["In puzzle2"].ravenGroundPosition
          elseif task.specialName == "raven position3" then
            position = puzzlesInfo["In puzzle3"].ravenGroundPosition
          elseif task.specialName == "raven position4" then
            position = puzzlesInfo["In puzzle4"].ravenGroundPosition
          end
          ravenAudioPlayID = OneShotSound.PlayAtPosition("Mis_Alone_RavenEye_Positive_Play", position, velocity, direction)
        end
        triggerRavens = false
      end
      return {
        task.dynamicTargets[dynamicListID]
      }, false
    elseif task.specialName == "raven position1" then
      return {
        {
          position = puzzlesInfo["In puzzle1"].ravenGroundPosition
        }
      }, false
    elseif task.specialName == "raven position2" then
      return {
        {
          position = puzzlesInfo["In puzzle2"].ravenGroundPosition
        }
      }, false
    elseif task.specialName == "raven position3" then
      return {
        {
          position = puzzlesInfo["In puzzle3"].ravenGroundPosition
        }
      }, false
    elseif task.specialName == "raven position4" then
      return {
        {
          position = puzzlesInfo["In puzzle4"].ravenGroundPosition
        }
      }, false
    end
  elseif task.specialName == "destination hotspot" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 150), false
    end
  elseif task.specialName == "drive to doorway" then
    if dynamicListID then
      if task.dynamicTargets[dynamicListID].position == doorwayLocation then
        moodSystem.removeMood("Alone", 5)
        return checkpointSystem.getCheckpoints(task.instance, 169), false
      else
        return false, true
      end
    else
      return checkpointSystem.getCheckpoints(task.instance, 168), false
    end
  elseif task.specialName == "getting close to doorway" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 68), false
    end
  elseif task.specialName == "alley chase" then
    if dynamicListID then
      return false, true
    else
      return checkpointSystem.getCheckpoints(task.instance, 69), false
    end
  end
end
local evaderDynamicTargets = function(taskObject, task, dynamicListID)
  local allCheckpoints = checkpointSystem.getCheckpoints(task.instance, task.actor.checkpointGroup)
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
local chaserDynamicTargets = function(taskObject, task, dynamicListID, goalCondition)
  if dynamicListID then
    return false, true
  else
    return {
      task.instance.taskObjectsByActorID.Tanner.coreData.agent
    }, false
  end
end
missionSetupData.Alone.targetList = {
  ["Tanner team"] = tannerDynamicTargets,
  ["Evader team"] = evaderDynamicTargets,
  ["Chase team"] = chaserDynamicTargets
}
local function triggerRespawn(instance)
  printTable(requiredActors)
  for i, actorID in ripairs(requiredActors) do
    if respawnVehicles or not respawnVehicles and actorID ~= "Chaser 1" and actorID ~= "Chaser 2" and actorID ~= "Chaser 3" then
      spawnActor(actorID, instance)
      table.remove(requiredActors, i)
      if actorID == "Chaser 4" or actorID == "Chaser 5" then
        instance.taskObjectsByActorID[actorID].coreData.agent.gameVehicle.performance = 1.5
      end
    end
  end
end
taskCompleteData.Alone = {}
function taskCompleteData.Alone.taskComplete(taskObject, task)
  local params = {
    vehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent,
    successReason = "ID:173973",
    failReason = "ID:184950",
    hint = ""
  }
  if task.specialName == "drive under bridge" then
    params.hint = "ID:235485"
    params.hintIcon1 = localPlayer.buttonLayout.minimapZoom
  elseif string.find(task.specialName, "In puzzle") or string.find(task.specialName, "time delay") or task.specialName == "out of alley after puzzles" then
    params.hint = "ID:236264"
    if string.find(task.specialName, "In puzzle") then
      removeUserUpdateFunction("cameraOverride")
      localPlayer:getTaskObject().coreData.agent:set_damageMultiplier(0.48)
    end
  elseif task.specialName == "mass chase" or task.specialName == "drive to doorway" then
    params.hint = "ID:236265"
  end
  local function completeTask()
    feedbackSystem.menusMaster.masterSetVariable("iPrompt_Primary_Display", 0)
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  if task.specialName == "time delay4" and task.success then
  elseif task.specialName == "spawn group 1" then
  end
  local function failUserUpdate()
    if not localPlayer.inCutscene then
      params.reason = "Wrecked"
      Sound.RestoreAmbience()
      params.rating = "FAIL"
      params.dialogue = "GPMV01_FAILURE_L_1"
      params.callback = failTask
      localPlayer.challenge.endScreen(taskObject, params)
      removeUserUpdateFunction("Failing")
    end
  end
  if taskObject.coreData.actor.team == "Tanner team" then
    if task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.damage >= 1 then
      params.reason = "Wrecked"
      Sound.RestoreAmbience()
      params.rating = "FAIL"
      params.dialogue = "GPMV01_FAILURE_L_1"
      params.callback = failTask
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.specialName == "drive under bridge" then
      localPlayer.cameraSupport.miniSceneCamera()
      OneShotSound.Play("HUD_Play_Waypoint")
      engineCutscene.playCutscene("mis_ch7_dejavu_01", function()
        moodSystem.applyMood("Alone", 0.1, nil)
        localPlayer.blockHUD = true
      end, function()
        spooling.enableTraffic(false)
        felony_patrollingVehicleManager.enablePatrollingVehicles(false)
        characterManager.DisablePeds()
        GameVehicleResource.setCharacterSpoolingEntityIndex(task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle, 1, "-1")
        Sound.OverrideAmbience("Alone")
        localPlayer:blockAbility("ram", true)
        localPlayer:blockAbility("nitro", true)
        localPlayer:resetCameraMode()
        feedbackSystem.menusMaster.setNextFocusString()
      end)
    elseif task.specialName == "first wander" then
      taskObject.coreData.raceFinished = nil
      feedbackSystem.menusMaster.primaryTextPrompt(prompts.exploreArea, nil, true)
    elseif task.specialName == "softsave1" then
      localPlayer:showHUDElements(false)
      scoreSystem.blockWillpowerPrompt(true)
      localPlayer.blockHUD = true
      feedbackSystem.menusMaster.focusHintButtonState(true)
      progressionSystem.triggerSoftSave({progression = 1})
    elseif task.specialName == "softsave2" then
      progressionSystem.triggerSoftSave({progression = 2})
    elseif task.specialName == "softsave3" then
      progressionSystem.triggerSoftSave({progression = 3})
    elseif task.specialName == "softsave4" then
      progressionSystem.triggerSoftSave({progression = 4})
    elseif task.specialName == "softsave5" then
      progressionSystem.triggerSoftSave({progression = 5})
    elseif task.specialName == "softsave6" then
      puzzleCompleted = true
      engineCutscene.playCutscene("mis_ch7_dejavu_02", function()
        taskObject.coreData.agent:teleportToPositionAndHeading(vec.vector(-1419.829, 21.67484, 130.1826, 1), 0.6757931)
      end, function()
        endOfPuzzle(task, taskObject)
        localPlayer.blockHUD = false
        feedbackSystem.menusMaster.setNextFocusString()
        task.instance.taskObjectsByActorID.Tanner.coreData.agent:set_damageMultiplier(0.275)
        VEdit.ResetVehicleDamage()
        localPlayer:blockAbility("ram", false)
        localPlayer:blockAbility("nitro", false)
        challengeSystem.spawnActors(task.instance, "Never", {
          ["Chaser 1"] = true
        })
        table.insert(requiredActors, "Chaser 2")
        table.insert(requiredActors, "Chaser 3")
        spawnActor("Chaser 4", task.instance)
        spawnActor("Chaser 5", task.instance)
        spawnActor("Chaser Temp behind 1", task.instance)
        spawnActor("Chaser Temp behind 2", task.instance)
        task.instance.taskObjectsByActorID["Chaser 4"].coreData.agent.gameVehicle.performance = 1.5
        task.instance.taskObjectsByActorID["Chaser 5"].coreData.agent.gameVehicle.performance = 1.5
        task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.speed = 15
        task.instance.taskObjectsByActorID.Tanner.coreData.agent:set_damageMultiplier(0.25)
        progressionSystem.triggerSoftSave({progression = 6})
      end)
    elseif task.specialName == "out of alley after puzzles" then
    elseif task.specialName == "mass chase" then
      feedbackSystem.menusMaster.setNextFocusString()
      feedbackSystem.menusMaster.primaryTextPrompt(prompts.endAppear)
    elseif task.specialName == "getting close to doorway" then
      respawnVehicles = false
    elseif task.specialName == "Wait for cutscene2" then
      feedbackSystem.startMusic("Uid03842_CH07_Story_DejaVu_Play")
    elseif task.specialName == "drive to doorway" then
      localPlayer.controllerInterface:removePlayerControl(true)
      Sound.RestoreAmbience()
      taskObject.coreData.agent:set_damageMultiplier(0)
      feedbackSystem.stopMusic("Uid03842_CH07_Story_DejaVu_Stop")
      OneShotSound.Play("HUD_Play_Waypoint")
      localPlayer:blockAbility("ram", true)
      localPlayer:blockAbility("nitro", true)
      engineCutscene.playCutscene("ch7_crash2_01", function()
        taskObject.coreData.agent:teleportToPositionAndHeading(vec.vector(242.2487, 24.70326, 1782.354, 1), -1.028577)
        GameVehicleResource.setCharacterSpoolingEntityIndex(task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle, 1, "-1916574018")
      end, function()
        task.instance.taskObjectsByActorID.Tanner.coreData.agent.blockCamChange = true
        if localPlayer.cameraMode ~= "DriverEye" then
          CameraSystemRegisterUpdate("Game_Cam", game_camera, "simulation", Camera_Function_Vehicle_Driver_Eye_Cam, {
            agent = task.instance.taskObjectsByActorID.Tanner.coreData.agent
          })
          VehicleSystem.setPlayerVehicleVisible(1, localPlayer.localID)
        end
        challengeSystem.spawnActors(task.instance, "Never", {
          ["Alley Chaser"] = true
        })
        AlleyChaser.setChaser(task.instance.taskObjectsByActorID["Alley Chaser"].coreData.agent.gameVehicle)
        AlleyChaser.SetControl(true)
        taskObject.coreData.agent.gameVehicle.velocity = taskObject.coreData.agent.gameVehicle.matrix[2] * 15
        feedbackSystem.menusMaster.blockHintButton(true)
        VEdit.ResetVehicleDamage()
      end, function()
        localPlayer:showHUDElements(false)
        scoreSystem.blockWillpowerPrompt(true)
        localPlayer.blockHUD = true
        localPlayer.controllerInterface:registerPlayerControl()
      end, 1, 0)
    elseif task.specialName == "alley chase" then
      AlleyChaser.SetControl(false)
      localPlayer:resetCameraMode()
      params.callback = completeTask
      params.rating = "PASS"
      localPlayer.challenge.endScreen(taskObject, params)
    end
  elseif task.specialName == "chase tanner" and task.condition == 1 and task.actor.ID ~= "Chaser Temp behind 1" and task.actor.ID ~= "Chaser Temp behind 2" then
    table.insert(requiredActors, taskObject.coreData.actor.ID)
    taskObject:delete()
    triggerRespawn(task.instance)
  end
end
function missionEndCallback.Alone(instance)
  instance.challenge.actorPool.Evader.routeName = nil
  moodSystem.removeMood("Alone", 0)
  moodSystem.removeMood("Alone end of alley", 0)
  ReplaySystem.StopScriptedCamera()
  propSystem.reenableAllPropTypes()
  Atlas.JerichoAlleyWayActive(false)
  AlleyChaser.SetControl(false)
  localPlayer.blockHUD = false
  respawnVehicles = true
  removeUserUpdateFunction("cameraOverride")
  if groundRavenID then
    characterManager.removeRavenGroup(groundRavenID)
  end
  if flyingRavenID then
    characterManager.removeRavenGroup(flyingRavenID)
  end
  localPlayer:blockAbility("zap", false)
  localPlayer:blockAbility("nitro", false)
  localPlayer:blockAbility("ram", false)
  scoreSystem.blockWillpowerPrompt(false)
  spooling.enableTraffic(true)
  felony_patrollingVehicleManager.enablePatrollingVehicles(true)
  characterManager.EnablePeds()
  enableAbilities(localPlayer.localID, true)
  if ravenAudioPlayID ~= 0 then
    OneShotSound.Stop(ravenAudioPlayID, "Mis_Alone_RavenEye_Positive_Stop")
    ravenAudioPlayID = 0
  end
  Sound.SetAttenuationFactor("Collision", 1)
  Sound.SetAttenuationFactor("PlayerVehicle", 1)
  Sound.RestoreEnvironment()
end
