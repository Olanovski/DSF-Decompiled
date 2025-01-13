cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Tutorial Mission 01 Boost"] = {
  FileVersion = "2",
  name = "Tutorial Mission 01 Boost",
  title = "ID:178589",
  MissionID = "7415",
  description = "ID:178546",
  cardInstances = {
    Actors = {
      ["Tutorial actor"] = {
        [1] = {
          previewMovie = "Preview vehicle",
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
          spawnSpeed = 60,
          vehicleId = 176,
          shaderParam = 6,
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
    Teams = {
      ["New Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = true,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Hud logic file"] = "Tutorial mission 01 boost HUD",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Audio logic file"] = "Boost tutorial APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "Boost tutorial",
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:178590",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Tutorial actor",
              cardType = "Actor"
            }
          },
          ["3 Text"] = "ID:178590",
          ["2 Text"] = "ID:178651"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Tutorial mission 01 boost"] = {
        [1] = {
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          }
        },
        ["name"] = "Tutorial mission 01 boost"
      }
    }
  }
}
