module("cardSystem.logic")
missionSetupData = missionSetupData or {}
missionSetupData["Multiplayer shift take tutorial"] = {}
missionSetupData["Multiplayer shift take tutorial"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.target = routes.Tutorial_Start_Locations.checkpoints[1].position
    spawnPosition.positionA = routes.Tutorial_Start_Locations.checkpoints[1].position
    spawnPosition.headingA = routes.Tutorial_Start_Locations.checkpoints[1].heading
    spawnPosition.positionB = routes.Tutorial_Start_Locations.checkpoints[2].position
    spawnPosition.headingB = routes.Tutorial_Start_Locations.checkpoints[2].heading
  end
}
missionSetupData["Multiplayer shift take tutorial"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
  spawnPosition.positionB = nil
  spawnPosition.headingB = nil
end
missionSetupData["Multiplayer shift take tutorial"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\MP_Tutorials.lua",
    vehicleSet = {
      {
        vehicleID = 62,
        shader = {
          [0] = 0
        }
      }
    },
    trafficSet = 2,
    missionVehicle = 62,
    moods = {
      [1] = "OnlineDefault"
    },
    lockingZoneData = {
      name = "Online_Tutorial"
    }
  }
}
missionSetupData["Multiplayer shift take tutorial"].usableRouteIndicies = {
  [1] = 1
}
local wellDoneObjectiveTimer = 3
local showObjectiveTimer = 3.5
local blockTextTimer = 2
local showPanelDelay = 1
local errorTimer = 0.1
local completeTimer = 4
local getTargetVehicleTaskList = function()
  return {
    [1] = {
      [1] = {
        task = "No target",
        taskConditions = {
          {
            {
              goal = "MP Player in task vehicle",
              params = {value = true, localID = 0}
            },
            {
              goal = "Vehicle been zap impulsed"
            }
          }
        }
      }
    },
    [2] = {
      [1] = {
        task = "Follow Route",
        taskConditions = {
          {
            {
              goal = "Vehicle been zap impulsed"
            }
          }
        }
      }
    },
    [3] = {
      [1] = {
        task = "MP shift take tutorial",
        goalConditions = {
          {
            {
              goal = "Pass ID",
              params = {
                value = {setSpeed = true}
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
        task = "Follow Route"
      }
    }
  }
end
local function getPlayerTaskList(param1, param2, param3, agent)
  return {
    [1] = {
      [1] = {
        task = "MP shift take tutorial",
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
                value = {group = 1, subgroup = 4}
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
                value = {group = 1, subgroup = 5}
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
        task = "MP shift take tutorial",
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
                value = {group = 2, subgroup = 1}
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
                value = {group = 2, subgroup = 2}
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
                value = {group = 2, subgroup = 3}
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
                value = {group = 2, subgroup = 4}
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
                value = {group = 2, subgroup = 2}
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
                value = {group = 2, subgroup = 5}
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
                value = {group = 2, subgroup = 6}
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
                value = {group = 2, subgroup = 2}
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
                value = {group = 2, subgroup = 7}
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
        task = "MP shift take tutorial",
        goalConditions = {
          {
            {
              goal = "Player in objective vehicle",
              params = {value = true}
            },
            {
              goal = "Zap Impulsed Target Vehicle",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {welldone = true, stopVehicle = true}
              }
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Are zap weapons available",
              params = {value = true}
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
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Has zap lock on",
              params = {value = true}
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
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Are zap weapons available",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 3, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 3}
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
              goal = "Has zap lock on",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 3, complete = false}
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
        },
        HUD = {
          {
            style = "MP shift impulse tutorial HUD"
          }
        }
      }
    },
    [4] = {
      [1] = {
        task = "MP shift take tutorial",
        goalConditions = {
          {
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
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        },
        HUD = {
          {
            style = "MP shift impulse tutorial HUD"
          }
        }
      }
    },
    [5] = {
      [1] = {
        task = "MP shift take tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
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
              params = {value = 1, complete = false}
            },
            {
              goal = "Time trigger",
              params = {value = blockTextTimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 2, subgroup = 2}
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
                value = {group = 2, subgroup = 3}
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
                value = {group = 2, subgroup = 6}
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
                value = {group = 2, subgroup = 2}
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
                value = {group = 2, subgroup = 7}
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
            style = "MP shift impulse tutorial HUD"
          }
        }
      }
    },
    [6] = {
      [1] = {
        task = "MP shift take tutorial",
        goalConditions = {
          {
            {
              goal = "Player in objective vehicle",
              params = {value = true}
            },
            {
              goal = "Zap Impulsed Target Vehicle",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {welldone = true, stopVehicle = true}
              }
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Are zap weapons available",
              params = {value = true}
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
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Has zap lock on",
              params = {value = true}
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
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Are zap weapons available",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 3, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 3}
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
              goal = "Has zap lock on",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 3, complete = false}
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
        },
        HUD = {
          {
            style = "MP shift impulse tutorial HUD"
          }
        }
      }
    },
    [7] = {
      [1] = {
        task = "MP shift take tutorial",
        goalConditions = {
          {
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
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        },
        HUD = {
          {
            style = "MP shift impulse tutorial HUD"
          }
        }
      }
    },
    [8] = {
      [1] = {
        task = "MP shift take tutorial",
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
                value = {group = 4, subgroup = 1}
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
                value = {group = 2, subgroup = 2}
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
                value = {group = 2, subgroup = 3}
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
                value = {group = 2, subgroup = 6}
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
                value = {group = 2, subgroup = 2}
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
                value = {group = 2, subgroup = 7}
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
            style = "MP shift impulse tutorial HUD"
          }
        }
      }
    },
    [9] = {
      [1] = {
        task = "MP shift take tutorial",
        goalConditions = {
          {
            {
              goal = "Player in objective vehicle",
              params = {value = true}
            },
            {
              goal = "Zap Impulsed Target Vehicle",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {welldone = true}
              }
            }
          },
          {
            failCondition = true,
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Are zap weapons available",
              params = {value = true}
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
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 2, complete = false}
            },
            {
              goal = "Has zap lock on",
              params = {value = true}
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
            autoRefresh = true,
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = true}
            },
            {
              goal = "Are zap weapons available",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 3, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {group = 3}
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
              goal = "Has zap lock on",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = 1}
            },
            {
              goal = "General mechanics tasks complete",
              params = {value = 3, complete = false}
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
        },
        HUD = {
          {
            style = "MP shift impulse tutorial HUD"
          }
        }
      }
    },
    [10] = {
      [1] = {
        task = "MP shift take tutorial",
        goalConditions = {
          {
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
          }
        },
        taskConditions = {
          {
            {goal = "Task done"}
          }
        },
        HUD = {
          {
            style = "MP shift impulse tutorial HUD"
          }
        }
      }
    },
    [11] = {
      [1] = {
        task = "No functionality",
        specialName = "EndTask",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = completeTimer}
            }
          }
        }
      }
    }
  }
