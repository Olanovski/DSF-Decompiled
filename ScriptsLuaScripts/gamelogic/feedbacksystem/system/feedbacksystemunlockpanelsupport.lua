module("feedbackSystem.unlockPanelSupport", package.seeall)
local title, blurb
local screenOptionsActive = false
local willpowerRelated = false
local driveOn = true
local lookupTable = {}
rewardPanelActive = false
local unlockMessages = {
  aerialZap = {
    [0] = {title = "ID:183944", description = "ID:241246"},
    [1] = {title = "ID:245134", description = "ID:241246"},
    [2] = {title = "ID:245135", description = "ID:241247"}
  },
  zapReturn = {
    [0] = {title = "ID:245210", description = "ID:241249"}
  },
  ram = {
    [0] = {title = "ID:183884", description = "ID:241250"}
  },
  nitro = {
    [0] = {title = "ID:178505", description = "ID:241248"}
  }
}
local function buttonPress(name, type, level, callback)
  return function()
    local function menuSelectionUp()
      if driveOn and screenOptionsActive then
        feedbackSystem.menusMaster.masterSetVariable("iChallenge_Select_Toggle", 2)
        driveOn = false
      end
    end
    local function menuSelectionDown()
      if not driveOn and screenOptionsActive then
        feedbackSystem.menusMaster.masterSetVariable("iChallenge_Select_Toggle", 3)
        driveOn = true
      end
    end
    if lookupTable[type][4] then
      controlHandler:registerState(localPlayer.localID, "unlockScreen", {
        MissionComplete_Analog_Up = {
          JustPressed = {
            [1] = menuSelectionDown
          }
        },
        MissionComplete_Analog_Down = {
          JustPressed = {
            [1] = menuSelectionUp
          }
        },
        MissionComplete_DPad_Up = {
          JustPressed = {
            [1] = menuSelectionDown
          }
        },
        MissionComplete_DPad_Down = {
          JustPressed = {
            [1] = menuSelectionUp
          }
        },
        Menu_Select = {
          JustPressed = {
            [1] = function()
              if driveOn then
                lookupTable[type][4](name, callback)
              else
                lookupTable[type][3](name, level, callback)
              end
            end
          }
        }
      })
    else
      controlHandler:registerState(localPlayer.localID, "unlockScreen", {
        Menu_Select = {
          JustPressed = {
            [1] = lookupTable[type][3](name, level, callback)
          }
        }
      })
    end
    local panelType = lookupTable[type][2]
    if panelType == 3 then
      feedbackSystem.menusMaster.masterSetTextVariable("mission_complete_continue", "ID:234206")
      feedbackSystem.menusMaster.masterSetTextVariable("mission_complete_continue_button", localPlayer.buttonLayout.accept)
    elseif panelType == 5 then
      feedbackSystem.menusMaster.masterSetTextVariable("challenge_play_now", "ID:234432")
      feedbackSystem.menusMaster.masterSetTextVariable("new_movie_challenge_continue_button", localPlayer.buttonLayout.accept)
      feedbackSystem.menusMaster.masterSetTextVariable("challenge_drive_on", "ID:234433")
      feedbackSystem.menusMaster.masterSetVariable("iChallenge_Select_Toggle", 1)
    end
    driveOn = true
    screenOptionsActive = true
    controlHandler:setState("unlockScreen")
    removeUserUpdateFunction("buttonPressWait")
  end
end
local function showPanel(name, type, level, callback)
  Sound.DoTutorialPrompt(true)
  if willpowerRelated then
    feedbackSystem.menusMaster.masterSetVariable("iWillPower_Flash", 1)
  end
  local panelType = lookupTable[type][2]
  if panelType == 3 then
    feedbackSystem.menusMaster.masterSetTextVariable("mission_complete_continue", "")
    feedbackSystem.menusMaster.masterSetTextVariable("mission_complete_continue_button", "")
  elseif panelType == 5 then
    feedbackSystem.menusMaster.masterSetTextVariable("challenge_play_now", "")
    feedbackSystem.menusMaster.masterSetTextVariable("challenge_drive_on", "")
    feedbackSystem.menusMaster.masterSetTextVariable("new_movie_challenge_continue_button", "")
  end
  feedbackSystem.menusMaster.currentHUDSetVariable("iRewards_Popup", lookupTable[type][2])
  feedbackSystem.menusMaster.masterSetTextVariable("mission_complete_rewards_title", title)
  feedbackSystem.menusMaster.masterSetTextVariable("mission_rewards_generic_blurb", blurb)
  addUserUpdateFunction("buttonPressWait", buttonPress(name, type, level, callback), 4 * updates.stepRate, true)
