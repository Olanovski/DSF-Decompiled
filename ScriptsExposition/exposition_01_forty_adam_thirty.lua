cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Exposition 01 Forty Adam Thirty"] = {
  FileVersion = "2",
  name = "Exposition 01 Forty Adam Thirty",
  title = "ID:182749",
  MissionID = "4343",
  description = "ID:221951",
  cardInstances = {
    Actors = {
      Tanner = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = true,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Cutscene"
          },
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 62,
          enableSimulationArea = true,
          isMultiplayerActor = false,
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          desiredSpeed = 50,
          matchTrafficSpeed = false,
          routeName = "Exposition_01_Forty_Adam_Thirty_Mission_Route",
          raceManagerRoute = true,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "no preview",
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["New Character"] = {
        [1] = {
          ["Passenger id"] = "-1916574018",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Clear area around vehicles"] = 20,
          ["Mission props"] = "Exposition pre crash drive",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Forty adam thrity mission start",
          ["Audio logic file"] = "Exposition pre crash drive",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["New Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["New Positions"] = {
        [1] = {
          ["1"] = "Tanner"
        },
        ["name"] = "Positions"
      },
      ["New Set position"] = {
        [1] = {
          ["Spawn location"] = "Exposition pre crash drive",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    WarmupTypes = {
      ["New Cutscene"] = {
        [1] = {forceMissionAccept = true},
        ["name"] = "Cutscene"
      }
    },
    FelonySettings = {
      ["Expo 03 sdasd FelonySettings 7"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          missionMarkers = {
            [1] = {
              value = "None",
              cardName = "Tanner",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Exposition 01 Forty Adam Thirty"] = {
        [1] = {
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          }
        },
        ["name"] = "Exposition 01 Forty Adam Thirty"
      }
    }
  }
}