end
missionSetupData["Multiplayer shift take tutorial"].taskCreatorFunctionLookups = {
  ["Objective Team 1"] = getTargetVehicleTaskList,
  ["Player Pool"] = getPlayerTaskList
}
missionSetupData["Multiplayer shift take tutorial"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 1,
      gridStyle = 1,
      missionVehicleStyle = 1,
      moodStyle = 1,
      introHUD = "MP tutorial start HUD",
      tutorial = true,
      tutorialStatID = 3,
      disableZapOnCompletion = true
    }
  }
end
missionSetupData["Multiplayer shift take tutorial"].initiate = function(instance)
end
missionSetupData["Multiplayer shift take tutorial"].missionStart = function(instance)
  feedbackSystem.menusMaster.currentHUDSetVariable("iZapFuel_Display", 0)
  localPlayer:blockAbility("zap", true)
  localPlayer:blockAbility("ZapSpawn", true)
  localPlayer:blockAbility("ZapSwap", true)
  scoreSystem.emptyAbility()
  scoreSystem.stopAbilityGain(0, true)
  scoreSystem.stopAbilityDrain(0, true)
  localPlayer.currentVehicle:set_damageMultiplier(0)
  zapWeaponSupport.setZapWeaponCooldownTime(5)
  zapWeaponSupport.enableZapWeapons(true)
  if not onlineProgressionSystem.onlineWeaponData[4].unlocked then
    onlineProgressionSystem.onlineWeaponData[4].unlocked = true
  end
  zap.SetZapInOverride(function()
  end)
  feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 5)
  zapWeaponSupport.paused()
  zapWeaponSupport.pauseZapWeaponFuel(true)
  localPlayer.controllerInterface:createCallbacks()
  civilianTraffic.setTrafficOnOff(false)
  zapcontroller.setZapCameraLocks(0, {
    missile = false,
    low = true,
    mid = false,
    high = true,
    top = true
  })
  localPlayer.controllerInterface:removePlayerControl()
  zap.disableZapSelection()
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Stripes", 1)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Icon", 16)
end
missionSetupData["Multiplayer shift take tutorial"].assignTaskObjects = function(instance, player, vehicle)
  if player then
    local actor = instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[player.playerID + 1]]
    instance:newActorFromAgent(actor.ID, vehicle)
  else
    for playerID, player in next, playerManager.players, nil do
      if not instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]] then
        local vehicle = vehicleManager.vehiclesBySNVID[phaseManager.vehicleGrid[playerID + 1]]
        assert(vehicle.networkVars.onlineOwnerID == playerID, "SHIFT IMPULSE TUTORIAL, Creating taskObject for invalid vehicle")
        local actor = instance.challenge.actorPool[OBJ_TEAM_ONE_STRING_TABLE[playerID + 1]]
        instance:newActorFromAgent(actor.ID, vehicle)
      end
    end
  end
