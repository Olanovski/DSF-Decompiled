module("scoreSystem")
local willpowerPromptState = false
local willpowerPromptBlocked = false
function getWillpowerPromptState()
  return willpowerPromptState
end
function blockWillpowerPrompt(state)
  if state then
    willpowerPromptBlocked = state
    setWillpowerPromptState(false)
  else
    willpowerPromptBlocked = state
    setWillpowerPromptState(true)
  end
end
function setWillpowerPromptState(state)
  if state and not willpowerPromptBlocked and isWillpowerEnabled() and (localPlayer.isHUDActive() or localPlayer.challenge.showingEndScreen or dareSystem.dareCompleteScreenActive) then
    willpowerPromptState = state
    Menu.ClearCreditsList()
    Menu.CreditsListEnabled = willpowerPromptState
  elseif willpowerPromptState and not state then
    willpowerPromptState = state
    Menu.CreditsListEnabled = willpowerPromptState
  end
end
local willpowerRewardTypes = {
  Default = {type = "Default", name = "Default"},
  Achievement = {
    type = "Achievement",
    name = "ACHIEVEMENT"
  },
  Token = {type = "Story", name = "ID:245880"},
  Story = {type = "Story", name = "ID:245872"},
  Felony = {type = "Story", name = "ID:245878"},
  SpeedTimeMission = {type = "SpeedTime", name = "ID:245873"},
  ActionMission = {type = "Action", name = "ID:245873"},
  StuntMission = {type = "Stunt", name = "ID:245873"},
  SpeedTimeActivity = {type = "SpeedTime", name = "ID:245874"},
  ActionActivity = {type = "Action", name = "ID:245874"},
  StuntActivity = {type = "Stunt", name = "ID:245874"},
  SpeedTimeChallenge = {type = "SpeedTime", name = "ID:245875"},
  ActionChallenge = {type = "Action", name = "ID:245875"},
  Garage = {
    type = "Achievement",
    name = "ID:245879"
  },
  StuntChallenge = {type = "Stunt", name = "ID:245875"},
  SpeedTimeChallengeBonus = {type = "SpeedTime", name = "ID:245876"},
  ActionChallengeBonus = {type = "Action", name = "ID:245876"},
  StuntChallengeBonus = {type = "Stunt", name = "ID:245876"},
  SpeedTimeDare = {type = "SpeedTime", name = "ID:245877"},
  ActionDare = {type = "Action", name = "ID:245877"},
  StuntDare = {type = "Stunt", name = "ID:245877"}
}
willpowerRewardTypes.token = willpowerRewardTypes.Story
willpowerRewardTypes.story = willpowerRewardTypes.Story
willpowerRewardTypes.premiumRace = willpowerRewardTypes.SpeedTimeMission
willpowerRewardTypes.premiumAction = willpowerRewardTypes.ActionMission
willpowerRewardTypes.premiumStunt = willpowerRewardTypes.StuntMission
willpowerRewardTypes.dareSpeed = willpowerRewardTypes.SpeedTimeDare
willpowerRewardTypes.dareAction = willpowerRewardTypes.ActionDare
willpowerRewardTypes.dareStunt = willpowerRewardTypes.StuntDare
willpowerRewardTypes.challengeRace = willpowerRewardTypes.SpeedTimeChallenge
willpowerRewardTypes.challengeTimeTrial = willpowerRewardTypes.SpeedTimeChallenge
willpowerRewardTypes.challengeEscape = willpowerRewardTypes.ActionChallenge
willpowerRewardTypes.challengeTakedown = willpowerRewardTypes.ActionChallenge
willpowerRewardTypes.challengeDrift = willpowerRewardTypes.StuntChallenge
willpowerRewardTypes.challengeStunt = willpowerRewardTypes.StuntChallenge
willpowerRewardTypes.challengeRaceBonus = willpowerRewardTypes.SpeedTimeChallengeBonus
willpowerRewardTypes.challengeTimeTrialBonus = willpowerRewardTypes.SpeedTimeChallengeBonus
willpowerRewardTypes.challengeEscapeBonus = willpowerRewardTypes.ActionChallengeBonus
willpowerRewardTypes.challengeTakedownBonus = willpowerRewardTypes.ActionChallengeBonus
willpowerRewardTypes.challengeDriftBonus = willpowerRewardTypes.StuntChallengeBonus
willpowerRewardTypes.challengeStuntBonus = willpowerRewardTypes.StuntChallengeBonus
willpowerRewardTypes.movieRace = willpowerRewardTypes.SpeedTimeChallenge
willpowerRewardTypes.movieAction = willpowerRewardTypes.ActionChallenge
willpowerRewardTypes.movieStunt = willpowerRewardTypes.StuntChallenge
willpowerRewardTypes.standardRace = willpowerRewardTypes.SpeedTimeActivity
willpowerRewardTypes.standardTeamRace = willpowerRewardTypes.SpeedTimeActivity
willpowerRewardTypes.standardEscape = willpowerRewardTypes.ActionActivity
willpowerRewardTypes.standardTakedown = willpowerRewardTypes.ActionActivity
willpowerRewardTypes.standardStunt = willpowerRewardTypes.StuntActivity
willpowerRewardTypes.standardCheckpointTrial = willpowerRewardTypes.StuntActivity
willpowerRewardTypes.copChase = willpowerRewardTypes.Felony
Menu.CreditCompleteWaitTime = 1
Menu.CreditCompleteAnimationTime = 1
local rewardID = 0
local rewards = {}
local function showReward(score, rewardType, setStartAmount, bonusReward)
  if willpowerRewardTypes[rewardType] then
    if not willpowerPromptState then
      setWillpowerPromptState(true)
    end
    if setStartAmount then
      local startAmount = 0
      if bonusReward then
        startAmount = ProfileSettings.GetWillpower() - score * 2
      else
        startAmount = ProfileSettings.GetWillpower() - score
      end
      rewardID = Menu.AddCreditsLine(willpowerRewardTypes[rewardType].name, score, willpowerRewardTypes[rewardType].type, startAmount)
    else
      rewardID = Menu.AddCreditsLine(willpowerRewardTypes[rewardType].name, score, willpowerRewardTypes[rewardType].type)
    end
    Menu.RemoveCreditsLine(rewardID, true)
  end
end
function showStoredWillpowerReward()
  if rewards then
    for k, v in next, rewards, nil do
      if k == #rewards and k > 1 then
        showReward(v.score, v.rewardType, true, true)
      else
        showReward(v.score, v.rewardType, true)
      end
    end
    rewards = nil
  end
end
function willpowerReward(score, rewardType, storeReward)
  if score and willpowerRewardTypes[rewardType] then
    if storeReward then
      rewards = rewards or {}
      local params = {score = score, rewardType = rewardType}
      local uid = 1
      if rewards and rewards[uid] then
        uid = #rewards + 1
      end
      table.insert(rewards, uid, params)
      ProfileSettings.SetWillpower(ProfileSettings.GetWillpower() + score)
    else
      showReward(score, rewardType)
      ProfileSettings.SetWillpower(ProfileSettings.GetWillpower() + score)
    end
  else
    print("Unkown willpower reward type: " .. tostring(rewardType))
  end
end