end
local function cleanup()
  local function callback()
    PauseMenu.allow(true)
    rewardPanelActive = false
    localPlayer:exitCutsceneMode()
    feedbackSystem.menusMaster.allowUnlockPanel(true)
    Sound.DoTutorialPrompt(false)
    controlHandler:resetState("unlockScreen")
    controlHandler:removeState("unlockScreen", localPlayer.localID)
    willpowerRelated = false
  end
  if localPlayer.inZap then
    simulation.setSpeed(zap.singlePlayerZapSlowDownMultiplier)
    callback()
  else
    localPlayer.simulationSupport.doSpeedUp(callback, 1, 1)
  end
  feedbackSystem.menusMaster.currentHUDSetVariable("iRewards_Popup", 0)
  feedbackSystem.menusMaster.masterSetVariable("iChallenge_Movie_Icon", 0)
end
local function startAction(name, type, level, callback)
  PauseMenu.allow(false)
  localPlayer.simulationSupport.doSlowDown(showPanel(name, type, level, callback), 1, 0)
end
lookupTable["Story mission"] = {
  [1] = function(name, level, type)
    local networkID = cards.ReverseMissionNetworkLookup[name]
    if networkID then
      title = "ID:236110"
      blurb = missionInfo[cards.ReverseMissionNetworkLookup[name]].challengeTitle
      willpowerRelated = true
      startAction(name, type)
      Menu.LoadMissionRewardImage(networkID)
    end
  end,
  [2] = 3,
  [3] = function(name)
    return function()
      screenOptionsActive = false
      OneShotSound.Play("Menu_Select")
      cleanup()
    end
  end
}
lookupTable.Challenge = {
  [1] = function(name, level, type, callback)
    local movieIcon = function()
      feedbackSystem.menusMaster.masterSetVariable("iChallenge_Movie_Icon", 1)
      removeUserUpdateFunction("movieIconWait")
    end
    local networkID = cards.ReverseMissionNetworkLookup[name]
    if networkID then
      title = missionInfo[networkID].challengeTitle
      local challenge, __, challengeType = progressionSystem.findChallengeInProgression(name)
      if challengeType == "movie" then
        addUserUpdateFunction("movieIconWait", movieIcon, 1 * updates.stepRate, true)
        blurb = "ID:243484"
      else
        feedbackSystem.menusMaster.masterSetVariable("iChallenge_Movie_Icon", 0)
        blurb = "ID:243485"
      end
      Menu.LoadChallengeRewardImage(networkID)
      willpowerRelated = false
      startAction(name, type, nil, callback)
      local mission, potID, subType, type = progressionSystem.findMissionInProgression(name)
      local networkID = cards.ReverseMissionNetworkLookup[name]
      if not ProfileSettings.GetChallengeUnlocked(networkID) then
        ProfileSettings.SetChallengeUnlocked(networkID, type == "activity")
        progressionSystem.saveGame("When you unlock a challenge (" .. name .. "), not from a mission or dare")
      end
    end
  end,
  [2] = 5,
  [3] = function(name, level, callback)
    screenOptionsActive = false
    local mission, potID, subType, type = progressionSystem.findMissionInProgression(name)
    progressionSystem.applyChallengeSettings(mission)
    feedbackSystem.menusMaster.masterSetVariable("iChallenge_Select_Toggle", 5)
    OneShotSound.Play("Menu_Select")
    cleanup()
    if callback then
      callback(true)
    end
  end,
  [4] = function(name, callback)
    screenOptionsActive = false
    activeChallenges.enableActivities()
    activeChallenges.enableCollectables()
    feedbackSystem.menusMaster.masterSetVariable("iChallenge_Select_Toggle", 4)
    OneShotSound.Play("Menu_Back")
    cleanup()
    if callback then
      callback(false)
    end
  end
}
lookupTable["Ability unlock"] = {
  [1] = function(name, level, type)
    if unlockMessages[name] and unlockMessages[name][level] then
      local messages = unlockMessages[name][level]
      title = messages.title
      blurb = messages.description
      Menu.LoadAbilityRewardImage("default_ability")
      willpowerRelated = true
      startAction(name, type, level)
      if not progressionSystem.abilityHasTutorial(name, level) then
        progressionSystem.saveGame("When you unlock an ability (" .. name .. ") which doesn't have a tutorial")
      end
    end
  end,
  [2] = 3,
  [3] = function(name, level)
    return function()
      screenOptionsActive = false
      progressionSystem.startTutorial(name, level)
      OneShotSound.Play("Menu_Select")
      cleanup()
    end
  end
}
function displayUnlockScreen(name, level, type, callback)
  rewardPanelActive = true
  localPlayer:enterCutsceneMode()
  feedbackSystem.menusMaster.allowUnlockPanel(false)
  lookupTable[type][1](name, level, type, callback)
end
