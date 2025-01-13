module("tannerNarration", package.seeall)
local showScene = function(chapter)
  if spoolsystem.IsLocationResident(dareSystem.billboardProgression.dareScenes[chapter].lookFrom) and not localPlayer.zapTransition and zapcontroller.getZapLevel() <= 1 then
    print("NOW NOW NOW")
    local blendTime = 0.01
    local lookFrom = dareSystem.billboardProgression.dareScenes[chapter].lookFrom
    local lookat = dareSystem.billboardProgression.dareScenes[chapter].lookAt
    local fov = dareSystem.billboardProgression.dareScenes[chapter].fov
    local billboardDiscovery = {
      {
        {
          action = "blend",
          blendFunction = "slerp",
          lookAt = lookat,
          lookFrom = lookFrom,
          fov = fov,
          duration = blendTime
        },
        {
          action = "callback",
          callback = function()
            Mood.addMoodCutscene(moodSystem.chapterMoods["Chapter" .. tostring(chapter - 5)].main, "ShiftRemove", 100)
            zapcontroller.FPPShowZapFlare(false)
            zapcontroller.setRenderTarget(false, localPlayer.localID)
            localPlayer:enterCutsceneMode()
          end
        }
      },
      {
        {
          action = "callback",
          callback = function()
            BillboardManager.BlendBillBoardOut(chapter, 0.3, 0.75)
          end,
          afterDuration = 0.2
        },
        {
          action = "callback",
          callback = function()
            Commentary.TriggerEvent("billboard", nil, nil, 0, false)
          end,
          afterDuration = 0.6
        },
        {
          action = "callback",
          callback = function()
            BillboardManager.BlendBillBoardIn(chapter, 1, 0.75)
          end,
          afterDuration = 1.2
        },
        {
          action = "callback",
          callback = function()
          end,
          afterDuration = 1.6
        }
      },
      {
        action = "callback",
        callback = function()
          controlHandler:registerState(localPlayer.localID, "missionComplete", {
            MissionComplete_Continue = {
              JustPressed = {
                [1] = function()
                  input = "continue"
                  CameraSystem.ContinueScene()
                  feedbackSystem.menusMaster.masterSetVariable("iMission_Preview_Buttons", 0)
                  controlHandler:resetState("missionComplete")
                  controlHandler:removeState("missionComplete", localPlayer.localID)
                  localPlayer:exitCutsceneMode()
                  Mood.removeMood("ShiftRemove")
                  zapcontroller.setRenderTarget(true, localPlayer.localID)
                  zapcontroller.FPPShowZapFlare(true)
                end
              }
            }
          })
          controlHandler:setState("missionComplete")
          feedbackSystem.menusMaster.masterSetTextVariable("accept_button", localPlayer.buttonLayout.accept)
          feedbackSystem.menusMaster.masterSetTextVariable("preview_accept_description", "ID:235459")
          feedbackSystem.menusMaster.masterSetVariable("iMission_Preview_Buttons", 1)
        end
      },
      {infiniteLength = true},
      {duration = 0.01}
    }
    BillboardManager.Enable()
    localPlayer:enterCutsceneMode()
    CameraSystem.AddScene(billboardDiscovery)
    removeUserUpdateFunction("showScene")
  end
end
function triggerNarrativeBillboard(chapter)
  local chapterUID = chapter + 5
  local targetPoint = vec.vector(-434.0799, 23.48051, 746.7109, 1)
  local heading = 2.32835
  if zapcontroller.getZapLevel() ~= 1 then
    localPlayer:SetZapLevel(1)
  end
  if chapter then
    if chapter == 0 then
      targetPoint = vec.vector(-434.0799, 23.48051, 746.7109, 1)
    else
      targetPoint = dareSystem.billboardProgression.dareScenes[chapterUID].lookFrom
    end
  end
  localPlayer.ZapTransitionToPoint(localPlayer, targetPoint, heading)
  addUserUpdateFunction("showScene", function()
    showScene(chapterUID)
  end, 10)
end
local lastMissionStartTime = 0
local missionReminderTimeout = 420
local chapter1NarrationManagerActive = false
local previousSamplePlayed = "ZapIdle"
local reminderManagerActive = false
local billboardsViewed = {}
function playTannerNarration(narrationID, billboardID, callback)
  callStack()
  if narrationID == "DareFound" then
    if chapter1NarrationManagerActive and #billboardsViewed < 3 then
      local alreadyViewed = false
      for key, value in next, billboardsViewed, nil do
        if value == billboardID then
          alreadyViewed = true
        end
      end
      if alreadyViewed == false then
        table.insert(billboardsViewed, billboardID)
        return eventFeedback(nil, narrationID)
      end
    end
    tannerNarration.disableNarrationManager()
  elseif narrationID == "CityLimit" then
    if (challengeProgressionTable[progressionSystem.currentProgression].settings.chapter == 0 or chapter1NarrationManagerActive) and (not localPlayer.inZap or not (zapcontroller.getZapLevel() > 2)) then
      return eventFeedback(nil, narrationID)
    end
  else
    if narrationID == "SMUnlock" and challengeProgressionTable[progressionSystem.currentProgression].settings.chapter == 0 then
      Commentary.ForceEventChange()
      narrationID = "tjab"
    end
    if narrationID == "PostCarDlr1" then
      print("playing back " .. tostring(narrationID))
      localPlayer.simulationSupport.doWait(0.25, function()
        eventFeedback(nil, narrationID)
      end)
    elseif narrationID == "PostCarDlr3" then
      print("playing back " .. tostring(narrationID))
      eventFeedback(nil, narrationID)
    elseif not localPlayer.inZap or not (zapcontroller.getZapLevel() > 2) then
      print("playing back " .. tostring(narrationID))
      eventFeedback(nil, narrationID)
    end
  end
end
function resetReminderManager()
  lastMissionStartTime = g_NetworkTime
end
function reminderManager()
  if not progressionSystem.applyingChapterSettings and reminderManagerActive and g_NetworkTime >= lastMissionStartTime + missionReminderTimeout then
    if previousSamplePlayed == "ZapIdle" then
      playTannerNarration("MisRemind")
      previousSamplePlayed = "MisRemind"
    else
      playTannerNarration("ZapIdle")
      previousSamplePlayed = "ZapIdle"
    end
    resetReminderManager()
  end
end
function startNarrationManager()
  if challengeProgressionTable[progressionSystem.currentProgression].settings.chapter == 1 then
    chapter1NarrationManagerActive = true
  end
  if challengeProgressionTable[progressionSystem.currentProgression].settings.chapter >= 1 then
    resetReminderManager()
    reminderManagerActive = true
  end
end
function disableNarrationManager()
  if chapter1NarrationManagerActive then
    chapter1NarrationManagerActive = false
  end
  if reminderManagerActive then
    reminderManagerActive = false
  end
end
