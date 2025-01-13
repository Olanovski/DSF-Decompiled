gameStatus.registerEvent("preLaunch", "Default", function()
  local initialSpoolOK
  local vehicleRequested = false
  bonusChallengeActive = false
  local function spoolCheck()
    if initialSpoolOK() and (not vehicleRequested or VehicleLodSpooler.IsInteriorLoaded(configSelector.launchConfig.StartVehicle)) then
      performance.SetEnableCharacters(configSelector.launchConfig.enablePeds)
      scoreSystem.emptyAbility()
      sky.scale = 85
      toggleFPSCounter()
      simulation.EnableMemoryDisplay(true)
      Menu.ShowHUD = 0
      gameStatus.preLaunchComplete()
      removeUserUpdateFunction("Spool checker")
    end
  end
  local function modeLoaded(settings)
    return function()
      VehicleLodSpooler.RequestVehicle(configSelector.launchConfig.StartVehicle)
      vehicleRequested = true
      if configSelector.launchConfig.enableTraffic then
        initialSpoolOK = spooling.isChapterTrafficSpooled(settings.trafficSettings or "Exposition", settings.missionVehiclePot)
      else
        initialSpoolOK = spooling.isMissionVehicleSpooled(configSelector.launchConfig.StartVehicle)
      end
      addUserUpdateFunction("Spool checker", spoolCheck, 1)
    end
  end
  if Network.isOnlineGame() or Network.isSplitScreenMode() then
    if Network.isSplitScreenMode() then
      onlineMissionSync.setCurrentMissionData()
      function initialSpoolOK()
        return onlineMissionSync.isMissionSynched()
      end
      print("Enabling split screen")
      enableSplitScreen()
      loadMode("SplitScreen", function()
        addUserUpdateFunction("Spool checker", spoolCheck, 1)
      end)
      print("----------------------------------------------------------------------------- ONLINE")
      zapcontroller.setSpoolerAttached(true)
    else
      function initialSpoolOK()
        return true
      end
      loadMode("Competitive", function()
        addUserUpdateFunction("Spool checker", spoolCheck, 1)
      end)
      print("----------------------------------------------------------------------------- ONLINE")
      zapcontroller.setSpoolerAttached(false)
    end
  else
    print("----------------------------------------------------------------------------- OFFLINE")
    zapcontroller.setSpoolerAttached(true)
    if configSelector.launchConfig.Name ~= "Single Player" and configSelector.launchConfig.Name ~= "Replay" then
      local configSettings = {
        ["Exposition"] = 0,
        ["Post Debrief"] = 0.5,
        ["Chapter 1"] = 1,
        ["Chapter 2"] = 2,
        ["Chapter 3"] = 3,
        ["Chapter 4"] = 4,
        ["Chapter 5"] = 5,
        ["Chapter 6"] = 6,
        ["Chapter 7"] = 7,
        ["Chapter 8"] = 8,
        ["Epilogue"] = 9,
        ["No Progression"] = 10
      }
      local configSetting = configSettings[configSelector.launchConfig.Name]
      configSetting = configSetting or configSelector.launchConfig.enableProgression and configSettings.Exposition or configSettings["No Progression"]
      if configSetting > 0 then
        local firstMission = challengeProgressionTable[1].storyMission[1].ID
        ProfileSettings.SetMissionAttempted(cards.ReverseMissionNetworkLookup[firstMission])
        ProfileSettings.SetAbilityUnlocked(abilities.abilitySlots.zap, 0)
        ProfileSettings.SetAbilityOwned(abilities.abilitySlots.zap, 0)
        if configSetting > 1 then
          ProfileSettings.SetAbilityUnlocked(abilities.abilitySlots.nitro, 0)
          ProfileSettings.SetAbilityOwned(abilities.abilitySlots.nitro, 0)
          ProfileSettings.SetAbilityUnlocked(abilities.abilitySlots.ram, 0)
          ProfileSettings.SetAbilityOwned(abilities.abilitySlots.ram, 0)
          for i = 1, #challengeProgressionTable do
            local pot = challengeProgressionTable[i]
            if configSetting <= pot.settings.chapter then
              break
            elseif pot.tutorials then
              for __, unlock in ipairs(pot.tutorials) do
                if unlock.ability and abilities[unlock.ability] and unlock.level then
                  ProfileSettings.SetAbilityUnlocked(abilities.abilitySlots[unlock.ability], unlock.level)
                  ProfileSettings.SetAbilityOwned(abilities.abilitySlots[unlock.ability], unlock.level)
                end
              end
            end
          end
        end
        for i = 0, math.min(configSetting - 1, #daresByChapter) do
          for uid, dare in next, daresByChapter[i], nil do
            ProfileSettings.SetDareUnlocked(uid)
          end
        end
        for i = 1, configSetting - 1 do
          garage.updateGarageUnlocks(i)
          vehicleManager.updateVehicleUnlocks(i)
          collectables.updateCollectableUnlocks(i)
          abilityUnlockCheck(i, false)
        end
        local willpowerReward = 0
        for i = 1, #challengeProgressionTable do
          local progressionPot = challengeProgressionTable[i]
          for challengeType, challenges in next, progressionPot, nil do
            if challengeType ~= "settings" and configSetting ~= 0.5 and configSetting > progressionPot.settings.chapter then
              for index, challenge in next, challenges, nil do
                ProfileSettings.SetMissionAttempted(cards.ReverseMissionNetworkLookup[challenge.ID])
                ProfileSettings.SetMissionCompleted(cards.ReverseMissionNetworkLookup[challenge.ID], challenge.statsMission)
                if 0 < progressionPot.settings.chapter or challengeType ~= "storyMission" then
                  willpowerReward = willpowerReward + (progressionSystem.getChallengeWillpowerReward(challenge.ID) or 0)
                end
                challenge.complete = true
                if challenge.unlocks then
                  for __, activityUnlock in next, challenge.unlocks, nil do
                    if activitiesLookupTable[activityUnlock.type] and activitiesLookupTable[activityUnlock.type][activityUnlock.subType] and activitiesLookupTable[activityUnlock.type][activityUnlock.subType][activityUnlock.ID] then
                      local activity = activitiesLookupTable[activityUnlock.type][activityUnlock.subType][activityUnlock.ID]
                      ProfileSettings.SetChallengeUnlocked(cards.ReverseMissionNetworkLookup[activity.ID], true)
                      ProfileSettings.SetChallengeOwned(cards.ReverseMissionNetworkLookup[activity.ID])
                    end
                  end
                end
              end
            end
          end
        end
        ProfileSettings.SetWillpower(willpowerReward)
      end
      if configSetting == 10 then
        unlockAllAbilities()
        ProfileSettings.SetWillpower(1000000)
        for challengeType, challengeList in next, challengeLookupTable, nil do
          if challengeType ~= "movie" then
            for __, challenges in next, challengeList, nil do
              for __, challenge in next, challenges, nil do
                ProfileSettings.SetChallengeUnlocked(cards.ReverseMissionNetworkLookup[challenge.ID])
                ProfileSettings.SetChallengeOwned(cards.ReverseMissionNetworkLookup[challenge.ID])
              end
            end
          end
        end
        for ID, garageDetail in next, garage.locations, nil do
          shop.purchaseGarage(ID)
        end
      end
      if configSetting == 0.5 then
        ProfileSettings.SetProgression(9)
      else
        for i, potTable in ipairs(challengeProgressionTable) do
          if potTable.settings.chapter == configSetting then
            ProfileSettings.SetProgression(i)
            break
          end
        end
      end
    end
    local settings
    if configSelector.launchConfig.forceMission then
      local mission, potID, subType, type = progressionSystem.findMissionInProgression(cards.MissionNetworkLookup[configSelector.launchConfig.forceMission])
      assert(mission, "Error - trying to load invalid mission from front end")
      if type == "challenge" then
        bonusChallengeActive = true
        settings = mission.settings
      else
        local potToLoad = potID
        settings = challengeProgressionTable[potToLoad].settings
      end
    else
      local potToLoad = ProfileSettings.GetProgression()
      settings = challengeProgressionTable[potToLoad].settings
    end
    performance.SetEnableCharacters(configSelector.launchConfig.enablePeds)
    scoreSystem.emptyAbility()
    sky.scale = 85
    toggleFPSCounter()
    simulation.EnableMemoryDisplay(true)
    Menu.ShowHUD = 0
    loadAbilitiesFromProfile()
    gameStatus.preLaunchComplete()
  end
end)
gameStatus.registerEvent("preLaunch", "OldDefault", function()
  local initialSpoolOK
  local vehicleRequested = false
  bonusChallengeActive = false
  local function spoolCheck()
    if initialSpoolOK() and (not vehicleRequested or VehicleLodSpooler.IsInteriorLoaded(configSelector.launchConfig.StartVehicle)) then
      performance.SetEnableCharacters(configSelector.launchConfig.enablePeds)
      scoreSystem.emptyAbility()
      sky.scale = 85
      toggleFPSCounter()
      simulation.EnableMemoryDisplay(true)
      Menu.ShowHUD = 0
      gameStatus.preLaunchComplete()
      removeUserUpdateFunction("Spool checker")
      initialise.allLoadingComplete()
    end
  end
  local function modeLoaded(settings)
    return function()
      VehicleLodSpooler.RequestVehicle(configSelector.launchConfig.StartVehicle)
      vehicleRequested = true
      if configSelector.launchConfig.enableTraffic then
        initialSpoolOK = spooling.isChapterTrafficSpooled(settings.trafficSettings or "Exposition", settings.missionVehiclePot)
      else
        initialSpoolOK = spooling.isMissionVehicleSpooled(configSelector.launchConfig.StartVehicle)
      end
      addUserUpdateFunction("Spool checker", spoolCheck, 1)
    end
  end
  if Network.isOnlineGame() or Network.isSplitScreenMode() then
    if Network.isSplitScreenMode() then
      onlineMissionSync.setCurrentMissionData()
      function initialSpoolOK()
        return onlineMissionSync.isMissionSynched()
      end
      print("Enabling split screen")
      enableSplitScreen()
      loadMode("SplitScreen", function()
        addUserUpdateFunction("Spool checker", spoolCheck, 1)
      end)
      print("----------------------------------------------------------------------------- ONLINE")
      zapcontroller.setSpoolerAttached(true)
    else
      function initialSpoolOK()
        return true
      end
      loadMode("Competitive", function()
        addUserUpdateFunction("Spool checker", spoolCheck, 1)
      end)
      print("----------------------------------------------------------------------------- ONLINE")
      zapcontroller.setSpoolerAttached(false)
    end
  else
    print("----------------------------------------------------------------------------- OFFLINE")
    zapcontroller.setSpoolerAttached(true)
    if configSelector.launchConfig.Name ~= "Single Player" and configSelector.launchConfig.Name ~= "Replay" then
      local configSettings = {
        ["Exposition"] = 0,
        ["Chapter 1"] = 1,
        ["Chapter 2"] = 2,
        ["Chapter 3"] = 3,
        ["Chapter 4"] = 4,
        ["Chapter 5"] = 5,
        ["Chapter 6"] = 6,
        ["Chapter 7"] = 7,
        ["Chapter 8"] = 8,
        ["Epilogue"] = 9,
        ["No Progression"] = 10
      }
      local configSetting = configSettings[configSelector.launchConfig.Name]
      configSetting = configSetting or configSelector.launchConfig.enableProgression and configSettings.Exposition or configSettings["No Progression"]
      if configSetting > 0 then
        local firstMission = challengeProgressionTable[1].storyMission[1].ID
        ProfileSettings.SetMissionAttempted(cards.ReverseMissionNetworkLookup[firstMission])
        for i = 1, #challengeProgressionTable do
          local progressionPot = challengeProgressionTable[i]
          for challengeType, challenges in next, progressionPot, nil do
            if challengeType ~= "settings" and configSetting > progressionPot.settings.chapter then
              for index, challenge in next, challenges, nil do
                ProfileSettings.SetMissionAttempted(cards.ReverseMissionNetworkLookup[challenge.ID])
                ProfileSettings.SetMissionCompleted(cards.ReverseMissionNetworkLookup[challenge.ID], challenge.statsMission)
                challenge.complete = true
              end
            end
          end
        end
      end
      if configSetting == 10 then
        for __, challenges in next, challengeLookupTable.shop, nil do
          for __, challenge in next, challenges, nil do
            ProfileSettings.SetWillpower(1000000)
            ProfileSettings.SetChallengeOwned(cards.ReverseMissionNetworkLookup[challenge.ID])
          end
        end
      end
      for i, potTable in ipairs(challengeProgressionTable) do
        if potTable.settings.chapter == configSetting then
          ProfileSettings.SetProgression(i)
          break
        end
      end
    end
    if configSelector.launchConfig.Name == "Marketing" then
      challengeProgressionTable = {
        [1] = {
          settings = {
            chapter = 0,
            initialCutscene = "ch0_introduction_01",
            trafficSettings = "Exposition Drive",
            missionVehiclePot = "Exposition",
            chunkFile = "Exposition",
            cityLocking = "CityLockingLevel3",
            blockAbilityBar = true,
            blockActiveChallenges = true,
            blockWillpower = true,
            blockDarePanel = true
          },
          storyMission = {
            {
              ID = "Exposition 01 Forty Adam Thirty",
              forceStart = true
            }
          }
        },
        [2] = {
          settings = {
            chapter = 0,
            initialCutscene = "ch0_introduction_02",
            trafficSettings = "Exposition Chase",
            missionVehiclePot = "Exposition",
            chunkFile = "Exposition",
            cityLocking = "CityLockingLevel12_Exposition_Part2",
            blockAbilityBar = true,
            blockActiveChallenges = true,
            blockWillpower = true,
            blockDarePanel = true
          },
          storyMission = {
            {
              ID = "Exposition pre crash chase",
              forceStart = true
            }
          }
        },
        [3] = {
          settings = {
            chapter = 0,
            initialCutscene = "ch0_crash1_01",
            trafficSettings = "Exposition Bullrun",
            missionVehiclePot = "Exposition",
            chunkFile = "Exposition",
            cityLocking = "CityLockingLevel1",
            blockAbilityBar = true,
            blockActiveChallenges = true,
            blockWillpower = true,
            blockDarePanel = true
          },
          storyMission = {
            {
              ID = "Exposition pre crash chase alley",
              forceStart = true
            }
          }
        },
        [4] = {
          settings = {
            chapter = 6,
            missionReward = 30,
            trafficSettings = "Chapter 6",
            missionVehiclePot = "Chapter 6",
            chunkFile = "Chapter6",
            cityLocking = "CityLockingLevel4",
            blockActiveChallenges = true
          },
          tannerMission = {
            {
              ID = "Tanner and Jones 6",
              willpowerToUnlock = 0
            }
          }
        },
        [5] = {
          settings = {
            chapter = 10,
            missionReward = 30,
            trafficSettings = "Chapter 6",
            missionVehiclePot = "Chapter 6",
            chunkFile = "Chapter6",
            cityLocking = "CityLockingLevel4",
            blockActiveChallenges = true
          },
          challenges = {}
        }
      }
    end
    local settings
    if configSelector.launchConfig.forceMission then
      local mission, potID, missionType, isChallenge = progressionSystem.findMissionInProgression(cards.MissionNetworkLookup[configSelector.launchConfig.forceMission])
      assert(mission, "Error - trying to load invalid mission from front end")
      if isChallenge then
        singlePlayerStatistics.setupMissionStatistics(cards.MissionNetworkLookup[configSelector.launchConfig.forceMission])
        bonusChallengeActive = true
        settings = mission.settings
      else
        local potToLoad = potID
        settings = challengeProgressionTable[potToLoad].settings
      end
    else
      local potToLoad = ProfileSettings.GetProgression()
      settings = challengeProgressionTable[potToLoad].settings
    end
    performance.SetEnableCharacters(configSelector.launchConfig.enablePeds)
    scoreSystem.emptyAbility()
    sky.scale = 85
    toggleFPSCounter()
    simulation.EnableMemoryDisplay(true)
    Menu.ShowHUD = 0
    modeLoaded(settings)()
  end
end)
