module("feedbackSystem", package.seeall)
musicPlaying = false
musicPlayID = 0
function stopMusic(stopString)
  if musicPlaying then
    Music.StopChallengeMusic(stopString)
    musicPlaying = false
  end
end
function startMusic(startString)
  musicPlaying = Music.StartChallengeMusic(startString)
end
function stopFreeDriveMusic(missionID)
  if musicPlayID ~= 0 then
    Music.StopChallengeMusic()
    musicPlayID = 0
  end
  if missionID then
    if shouldStopFreeDriveMusic(missionID) then
      Music.StopFreeDriveMusic()
    end
  else
    Music.StopFreeDriveMusic()
  end
end
function startFreeDriveMusic(missionID, isChallenge)
  if isChallenge == true then
    musicPlayID = Music.StartChallengeMusic(string.format("Mus_Challenge_Uid%05d_Play", missionID))
    if musicPlayID == 0 then
      Music.StartFreeDriveMusic()
    end
  else
    Music.StartFreeDriveMusic(missionID)
  end
end
function taskSuccessAudio()
  OneShotSound.Play("HUD_Gen_Tutorial_ObjectiveComplete_OneShot", false)
end
function shouldStopFreeDriveMusic(missionID)
  if missionID ~= "3319" then
    return true
  else
    return false
  end
end
ravensSound = 0
function playRavensSound(ravenEvent, position)
  local ravenVel = vec.vector(0, 0, 0, 0)
  local ravenDir = vec.vector(1, 0, 0, 0)
  if ravensSound ~= 0 then
    stopRavensSound()
  end
  ravensSound = OneShotSound.PlayAtPosition(ravenEvent, position, ravenVel, ravenDir)
end
function stopRavensSound()
  OneShotSound.Stop(ravensSound)
  ravensSound = 0
end
