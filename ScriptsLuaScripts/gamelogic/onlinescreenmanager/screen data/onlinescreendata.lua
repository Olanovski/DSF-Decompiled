module("onlineScreenManager", package.seeall)
onlineScreenData = {
  ["Air"] = {
    displayTitle = "ID:169871",
    abbrTitle = "ID:169872",
    description1 = "ID:169872",
    description2 = "ID:169873",
    instructions_line_1 = "ID:233987",
    instructions_line_2 = "ID:184145",
    instructions_line_3 = "ID:233988",
    instructions_line_1_Func = function()
      return phaseManager.faceOffPhaseLengthPublic
    end,
    screenIconID = 10
  },
  ["Drift"] = {
    displayTitle = "ID:169871",
    abbrTitle = "ID:169874",
    description1 = "ID:169874",
    description2 = "ID:169875",
    instructions_line_1 = "ID:233987",
    instructions_line_2 = "ID:233991",
    instructions_line_3 = "ID:233988",
    instructions_line_1_Func = function()
      return phaseManager.faceOffPhaseLengthPublic
    end,
    screenIconID = 9
  },
  ["Drive far"] = {
    displayTitle = "ID:169871",
    abbrTitle = "ID:169909",
    description1 = "ID:169909",
    description2 = "ID:169910",
    instructions_line_1 = "ID:233987",
    instructions_line_2 = "ID:233989",
    instructions_line_3 = "ID:233988",
    instructions_line_1_Func = function()
      return phaseManager.faceOffPhaseLengthPublic
    end,
    screenIconID = 13
  },
  ["Overtake cars"] = {
    displayTitle = "ID:169871",
    abbrTitle = "ID:169892",
    description1 = "ID:169892",
    description2 = "ID:169893",
    instructions_line_1 = "ID:233987",
    instructions_line_2 = "ID:233992",
    instructions_line_3 = "ID:233988",
    instructions_line_1_Func = function()
      return phaseManager.faceOffPhaseLengthPublic
    end,
    screenIconID = 11
  },
  ["Smash props"] = {
    displayTitle = "ID:169871",
    abbrTitle = "ID:169894",
    description1 = "ID:169894",
    description2 = "ID:169895",
    instructions_line_1 = "ID:233987",
    instructions_line_2 = "ID:233990",
    instructions_line_3 = "ID:233988",
    instructions_line_1_Func = function()
      return phaseManager.faceOffPhaseLengthPublic
    end,
    screenIconID = 12
  },
  ["Stay above 80mph"] = {
    displayTitle = "ID:169871",
    abbrTitle = "ID:169909",
    description1 = "ID:169909",
    description2 = "ID:169910",
    instructions_line_1 = "ID:233987",
    instructions_line_2 = "ID:233989",
    instructions_line_3 = "ID:233988",
    instructions_line_1_Func = function()
      return phaseManager.faceOffPhaseLengthPublic
    end,
    screenIconID = 13
  },
  ["MP tag"] = {
    displayTitle = "ID:169349",
    abbrTitle = "ID:247259",
    description1 = "",
    description2 = "ID:169925",
    instructions_line_1 = "ID:220296",
    instructions_line_2 = "ID:233997",
    instructions_line_3 = "ID:233998",
    instructions_line_3_Func = function()
      return cardSystem.logic.mpTagScoreLimit
    end,
    screenIconID = 6,
    faceOffRewards = 2,
    bronzeMedalReq = "ID:245816",
    silverMedalReq = "ID:245819",
    goldMedalReq = "ID:245820",
    SSinstructions_line_1 = "ID:245881",
    SSinstructions_line_2 = "ID:245900",
    SSinstructions_line_3 = "ID:246686",
    ssResultScreenLine1 = "ID:184917",
    ssResultScreenLine2 = "ID:169349"
  },
  ["MP takedown"] = {
    displayTitle = "ID:169356",
    abbrTitle = "ID:247260",
    description1 = "",
    description2 = "ID:169951",
    instructions_line_1 = "ID:220298",
    instructions_line_2 = "ID:233999",
    instructions_line_3 = "ID:234000",
    screenIconID = 2,
    faceOffRewards = 1,
    roundScreenText = "ID:243716",
    finalRoundScreenText = false
  },
  ["MP burning rubber"] = {
    displayTitle = "ID:168506",
    abbrTitle = "ID:247253",
    description1 = "",
    description2 = "ID:169943",
    instructions_line_1 = "ID:220301",
    instructions_line_2 = "ID:233981",
    instructions_line_3 = "ID:233982",
    screenIconID = 7,
    faceOffRewards = 2
  },
  ["MP circuit race"] = {
    displayTitle = "ID:169316",
    abbrTitle = "ID:247255",
    description1 = "",
    description2 = "ID:169944",
    instructions_line_1 = "ID:220306",
    instructions_line_2 = "ID:233983",
    instructions_line_3 = "ID:247176",
    instructions_line_1_Func = function()
      return cardSystem.logic.mpCircuitRaceLapCount + 1
    end,
    screenIconID = 1,
    faceOffRewards = 2
  },
  ["MP pure race"] = {
    displayTitle = "ID:169326",
    abbrTitle = "ID:247256",
    description1 = "",
    description2 = "ID:169945",
    instructions_line_1 = "ID:220307",
    instructions_line_2 = "ID:233985",
    instructions_line_3 = "ID:233986",
    instructions_line_1_Func = function()
      return cardSystem.logic.mpPureRaceLapCount + 1
    end,
    screenIconID = 1,
    faceOffRewards = 0,
    bronzeMedalReq = "ID:245821",
    silverMedalReq = "ID:245822",
    goldMedalReq = "ID:245823",
    SSinstructions_line_1 = "ID:245904",
    SSinstructions_line_2 = "ID:233985",
    SSinstructions_line_3 = "ID:233984",
    ssResultScreenLine1 = "ID:184917",
    ssResultScreenLine2 = "ID:169326"
  },
  ["MP sprint race"] = {
    displayTitle = "ID:169346",
    abbrTitle = "ID:247258",
    description1 = "",
    description2 = "ID:169946",
    instructions_line_1 = "ID:220310",
    instructions_line_2 = "ID:233995",
    instructions_line_3 = "ID:233996",
    instructions_line_1_Func = function()
      return cardSystem.logic.mpSprintRaceNumRounds
    end,
    description2_Func = function()
      return cardSystem.logic.mpSprintRaceNumRounds
    end,
    screenIconID = 1,
    faceOffRewards = 0,
    roundScreenText = "ID:220240",
    finalRoundScreenText = "ID:169345",
    showRoundScores = true,
    bronzeMedalReq = "ID:245827",
    silverMedalReq = "ID:245831",
    goldMedalReq = "ID:245832",
    SSinstructions_line_1 = "ID:245907",
    SSinstructions_line_2 = "ID:233995",
    SSinstructions_line_3 = "ID:245912",
    ssResultScreenLine1 = "ID:242342",
    ssResultScreenLine2 = "ID:169346"
  },
  ["MP checkpoint rush"] = {
    displayTitle = "ID:243802",
    abbrTitle = "ID:247254",
    description1 = "",
    description2 = "ID:231133",
    instructions_line_1 = "ID:231136",
    instructions_line_2 = "ID:234001",
    instructions_line_3 = "ID:233996",
    screenIconID = 1,
    faceOffRewards = 2,
    bronzeMedalReq = "ID:245824",
    silverMedalReq = "ID:245825",
    goldMedalReq = "ID:245826",
    SSinstructions_line_1 = "ID:231136",
    SSinstructions_line_2 = "ID:245895",
    SSinstructions_line_3 = "ID:245897",
    ssResultScreenLine1 = "ID:184917",
    ssResultScreenLine2 = "ID:243802"
  },
  ["MP tug of war"] = {
    displayTitle = "ID:169282",
    abbrTitle = "ID:247263",
    description1 = "",
    description2 = "ID:169947",
    instructions_line_1 = "ID:220312",
    instructions_line_2 = "ID:234003",
    instructions_line_3 = "ID:234004",
    screenIconID = 3,
    faceOffRewards = 2,
    roundScreenText = "ID:243715",
    finalRoundScreenText = "ID:243717"
  },
  ["MP rush down"] = {
    displayTitle = "ID:169332",
    abbrTitle = "ID:247257",
    description1 = "",
    description2 = "ID:169948",
    instructions_line_1 = "ID:220320",
    instructions_line_2 = "ID:233993",
    instructions_line_3 = "ID:233994",
    screenIconID = 5,
    faceOffRewards = 2,
    roundScreenText = "ID:243715",
    finalRoundScreenText = false
  },
  ["MP trail blazer"] = {
    displayTitle = "ID:169361",
    abbrTitle = "ID:247262",
    description1 = "",
    description2 = "ID:169950",
    instructions_line_1 = "ID:231394",
    instructions_line_2 = "ID:231395",
    instructions_line_3 = "ID:231396",
    instructions_line_3_Func = function()
      return cardSystem.logic.mpTrailScoreLimit
    end,
    screenIconID = 8,
    faceOffRewards = 2,
    bronzeMedalReq = "ID:245816",
    silverMedalReq = "ID:245819",
    goldMedalReq = "ID:245820",
    SSinstructions_line_1 = "ID:231394",
    SSinstructions_line_2 = "ID:231395",
    SSinstructions_line_3 = "ID:246686",
    ssResultScreenLine1 = "ID:184917",
    ssResultScreenLine2 = "ID:169361"
  },
  ["MP team circuit race"] = {
    displayTitle = "ID:231134",
    abbrTitle = "ID:247261",
    description1 = "",
    description2 = "ID:245969",
    instructions_line_1 = "ID:231136",
    instructions_line_2 = "ID:234001",
    instructions_line_3 = "ID:234002",
    screenIconID = 1,
    faceOffRewards = 2
  },
  ["MP Vehicle Swap Tutorial"] = {
    displayTitle = "ID:235989",
    abbrTitle = displayTitle,
    description1 = "",
    description2 = "ID:235990",
    instructions_line_1 = "",
    instructions_line_2 = "",
    instructions_line_3 = "",
    screenIconID = 15,
    faceOffRewards = 0,
    disableInstructions = true
  },
  ["MP Vehicle Spawn Tutorial"] = {
    displayTitle = "ID:235983",
    abbrTitle = "ID:235983",
    description1 = "",
    description2 = "ID:235984",
    instructions_line_1 = "",
    instructions_line_2 = "",
    instructions_line_3 = "",
    screenIconID = 14,
    faceOffRewards = 0,
    disableInstructions = true
  },
  ["MP shift impulse tutorial"] = {
    displayTitle = "ID:235995",
    abbrTitle = "ID:235995",
    description1 = "",
    description2 = "ID:235996",
    instructions_line_1 = "",
    instructions_line_2 = "",
    instructions_line_3 = "",
    screenIconID = 17,
    faceOffRewards = 0,
    disableInstructions = true
  },
  ["MP shift take tutorial"] = {
    displayTitle = "ID:235991",
    abbrTitle = "ID:235991",
    description1 = "",
    description2 = "ID:235993",
    instructions_line_1 = "",
    instructions_line_2 = "",
    instructions_line_3 = "",
    screenIconID = 16,
    faceOffRewards = 0,
    disableInstructions = true
  },
  ["MP general mechanics tutorial"] = {
    displayTitle = "ID:235997",
    abbrTitle = "ID:235997",
    description1 = "",
    description2 = "ID:235999",
    instructions_line_1 = "",
    instructions_line_2 = "",
    instructions_line_3 = "",
    screenIconID = 1,
    faceOffRewards = 0,
    disableInstructions = true
  },
  ["SS Clean the streets"] = {
    displayTitle = "ID:245431",
    abbrTitle = "ID:245431",
    description1 = "",
    description2 = "#STOP THE RACERS!",
    SSinstructions_line_1 = "ID:245885",
    SSinstructions_line_2 = "ID:245886",
    SSinstructions_line_3 = "ID:245887",
    bronzeMedalReq = "ID:245836",
    silverMedalReq = "ID:245837",
    goldMedalReq = "ID:245838",
    screenIconID = 1,
    ssResultScreenLine1Win = "ID:245916",
    ssResultScreenLine1Lose = "ID:245918",
    ssResultScreenLine2Win = "ID:247230",
    ssResultScreenLine2Lose = "ID:247227"
  },
  ["SS Survival"] = {
    displayTitle = "ID:245432",
    abbrTitle = "ID:245432",
    description1 = "",
    description2 = "#GET TO THE CHECKPOINT!",
    SSinstructions_line_1 = "ID:245890",
    SSinstructions_line_2 = "ID:245888",
    SSinstructions_line_3 = "ID:245889",
    bronzeMedalReq = "ID:245839",
    silverMedalReq = "ID:245840",
    goldMedalReq = "ID:245841",
    screenIconID = 1,
    ssResultScreenLine1Win = "ID:245916",
    ssResultScreenLine1Lose = "ID:245918",
    ssResultScreenLine2Win = "ID:247231",
    ssResultScreenLine2Lose = "ID:247228"
  },
  ["SS Go the Distance"] = {
    displayTitle = "ID:245430",
    abbrTitle = "ID:245430",
    description1 = "",
    description2 = "#FUEL THE TARGET VEHICLE",
    SSinstructions_line_1 = "ID:245882",
    SSinstructions_line_2 = "ID:245883",
    SSinstructions_line_3 = "ID:245884",
    bronzeMedalReq = "ID:245839",
    silverMedalReq = "ID:245840",
    goldMedalReq = "ID:245841",
    screenIconID = 1,
    ssResultScreenLine1Win = "ID:245916",
    ssResultScreenLine1Lose = "ID:245918",
    ssResultScreenLine2Win = "ID:247229",
    ssResultScreenLine2Lose = "ID:247226"
  },
  ["SS Freedrive"] = {
    displayTitle = "ID:235348",
    abbrTitle = "ID:235348",
    description1 = "",
    description2 = "#HAVE FUN!",
    SSinstructions_line_1 = "ID:245891",
    SSinstructions_line_2 = "ID:245892",
    SSinstructions_line_3 = "ID:245893",
    screenIconID = 1
  }
}
