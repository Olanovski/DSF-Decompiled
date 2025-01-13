cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Tutorial Mission 02 Ram"] = {
  FileVersion = "2",
  name = "Tutorial Mission 02 Ram",
  title = "ID:183882",
  MissionID = "7927",
  description = "ID:183881",
  cardInstances = {
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = true,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Ram tutorial",
          ["Audio logic file"] = "Ram tutorial APIP",
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
    Actors = {
      ["Tutorial actor"] = {
        [1] = {
          previewMovie = "preview vehicle",
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          vehicleTrailerId = -1,
          drivingSkill = "Average",
          vehicleId = 180,
          reactionTime = "Average",
          aiIgnorePlayers = false,
          enableSiren = false,
          damageMultiplier = 0.1,
          enableSimulationArea = false,
          forceHighLodCharacters = false,
          avoidAlleys = 0,
          wanderType = "random",
          selfRightIfOverturned = true,
          stayInLockedArea = false,
          whenSpawned = "Never",
          avoidUTurns = false,
          avoidAttacks = false,
          maintainLane = false,
          driveInOncoming = 0,
          driveOnPavements = 0
        },
        ["name"] = "Actor"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:183883",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Tutorial actor",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Tutorial mission 02 ram"] = {
        [1] = {
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          }
        },
        ["name"] = "Tutorial mission 02 ram"
      }
    }
  }
}
