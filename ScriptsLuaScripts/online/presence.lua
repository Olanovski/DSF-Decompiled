module("presenceSystem", package.seeall)
local currentInstance
local function updatePresence()
  if currentInstance and currentInstance.challenge.updatePresence then
    currentInstance.challenge.updatePresence()
  end
end
function setPresenceSystemWatchedInstance(instance)
  if instance then
    if (not currentInstance or instance.challenge.name ~= currentInstance.challenge.name) and instance.challenge.updatePresence then
      addUserUpdateFunction("updatePresence", updatePresence, 2400)
    end
  else
    removeUserUpdateFunction("updatePresence")
  end
  currentInstance = instance
end
local currentPresence = {}
function setPresence(...)
  local updateRequired = #arg ~= #currentPresence
  if not updateRequired and arg[#arg] == true then
    arg[#arg] = nil
    updateRequired = true
  end
  if not updateRequired then
    for i, param in ipairs(arg) do
      updateRequired = updateRequired or param ~= currentPresence[i]
    end
  end
  if updateRequired then
    Presence.setPresence(unpack(arg))
    currentPresence = arg
  end
end
IDs = {
  ["MP tag"] = 8,
  ["MP burning rubber"] = 3,
  ["MP circuit race"] = 2,
  ["MP pure race"] = 0,
  ["MP sprint race"] = 1,
  ["MP tug of war"] = 6,
  ["MP trail blazer"] = 10,
  ["MP team circuit race"] = 5,
  ["MP takedown"] = 9,
  ["MP rush down"] = 7,
  ["MP checkpoint rush"] = 4
}
SSIDs = {
  ["MP tag"] = 0,
  ["MP pure race"] = 2,
  ["MP sprint race"] = 3,
  ["MP checkpoint rush"] = 4,
  ["MP trail blazer"] = 1,
  ["SS Clean the streets"] = 6,
  ["SS Survival"] = 7,
  ["SS Go the Distance"] = 5,
  ["SS Freedrive"] = 8
}
Task = {
  breakingGround = 0,
  causingMischief = 1,
  challengePass = 2,
  challengePerfect = 3,
  chaseCriminal = 4,
  chaseJericho = 5,
  completing = 6,
  circuitRace = 7,
  cruising = 8,
  demons = 9,
  epilogue = 10,
  escapeTheLaw = 11,
  faceoff = 12,
  fightingToSurvive = 13,
  pureRace = 14,
  racing = 15,
  rushdownATK = 16,
  rushdownDEF = 17,
  savingCity = 18,
  savingLives = 19,
  sprintRace = 20,
  tag = 21,
  tow = 22,
  trailblazer = 23,
  br = 24
}
Mode = {
  challenge = 0,
  multiplayer = 1,
  story = 2
}
Chapter = {
  chapter1 = 1,
  chapter2 = 2,
  chapter3 = 3,
  chapter4 = 4,
  chapter5 = 5,
  chapter6 = 6,
  chapter7 = 7,
  chapter8 = 8
}
Type = {
  pureRace = 0,
  rushdown = 1,
  sprint = 2,
  tag = 3,
  takedown = 4,
  tow = 5
}
Missions = {
  ["Exposition 01 Forty Adam Thirty"] = 0,
  ["Exposition pre crash chase"] = 1,
  ["Exposition pre crash chase alley"] = 2,
  ["Exposition 01 he's getting away"] = 3,
  ["Exposition 02 I wish we could help"] = 4,
  ["Exposition 03 zap at will"] = 5,
  ["Exposition 04 return to dealer"] = 6,
  ["Exposition 06 Law Breaker (cop)"] = 7,
  ["The debrief"] = 8,
  ["1 Downtown race"] = 9,
  ["Escape the law"] = 10,
  ["Learn to scream"] = 11,
  ["Breaking news"] = 12,
  ["Tanner & Jones Mission 1"] = 13,
  ["Trunked"] = 14,
  ["Easy Street"] = 15,
  ["Take down"] = 16,
  ["All clubbed out"] = 17,
  ["Streetrace takedown"] = 18,
  ["Tanner & Jones Mission 2"] = 19,
  ["Heat From Above"] = 20,
  ["Team colours 01"] = 21,
  ["In the nick of time"] = 22,
  ["Wrecked evidence"] = 23,
  ["TheSneakout"] = 24,
  ["Tanner And Jones 3"] = 25,
  ["Peroxide convoy"] = 26,
  ["Speed Race"] = 27,
  ["Felony lure"] = 28,
  ["Final destination"] = 29,
  ["Mass Chase"] = 30,
  ["Tanner & Jones Mission 4"] = 31,
  ["Collateral Damage"] = 32,
  ["Race away"] = 33,
  ["Bad medicine"] = 34,
  ["Deactivating bombs under trucks"] = 35,
  ["DriveToSurvive"] = 36,
  ["TestDrive"] = 37,
  ["Something weird"] = 38,
  ["High plains drifter"] = 39,
  ["Protect the base"] = 40,
  ["Smash tv"] = 41,
  ["Gone in 59 seconds"] = 42,
  ["Tanner and Jones 6"] = 43,
  ["Kill Tanner"] = 44,
  ["Marin County race"] = 45,
  ["Escape the law 3"] = 46,
  ["Bad medicine 2"] = 47,
  ["Breaking news 2"] = 48,
  ["Tanner and Jones 7"] = 49,
  ["Alone"] = 50,
  ["Final fight"] = 51,
  ["Avoid The Cars"] = 52,
  ["Anything you can do"] = 53,
  ["Epilogue"] = 54,
  ["Epilogue pt 2"] = 55,
  ["DowntownSprint"] = 56,
  ["ChinatownDrift"] = 57,
  ["GoldenGateCircuit"] = 58,
  ["Big break 2"] = 59,
  ["Speed"] = 60,
  ["RallyFaceOff"] = 61,
  ["Offroad"] = 62,
  ["FreewayFaceoff"] = 63,
  ["Deactivating bombs 2"] = 64,
  ["Handle challenge"] = 65,
  ["DriveToSurvive2"] = 66,
  ["Charity 2"] = 67,
  ["Survival"] = 68,
  ["Car park"] = 69,
  ["Team colours tutorial"] = 70,
  ["Smoketrail"] = 71,
  ["RelayRace"] = 72,
  ["Mass Chase 2"] = 73,
  ["Uplaych5"] = 74,
  ["Uplaych2"] = 75,
  ["Uplaych3"] = 76,
  ["Uplaych4"] = 77,
  ["Uplaych1"] = 78,
  ["Escape"] = 79,
  ["RussianHillTakedown"] = 80,
  ["TheFreewayRun"] = 81,
  ["CopOut"] = 82,
  ["MarinEscape"] = 83,
  ["LuckyEscape"] = 84,
  ["SutroDrift"] = 85,
  ["TheDriver"] = 86,
  ["HardcoreChallenge"] = 87,
  ["MarinCopRun"] = 88,
  ["DownhillDrift"] = 89,
  ["ItalianJob"] = 90,
  ["RaceActivity1"] = 91,
  ["RaceActivity2"] = 92,
  ["RaceActivity3"] = 93,
  ["OR1Activity"] = 94,
  ["OR2Activity"] = 95,
  ["OR3Activity"] = 96,
  ["TC1Activity"] = 97,
  ["TC2Activity"] = 98,
  ["TC3Activity"] = 99,
  ["TC4Activity"] = 100,
  ["TC5Activity"] = 101,
  ["RaceAwayActivity1"] = 102,
  ["RaceAwayActivity2"] = 103,
  ["RaceAwayActivity3"] = 104,
  ["RelayRaceActivity"] = 105,
  ["StreetraceTakedownActivity1"] = 106,
  ["StreetraceTakedownActivity2"] = 107,
  ["StreetraceTakedownActivity3"] = 108,
  ["StreetraceTakedownActivity4"] = 109,
  ["StreetraceTakedownActivity5"] = 110,
  ["Protect1Activity"] = 111,
  ["Protect2Activity"] = 112,
  ["Protect3Activity"] = 113,
  ["GetawayActivity1"] = 114,
  ["GetawayActivity2"] = 115,
  ["GetawayActivity3"] = 116,
  ["GetawayActivity4"] = 117,
  ["ChaseActivity1"] = 118,
  ["ChaseActivity2"] = 119,
  ["ChaseActivity3"] = 120,
  ["ChaseActivity4"] = 121,
  ["Checkpoint activity 1"] = 122,
  ["Checkpoint activity 2"] = 123,
  ["Checkpoint activity 3"] = 124,
  ["Checkpoint activity 4"] = 125,
  ["Checkpoint activity 5"] = 126,
  ["Checkpoint activity 6"] = 127,
  ["Checkpoint activity 7"] = 128,
  ["Checkpoint activity 8"] = 129,
  ["Checkpoint activity 9"] = 130,
  ["Smash activity 1"] = 131,
  ["Smash activity 2"] = 132,
  ["Smash activity 3"] = 133,
  ["Smash activity 4"] = 134,
  ["HeartometerActivity1"] = 135,
  ["HeartometerActivity2"] = 136,
  ["HeartometerActivity3"] = 137,
  ["HeartometerActivity4"] = 138,
  ["TankerOnFireActivity1"] = 139,
  ["TankerOnFireActivity2"] = 140,
  ["TheGetaway"] = 141
}
