module("cardSystem.logic")
missionSetupData["Multiplayer vehicle swap tutorial"] = {}
missionSetupData["Multiplayer vehicle swap tutorial"].buildSpawnPositionFunctions = {
  [1] = function(spawnPosition)
    spawnPosition.target = routes.Tutorial_Start_Locations.checkpoints[1].position
    spawnPosition.positionA = routes.Tutorial_Start_Locations.checkpoints[1].position
    spawnPosition.headingA = routes.Tutorial_Start_Locations.checkpoints[1].heading
  end
}
missionSetupData["Multiplayer vehicle swap tutorial"].clearSpawnPositionFunction = function(spawnPosition)
  spawnPosition.target = nil
  spawnPosition.positionA = nil
  spawnPosition.headingA = nil
end
missionSetupData["Multiplayer vehicle swap tutorial"].spawnPositions = {
  [1] = {
    routeName = "RouteData\\MP_Tutorials.lua",
    moods = {
      [1] = "OnlineDefault"
    },
    vehicleSet = {
      {
        vehicleID = 62,
        shader = {
          [0] = 0
        }
      }
    },
    lockingZoneData = {
      name = "Online_Tutorial"
    }
  }
}
missionSetupData["Multiplayer vehicle swap tutorial"].usableRouteIndicies = {
  [1] = 1
}
local wellDoneObjectiveTimer = 3
local showObjectiveTimer = 3.5
local blockTextTimer = 2
local showPanelDelay = 1
local errorTimer = 0.1
local failedtimer = 3
local completeTimer = 4
local function getPlayerTaskList()
  return {
    [1] = {
      [1] = {
        task = "MP vehicle swap tutorial",
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
                value = {promptID = 1, subgroup = 4}
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
                value = {promptID = 1, subgroup = 5}
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
                value = {promptID = 1, subgroup = 6}
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
                value = {promptID = 1, subgroup = 1}
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
                value = {promptID = 1, subgroup = 2}
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
                value = {promptID = 1, subgroup = 3}
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
        task = "MP vehicle swap tutorial",
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
                value = {promptID = 2, subgroup = 1}
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
                value = {promptID = 2, subgroup = 2}
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
                value = {promptID = 2, subgroup = 3}
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
                value = {promptID = 2, subgroup = 4}
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
                value = {promptID = 2, subgroup = 2}
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
                value = {promptID = 2, subgroup = 5}
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
        task = "MP vehicle swap tutorial",
        goalConditions = {
          {
            {
              goal = "Are zap weapons available",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {extraData = 2}
              }
            }
          },
          {
            {
              goal = "Are zap weapons available",
              params = {value = true}
            },
            {
              goal = "Are zap weapons available",
              params = {value = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {
                  welldone = true,
                  clear = true,
                  tick = 2
                }
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
        task = "No functionality",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            }
          }
        }
      }
    },
    [5] = {
      [1] = {
        task = "MP vehicle swap tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {promptID = 3, subgroup = 1}
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
                value = {promptID = 2, subgroup = 2}
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
                value = {promptID = 2, subgroup = 3}
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
                value = {promptID = 3, subgroup = 4}
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
                value = {promptID = 2, subgroup = 2}
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
                value = {promptID = 3, subgroup = 5}
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
        task = "MP vehicle swap tutorial",
        goalConditions = {
          {
            {
              goal = "Are zap weapons available",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {extraData = 2}
              }
            }
          },
          {
            {
              goal = "Are zap weapons available",
              params = {value = true}
            },
            {
              goal = "Are zap weapons available",
              params = {value = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {
                  welldone = true,
                  clear = true,
                  tick = 2
                }
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
        task = "No functionality",
        taskConditions = {
          {
            {
              goal = "Time trigger",
              params = {value = wellDoneObjectiveTimer}
            }
          }
        }
      }
    },
    [8] = {
      [1] = {
        task = "MP vehicle swap tutorial",
        goalConditions = {
          {
            {
              goal = "General mechanics tasks complete",
              params = {value = 1, complete = false}
            },
            {
              goal = "Pass ID",
              params = {
                value = {promptID = 4, subgroup = 1}
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
                value = {promptID = 2, subgroup = 2}
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
                value = {promptID = 2, subgroup = 3}
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
                value = {promptID = 4, subgroup = 4}
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
                value = {promptID = 2, subgroup = 2}
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
                value = {promptID = 4, subgroup = 5}
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
        task = "MP vehicle swap tutorial",
        goalConditions = {
          {
            autoRefresh = true,
            {
              goal = "Are zap weapons available",
              params = {value = false}
            },
            {
              goal = "Are zap weapons available",
              params = {value = true}
            },
            {
              goal = "Pass ID",
              params = {
                value = {extraData = 2}
              }
            }
          },
          {
            autoRefresh = true,
            {
              goal = "Are zap weapons available",
              params = {value = true}
            },
            {
              goal = "Are zap weapons available",
              params = {value = false}
            },
            {
              goal = "Time trigger",
              params = {value = failedtimer}
            },
            {
              goal = "Pass ID",
              params = {
                value = {extraData = 6}
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
        task = "MP vehicle swap tutorial",
        goalConditions = {
          {
            {
              goal = "Pass ID",
              params = {
                value = {
                  welldone = true,
                  clear = true,
                  tick = 2
                }
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
missionSetupData["Multiplayer vehicle swap tutorial"].taskCreatorFunctionLookups = {
  ["Player Pool"] = getPlayerTaskList
}
missionSetupData["Multiplayer vehicle swap tutorial"].setupDataGenerator = function(goalParams)
  return {
    settings = {
      minPlayers = 1,
      gridStyle = 1,
      missionVehicleStyle = 1,
      moodStyle = 2,
      introHUD = "MP tutorial start HUD",
      tutorial = true,
      tutorialStatID = 1,
      disableZapOnCompletion = true
    }
  }
end
missionSetupData["Multiplayer vehicle swap tutorial"].initiate = function(instance)
end
missionSetupData["Multiplayer vehicle swap tutorial"].assignTaskObjects = function(instance, player, vehicle)
end
missionSetupData["Multiplayer vehicle swap tutorial"].missionStart = function(instance)
  Presence.setPresence(10, 143)
  feedbackSystem.menusMaster.currentHUDSetVariable("iZapFuel_Display", 0)
  scoreSystem.stopAbilityDrain(0, true)
  scoreSystem.stopAbilityGain(0, true)
  localPlayer:blockAbility("zap", true)
  localPlayer:blockAbility("ZapSpawn", true)
  localPlayer:blockAbility("ZapAttack", true)
  localPlayer:blockAbility("ZapImpulse", true)
  localPlayer:blockAbility("nitro", true)
  localPlayer:blockAbility("ram", true)
  localPlayer.currentVehicle:set_damageMultiplier(0)
  zapWeaponSupport.setZapWeaponCooldownTime(5)
  zapWeaponSupport.enableZapWeapons(true)
  if not onlineProgressionSystem.onlineWeaponData[1].unlocked then
    onlineProgressionSystem.onlineWeaponData[1].unlocked = true
    onlineProgressionSystem.onlineWeaponData[1].unlockFunc()
  end
  zap.SetZapInOverride(function()
  end)
  vehicleManager.activeVehicles.disableVehicleSelectFeedback = true
  ActiveVehicles.setActiveVehicleSlot(0)
  ActiveVehicles.changeActive(0, 173, 0)
  ActiveVehicles.setUnlockedSlots(1)
  vehicleManager.activeVehicles.disableVehicleSelectFeedback = false
  feedbackSystem.menusMaster.onlineHUDSetVariable("iWillpower_Disc", 5)
  zapWeaponSupport.paused()
  zapWeaponSupport.pauseZapWeaponFuel(true)
  localPlayer.controllerInterface:removePlayerControl()
  localPlayer.controllerInterface:createCallbacks()
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Stripes", 1)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Icon", 14)
end
missionSetupData["Multiplayer vehicle swap tutorial"].modeReadyCheck = function(instance)
  return true
end
missionSetupData["Multiplayer vehicle swap tutorial"].update = function(instance)
  onlineInstructionSupport.step()
end
local restoreAbilities = function()
  zapWeaponSupport.resetZapWeaponCooldown()
  localPlayer:blockAbility("zap", false)
  localPlayer:blockAbility("ZapSpawn", false)
  localPlayer:blockAbility("ZapAttack", false)
  localPlayer:blockAbility("ZapImpulse", false)
  localPlayer:blockAbility("nitro", false)
  localPlayer:blockAbility("ram", false)
  zap.zapSwap.tutorialPromptsActive = false
  zap.SetZapInOverride(nil)
  zapWeaponSupport.pauseZapWeaponFuel(false)
  if onlineProgressionSystem.getLocalPlayerLevel() < onlineProgressionSystem.getWeaponLevelRequirement(1) then
    onlineProgressionSystem.onlineWeaponData[1].unlocked = false
  end
  zapWeaponSupport.enableZapWeapons(false)
  vehicleManager.activeVehicles.disableVehicleSelectFeedback = true
  if onlineProgressionSystem.onlineUpgradeData[1].unlocked then
    ActiveVehicles.setActiveVehicleSlot(0)
    ActiveVehicles.setUnlockedSlots(2)
  elseif onlineProgressionSystem.onlineWeaponData[1].unlocked then
    ActiveVehicles.setActiveVehicleSlot(0)
    ActiveVehicles.setUnlockedSlots(1)
  else
    ActiveVehicles.setActiveVehicleSlot(0)
    ActiveVehicles.setUnlockedSlots(0)
  end
  vehicleManager.activeVehicles.disableVehicleSelectFeedback = false
end
missionSetupData["Multiplayer vehicle swap tutorial"].missionEnd = function(instance)
  restoreAbilities()
  localPlayer.controllerInterface:registerPlayerControl()
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel", 0)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Panel_Continue_Prompt", 2)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Stripes", 2)
  feedbackSystem.menusMaster.currentHUDSetVariable("iTutorial_Icon", 0)
  scoreSystem.stopAbilityDrain(0, false)
  scoreSystem.stopAbilityGain(0, false)
end
missionSetupData["Multiplayer vehicle swap tutorial"].onlineProgressionData = {
  localPlayer = {
    getMatchBonus = function(timeInMode, threshold, baseXPValue, gainedXP)
      return baseXPValue
    end
  }
}
missionSetupData["Multiplayer vehicle swap tutorial"].onlineStatisticsData = function()
  onlineStatistics.updateOverallScoreStatistic(onlineProgressionSystem.getLocalPlayerXPGained())
end
taskCompleteData["Multiplayer vehicle swap tutorial"] = {}
taskCompleteData["Multiplayer vehicle swap tutorial"].taskComplete = function(taskObject, task)
  if task.specialName == "EndTask" then
    onlineProgressionSystem.progressionMissionComplete(true)
    restoreAbilities()
    local instance = taskObject.coreData.instance
    if instance.isLocal then
      instance:initiateOverTimePhase()
    end
  end
end
