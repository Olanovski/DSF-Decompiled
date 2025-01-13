cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Tutorial Mission 04 Aerial Jump"] = {
  FileVersion = "2",
  name = "Tutorial Mission 04 Aerial Jump",
  title = "TUTORIAL MISSION 04 AERIAL JUMP ",
  MissionID = "8439",
  description = "LEARN HOW TO USE THE AERIAL ZAP",
  cardInstances = {
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["New Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = true,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Hud logic file"] = "Tutorial mission 04 aerial jump HUD",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Audio logic file"] = "Shift tutorial level 1",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Actors = {
      ["Tutorial actor"] = {
        [1] = {
          previewMovie = "PREVIEW VEHICLE",
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          reactionTime = "Average",
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          drivingSkill = "Average",
          maintainLane = false,
          vehicleId = 272,
          shaderParam = 0,
          enableSiren = false,
          forceHighLodCharacters = false,
          enableSimulationArea = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          stayInLockedArea = false,
          whenSpawned = "Never",
          avoidUTurns = false,
          avoidAttacks = false,
          aiIgnorePlayers = false,
          matchTrafficSpeed = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:183937",
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
      ["New Tutorial mission 04 aerial jump"] = {
        [1] = {
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          }
        },
        ["name"] = "Tutorial mission 04 aerial jump"
      }
    }
  }
}