end
missionSetupData["Multiplayer shift take tutorial"].modeReadyCheck = function(instance)
  return true
end
local lastTaggedVehicle = -1
missionSetupData["Multiplayer shift take tutorial"].update = function(instance)
  onlineInstructionSupport.step()
end
local restoreAbilities = function()
  zapWeaponSupport.resetZapWeaponCooldown()
  localPlayer:blockAbility("zap", false)
  localPlayer:blockAbility("ZapSpawn", false)
  localPlayer:blockAbility("ZapSwap", false)
  scoreSystem.stopAbilityDrain(0, false)
  scoreSystem.stopAbilityGain(0, false)
  if onlineProgressionSystem.onlineWeaponData[1].unlocked then
    zapWeaponSupport.enableZapWeapons(true)
  else
    zapWeaponSupport.enableZapWeapons(false)
  end
  zap.SetZapInOverride(nil)
  zapWeaponSupport.pauseZapWeaponFuel(false)
  if onlineProgressionSystem.getLocalPlayerLevel() < onlineProgressionSystem.getWeaponLevelRequirement(4) then
    onlineProgressionSystem.onlineWeaponData[4].unlocked = false
  end
  zap.zapAttack.tutorialPromptsActive = false
  zap.zapAttack.tutorialPromptsActive2 = false
end
missionSetupData["Multiplayer shift take tutorial"].missionEnd = function(instance)
  restoreAbilities()
  zap.enableZapSelection()
  localPlayer.controllerInterface:registerPlayerControl()
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 0)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Continue_Prompt", 2)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Stripes", 2)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Icon", 0)
end
missionSetupData["Multiplayer shift take tutorial"].onlineProgressionData = {
  localPlayer = {
    getMatchBonus = function(timeInMode, threshold, baseXPValue, gainedXP)
      return baseXPValue
    end
  }
}
taskCompleteData = taskCompleteData or {}
taskCompleteData["Multiplayer shift take tutorial"] = {}
taskCompleteData["Multiplayer shift take tutorial"].taskComplete = function(taskObject, task)
  if task.specialName == "EndTask" then
    onlineProgressionSystem.progressionMissionComplete(true)
    restoreAbilities()
    local instance = taskObject.coreData.instance
    if instance.isLocal then
      instance:initiateOverTimePhase()
    end
  end
end
