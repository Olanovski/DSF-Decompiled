local north = math.pi / 2
challengeProgressionTable = {
  [1] = {
    settings = {
      chapter = 0,
      initialCutscene = "ch0_introduction_01",
      trafficSettings = "Exposition Drive",
      missionVehiclePot = "Exposition",
      chunkFile = "Exposition",
      cityLocking = "CityLockingLevel11_Exposition_Part1",
      cityLockingRequired = true,
      blockZap = true,
      blockAbilities = true,
      blockActiveChallenges = true,
      blockActivities = true,
      blockCollectables = true,
      blockWillpower = true,
      blockGarage = true,
      blockPatrollingVehicles = true
    },
    storyMission = {
      {
        ID = "Exposition 01 Forty Adam Thirty",
        forceStart = true,
        statsMission = false
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
      cityLockingRequired = true,
      blockZap = true,
      blockAbilities = true,
      blockActiveChallenges = true,
      blockActivities = true,
      blockCollectables = true,
      blockWillpower = true,
      blockGarage = true,
      blockPatrollingVehicles = true
    },
    storyMission = {
      {
        ID = "Exposition pre crash chase",
        forceStart = true,
        iconType = "story",
        statsMission = false
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
      cityLockingRequired = true,
      blockZap = true,
      blockAbilities = true,
      blockActiveChallenges = true,
      blockActivities = true,
      blockCollectables = true,
      blockWillpower = true,
      blockGarage = true,
      blockPatrollingVehicles = true
    },
    storyMission = {
      {
        ID = "Exposition pre crash chase alley",
        forceStart = true,
        statsMission = false
      }
    }
  },
  [4] = {
    settings = {
      chapter = 0,
      initialCutscene = "ch0_crash1_02",
      blendCutsceneBillBoard = true,
      blendCutsceneBillBoardID = 0,
      trafficSettings = "Exposition",
      missionVehiclePot = "Exposition",
      chunkFile = "Exposition",
      cityLocking = "CityLockingLevel_WAKEUP",
      cityLockingRequired = true,
      blockZap = true,
      blockAbilities = true,
      blockActivities = true,
      blockCollectables = true,
      blockWillpower = true,
      blockGarage = true,
      blockPatrollingVehicles = true
    },
    storyMission = {
      {
        ID = "Exposition 01 he's getting away",
        forceStart = true,
        statsMission = false
      }
    }
  },
  [5] = {
    settings = {
      chapter = 0,
      initialCutscene = "ch0_ambulance_01",
      trafficSettings = "Exposition",
      missionVehiclePot = "Exposition",
      chunkFile = "Exposition",
      cityLocking = "CityLockingLevel_Ambulance",
      cityLockingRequired = true,
      blockZap = true,
      blockAbilities = true,
      blockWillpower = true,
      blockGarage = true,
      blockActiveChallenges = true,
      blockActivities = true,
      blockCollectables = true,
      blockPatrollingVehicles = true
    },
    storyMission = {
      {
        ID = "Exposition 02 I wish we could help",
        forceStart = true,
        iconType = "story",
        statsMission = false
      }
    }
  },
  [6] = {
    settings = {
      chapter = 0,
      trafficSettings = "Exposition Shift",
      missionVehiclePot = "Exposition",
      chunkFile = "Exposition",
      cityLocking = "CityLockingLevel1",
      cityLockingRequired = true,
      blockAbilities = true,
      maxZapLevel = 1,
      blockWillpower = true,
      blockActiveChallenges = true,
      blockActivities = true,
      blockCollectables = true,
      blockGarage = true,
      blockPatrollingVehicles = true
    },
    storyMission = {
      {
        ID = "Exposition 03 zap at will",
        forceStart = true,
        statsMission = false
      }
    }
  },
  [7] = {
    settings = {
      chapter = 0,
      trafficSettings = "Exposition Shift",
      missionVehiclePot = "Exposition",
      chunkFile = "Exposition",
      cityLocking = "CityLockingLevel1",
      cityLockingRequired = true,
      blockAbilities = true,
      maxZapLevel = 1,
      blockActivities = true,
      blockCollectables = true,
      zapStartPosition = {
        position = vec.vector(44.78378, 41.03349, 2127.889, 1),
        heading = 1
      },
      blockGarage = true,
      blockWillpower = true,
      blockPatrollingVehicles = true
    },
    missions = {
      {
        ID = "Exposition 04 return to dealer",
        iconType = "premiumStunt",
        statsMission = true
      }
    }
  },
  [8] = {
    settings = {
      chapter = 0,
      trafficSettings = "Exposition",
      missionVehiclePot = "Exposition",
      chunkFile = "Exposition",
      cityLocking = "CityLockingLevel1",
      cityLockingRequired = true,
      blockAbilities = true,
      maxZapLevel = 1,
      blockActivities = true,
      blockCollectables = true,
      zapStartPosition = {
        position = vec.vector(44.78378, 41.03349, 2127.889, 1),
        heading = 1
      },
      blockGarage = true,
      blockWillpower = true,
      achievementUnlock = true,
      blockPatrollingVehicles = true
    },
    missions = {
      {
        ID = "Exposition 06 Law Breaker (cop)",
        iconType = "premiumAction",
        statsMission = true,
        doNotSpawn = true
      }
    },
    storyMission = {
      {
        ID = "The debrief",
        iconType = "story",
        evidenceBoard = "Debrief",
        statsMission = true
      }
    }
  },
  [9] = {
    settings = {
      chapter = 0,
      hospitalCutscene = "ch0_coma",
      trafficSettings = "Exposition",
      missionVehiclePot = "Exposition",
      chunkFile = "Exposition",
      cityLocking = "CityLockingLevel1",
      blockCollectables = true,
      zapStartPosition = {
        position = vec.vector(-334.2824, 69.99673, 177.452, 1),
        heading = north
      },
      blockGarage = true,
      blockWillpower = true,
      blockPatrollingVehicles = true
    },
    tutorials = {
      {
        ID = "Tutorial Mission 04 Aerial Jump",
        ability = "aerialZap",
        level = 0,
        type = "potStart",
        forceStartNextMission = "Tutorial dare",
        statsMission = false
      },
      {
        ID = "Tutorial dare",
        forceStartNextMission = "Tutorial garage",
        allowActivityIcons = true,
        statsMission = false
      },
      {
        ID = "Tutorial garage",
        forceStartNextMission = "Tutorial activity",
        doNotSpawn = true,
        allowActivityIcons = true,
        statsMission = false,
        unlocks = {
          {
            type = "stunt",
            subType = "Checkpoints",
            ID = 1
          }
        }
      },
      {
        ID = "Tutorial activity",
        type = "potEnd",
        allowActivityIcons = true,
        doNotSpawn = true,
        statsMission = false
      }
    }
  },
  [10] = {
    settings = {
      chapter = 1,
      chapterTitle = {title = "ID:216870", subtitle = "ID:236226"},
      initialCutscene = "ch1_civ",
      trafficSettings = "Chapter 1",
      missionVehiclePot = "Chapter 1",
      chunkFile = "Chapter1",
      cityLocking = "CityLockingLevel1",
      zapStartPosition = {
        position = vec.vector(-811.2674, 5, -234.0481, 1),
        heading = -2
      },
      achievementUnlock = true
    },
    missions = {
      {
        ID = "1 Downtown race",
        previewAudio = "ghostCollege",
        iconType = "premiumRace",
        unlocksAbility = "nitro",
        statsMission = true
      },
      {
        ID = "Learn to scream",
        previewAudio = "ghostLearn",
        iconType = "premiumStunt",
        statsMission = true,
        unlocks = {
          {
            type = "stunt",
            subType = "Heartometer",
            ID = 1
          }
        }
      },
      {
        ID = "Escape the law",
        previewAudio = "ghostMeet",
        iconType = "premiumAction",
        evidenceBoard = "Meet The Heat",
        unlocksAbility = "ram",
        statsMission = true
      },
      {
        ID = "Breaking news",
        previewAudio = "ghostBreaking",
        iconType = "premiumStunt",
        statsMission = true,
        unlocks = {
          {
            type = "stunt",
            subType = "Checkpoints",
            ID = 2
          }
        }
      }
    },
    tannerMission = {
      {
        ID = "Tanner & Jones Mission 1",
        iconType = "story",
        statsMission = true
      }
    },
    storyMission = {
      {
        ID = "Trunked",
        iconType = "story",
        evidenceBoard = "Kidnapped",
        statsMission = true
      }
    },
    tutorials = {
      {
        ID = "Tutorial Mission 01 Boost",
        ability = "nitro",
        level = 0,
        statsMission = false,
        unlocks = {
          {
            type = "race",
            subType = "Race",
            ID = 1
          },
          {
            type = "race",
            subType = "OpenRace",
            ID = 1
          }
        }
      },
      {
        ID = "Tutorial Mission 02 Ram",
        ability = "ram",
        level = 0,
        statsMission = false,
        unlocks = {
          {
            type = "action",
            subType = "Getaway",
            ID = 1
          },
          {
            type = "action",
            subType = "Chase",
            ID = 1
          }
        }
      }
    }
  },
  [11] = {
    settings = {
      chapter = 2,
      chapterTitle = {title = "ID:216871", subtitle = "ID:236227"},
      initialCutscene = "ch2_civ",
      cityUnlockCutscene = "cuv_area01",
      trafficSettings = "Chapter 2",
      missionVehiclePot = "Chapter 2",
      chunkFile = "Chapter2",
      cityLocking = "CityLockingLevel2",
      zapStartPosition = {
        position = vec.vector(-1520.516, 47.42768, 1379.025, 1),
        heading = 1.693002
      },
      achievementUnlock = true
    },
    missions = {
      {
        ID = "Easy Street",
        previewAudio = "ghostDouble",
        iconType = "premiumRace",
        statsMission = true,
        unlocks = {
          {
            type = "race",
            subType = "OpenRace",
            ID = 2
          },
          {
            type = "race",
            subType = "Race",
            ID = 2
          }
        }
      },
      {
        ID = "All clubbed out",
        previewAudio = "ghostBig",
        iconType = "premiumStunt",
        statsMission = true,
        unlocks = {
          {
            type = "stunt",
            subType = "Smash",
            ID = 1
          },
          {
            type = "stunt",
            subType = "Checkpoints",
            ID = 3
          }
        }
      },
      {
        ID = "Streetrace takedown",
        previewAudio = "ghostStreet",
        iconType = "premiumAction",
        statsMission = true,
        unlocks = {
          {
            type = "action",
            subType = "StreetRace",
            ID = 1
          }
        }
      },
      {
        ID = "Take down",
        previewAudio = "ghostMission",
        iconType = "premiumAction",
        statsMission = true,
        unlocks = {
          {
            type = "action",
            subType = "Chase",
            ID = 2
          }
        }
      }
    },
    tannerMission = {
      {
        ID = "Tanner & Jones Mission 2",
        iconType = "story",
        evidenceBoard = "Real Police Work",
        cityLockingRequired = true,
        statsMission = true
      }
    },
    storyMission = {
      {
        ID = "Heat From Above",
        iconType = "story",
        evidenceBoard = "Eyes On The City",
        statsMission = true
      }
    },
    tutorials = {
      {
        ID = "Tutorial Mission Rapid Shift",
        ability = "zapReturn",
        level = 0,
        type = "potStart",
        statsMission = false
      }
    }
  },
  [12] = {
    settings = {
      chapter = 3,
      chapterTitle = {title = "ID:216872", subtitle = "ID:236228"},
      hospitalCutscene = "ch2_coma",
      initialCutscene = "ch3_civ",
      trafficSettings = "Chapter 3",
      missionVehiclePot = "Chapter 3",
      chunkFile = "Chapter3",
      cityLocking = "CityLockingLevel2",
      zapStartPosition = {
        position = vec.vector(-3478.981, 41.44078, 1621.418, 1),
        heading = north
      },
      achievementUnlock = true
    },
    missions = {
      {
        ID = "Team colours 01",
        previewAudio = "ghostTeam",
        iconType = "premiumRace",
        statsMission = true,
        unlocks = {
          {
            type = "race",
            subType = "TeamColours",
            ID = 1
          },
          {
            type = "race",
            subType = "Race",
            ID = 3
          }
        }
      },
      {
        ID = "In the nick of time",
        previewAudio = "ghostNick",
        iconType = "premiumAction",
        statsMission = true,
        unlocks = {
          {
            type = "action",
            subType = "Chase",
            ID = 3
          },
          {
            type = "action",
            subType = "StreetRace",
            ID = 2
          }
        }
      },
      {
        ID = "Wrecked evidence",
        previewAudio = "ghostWrecked",
        iconType = "premiumAction",
        trafficFrequencyOverride = 1,
        statsMission = true,
        unlocks = {
          {
            type = "action",
            subType = "Protect",
            ID = 1
          }
        }
      },
      {
        ID = "TheSneakout",
        previewAudio = "ghostParanoia",
        iconType = "premiumStunt",
        statsMission = true,
        unlocks = {
          {
            type = "stunt",
            subType = "Smash",
            ID = 2
          },
          {
            type = "stunt",
            subType = "Checkpoints",
            ID = 4
          }
        }
      }
    },
    tannerMission = {
      {
        ID = "Tanner And Jones 3",
        iconType = "story",
        evidenceBoard = "Shakedown",
        statsMission = true
      }
    },
    storyMission = {
      {
        ID = "Peroxide convoy",
        iconType = "story",
        evidenceBoard = "Freeway Inferno",
        cityLockingRequired = true,
        statsMission = true
      }
    },
    tutorials = {
      {
        ID = "Tutorial Mission 05 Aerial Jump",
        ability = "aerialZap",
        level = 1,
        type = "potStart",
        statsMission = false
      }
    }
  },
  [13] = {
    settings = {
      chapter = 4,
      chapterTitle = {title = "ID:216873", subtitle = "ID:236229"},
      initialCutscene = "ch4_civ",
      cityUnlockCutscene = "cuv_area02",
      trafficSettings = "Chapter 4",
      missionVehiclePot = "Chapter 4",
      chunkFile = "Chapter4",
      cityLocking = "CityLockingLevel3",
      zapStartPosition = {
        position = vec.vector(-1250.932, 169.125, 3753.329, 1),
        heading = north
      },
      achievementUnlock = true
    },
    missions = {
      {
        ID = "Speed Race",
        previewAudio = "ghostBaja",
        iconType = "premiumRace",
        statsMission = true,
        unlocks = {
          {
            type = "race",
            subType = "TeamColours",
            ID = 2
          },
          {
            type = "race",
            subType = "OpenRace",
            ID = 3
          }
        }
      },
      {
        ID = "Felony lure",
        previewAudio = "ghostPaper",
        iconType = "premiumStunt",
        trafficFrequencyOverride = 2,
        statsMission = true,
        unlocks = {
          {
            type = "stunt",
            subType = "Checkpoints",
            ID = 5
          },
          {
            type = "stunt",
            subType = "Smash",
            ID = 3
          }
        }
      },
      {
        ID = "Final destination",
        previewAudio = "ghostHandle",
        iconType = "premiumStunt",
        statsMission = true,
        unlocks = {
          {
            type = "stunt",
            subType = "Heartometer",
            ID = 2
          },
          {
            type = "stunt",
            subType = "Checkpoints",
            ID = 6
          }
        }
      },
      {
        ID = "Escape the law 3",
        previewAudio = "ghostGetaway",
        iconType = "premiumAction",
        statsMission = true,
        unlocks = {
          {
            type = "action",
            subType = "Getaway",
            ID = 2
          },
          {
            type = "action",
            subType = "StreetRace",
            ID = 3
          }
        }
      }
    },
    tannerMission = {
      {
        ID = "Tanner & Jones Mission 4",
        iconType = "story",
        evidenceBoard = "The Conversation",
        statsMission = true
      }
    },
    storyMission = {
      {
        ID = "Collateral Damage",
        iconType = "story",
        evidenceBoard = "Collateral Damage",
        statsMission = true
      }
    }
  },
  [14] = {
    settings = {
      chapter = 5,
      chapterTitle = {title = "ID:216874", subtitle = "ID:236230"},
      hospitalCutscene = "ch4_coma",
      initialCutscene = "ch5_civ",
      cityUnlockCutscene = "cuv_area03",
      trafficSettings = "Chapter 5",
      missionVehiclePot = "Chapter 5",
      chunkFile = "Chapter5",
      cityLocking = "CityLockingLevel4",
      zapStartPosition = {
        position = vec.vector(-848.5262, 61.63164, -3586.094, 1),
        heading = north
      },
      achievementUnlock = true
    },
    missions = {
      {
        ID = "Race away",
        previewAudio = "ghostRace",
        iconType = "premiumRace",
        statsMission = true,
        unlocks = {
          {
            type = "race",
            subType = "RaceAway",
            ID = 1
          },
          {
            type = "race",
            subType = "TeamColours",
            ID = 3
          }
        }
      },
      {
        ID = "Bad medicine",
        previewAudio = "ghostBad",
        iconType = "premiumAction",
        statsMission = true,
        unlocks = {
          {
            type = "stunt",
            subType = "Smash",
            ID = 4
          },
          {
            type = "stunt",
            subType = "Checkpoints",
            ID = 7
          }
        }
      },
      {
        ID = "Deactivating bombs under trucks",
        previewAudio = "ghostTicking",
        iconType = "premiumStunt",
        statsMission = true,
        unlocks = {
          {
            type = "stunt",
            subType = "Tanker",
            ID = 1
          }
        }
      },
      {
        ID = "DriveToSurvive",
        previewAudio = "ghostDrive",
        iconType = "premiumStunt",
        statsMission = true,
        unlocks = {
          {
            type = "stunt",
            subType = "Heartometer",
            ID = 3
          }
        }
      }
    },
    tannerMission = {
      {
        ID = "TestDrive",
        iconType = "story",
        evidenceBoard = "Test Drive",
        statsMission = true
      }
    },
    storyMission = {
      {
        ID = "Something weird",
        iconType = "story",
        statsMission = true
      }
    },
    tutorials = {
      {
        ID = "Tutorial Mission 06 Aerial Jump",
        ability = "aerialZap",
        level = 2,
        type = "potStart"
      }
    }
  },
  [15] = {
    settings = {
      chapter = 6,
      chapterTitle = {title = "ID:216875", subtitle = "ID:236231"},
      initialCutscene = "ch6_civ",
      trafficSettings = "Chapter 6",
      missionVehiclePot = "Chapter 6",
      chunkFile = "Chapter6",
      cityLocking = "CityLockingLevel4",
      zapStartPosition = {
        position = vec.vector(-1371.255, 67.02634, 2200.743, 1),
        heading = north
      },
      achievementUnlock = true
    },
    missions = {
      {
        ID = "High plains drifter",
        previewAudio = "ghostGroup",
        iconType = "premiumRace",
        statsMission = true,
        unlocks = {
          {
            type = "race",
            subType = "RaceAway",
            ID = 2
          },
          {
            type = "race",
            subType = "TeamColours",
            ID = 4
          }
        }
      },
      {
        ID = "Protect the base",
        previewAudio = "ghostBest",
        iconType = "premiumAction",
        statsMission = true,
        unlocks = {
          {
            type = "action",
            subType = "Protect",
            ID = 2
          },
          {
            type = "action",
            subType = "Getaway",
            ID = 3
          }
        }
      },
      {
        ID = "Smash tv",
        previewAudio = "ghostTriple",
        iconType = "premiumAction",
        statsMission = true,
        unlocks = {
          {
            type = "action",
            subType = "StreetRace",
            ID = 4
          },
          {
            type = "race",
            subType = "RelayRace",
            ID = 1
          }
        }
      },
      {
        ID = "Gone in 59 seconds",
        previewAudio = "ghostCharity",
        iconType = "premiumStunt",
        statsMission = true,
        unlocks = {
          {
            type = "stunt",
            subType = "Heartometer",
            ID = 4
          },
          {
            type = "stunt",
            subType = "Checkpoints",
            ID = 8
          }
        }
      }
    },
    tannerMission = {
      {
        ID = "Tanner and Jones 6",
        iconType = "story",
        evidenceBoard = "The Escapist",
        statsMission = true
      }
    },
    storyMission = {
      {
        ID = "Kill Tanner",
        iconType = "story",
        evidenceBoard = "The Target",
        statsMission = true
      }
    }
  },
  [16] = {
    settings = {
      chapter = 7,
      chapterTitle = {title = "ID:216876", subtitle = "ID:236232"},
      initialCutscene = "ch7_civ",
      trafficSettings = "Chapter 7",
      missionVehiclePot = "Chapter 7",
      chunkFile = "Chapter7",
      cityLocking = "CityLockingLevel4",
      zapStartPosition = {
        position = vec.vector(-1013.457, 24.47823, -2851.599, 1),
        heading = north
      },
      achievementUnlock = true
    },
    missions = {
      {
        ID = "Marin County race",
        previewAudio = "ghostCheckered",
        iconType = "premiumRace",
        statsMission = true,
        unlocks = {
          {
            type = "race",
            subType = "RaceAway",
            ID = 3
          },
          {
            type = "race",
            subType = "TeamColours",
            ID = 5
          }
        }
      },
      {
        ID = "Mass Chase",
        previewAudio = "ghostUndercover",
        iconType = "premiumAction",
        statsMission = true,
        unlocks = {
          {
            type = "action",
            subType = "Getaway",
            ID = 4
          },
          {
            type = "action",
            subType = "Chase",
            ID = 4
          }
        }
      },
      {
        ID = "Bad medicine 2",
        previewAudio = "ghostFever",
        iconType = "premiumAction",
        statsMission = true,
        unlocks = {
          {
            type = "action",
            subType = "Protect",
            ID = 3
          },
          {
            type = "action",
            subType = "StreetRace",
            ID = 5
          }
        }
      },
      {
        ID = "Breaking news 2",
        previewAudio = "ghostSpecial",
        iconType = "premiumStunt",
        statsMission = true,
        unlocks = {
          {
            type = "stunt",
            subType = "Tanker",
            ID = 2
          },
          {
            type = "stunt",
            subType = "Checkpoints",
            ID = 9
          }
        }
      }
    },
    tannerMission = {
      {
        ID = "Tanner and Jones 7",
        iconType = "story",
        evidenceBoard = "Entrapment",
        statsMission = true
      }
    },
    storyMission = {
      {
        ID = "Alone",
        iconType = "story",
        statsMission = true
      }
    }
  },
  [17] = {
    settings = {
      chapter = 8,
      initialCutscene = "mis_ch8_finale_01",
      trafficSettings = "Chase traffic 5",
      missionVehiclePot = "Chapter 8",
      cityLocking = "CityLockingLevel4",
      chunkFile = "Finale",
      blockActiveChallenges = true,
      blockGarage = true
    },
    storyMission = {
      {
        ID = "Final fight",
        iconType = "story",
        forceStart = true,
        statsMission = true
      }
    }
  },
  [18] = {
    settings = {
      chapter = 8,
      trafficSettings = "Chapter 8",
      missionVehiclePot = "Chapter 8",
      cityLocking = "CityLockingLevel4",
      chunkFile = "Finale",
      blockActiveChallenges = true,
      blockGarage = true
    },
    storyMission = {
      {
        ID = "Avoid The Cars",
        iconType = "story",
        forceStart = true,
        statsMission = true
      }
    }
  },
  [19] = {
    settings = {
      chapter = 8,
      trafficSettings = "Mind Control",
      initialCutscene = "ch8_sm8_01",
      missionVehiclePot = "Chapter 8",
      cityLocking = "CityLockingLevel4",
      chunkFile = "Finale",
      achievementUnlock = true,
      blockActiveChallenges = true,
      blockGarage = true
    },
    storyMission = {
      {
        ID = "Anything you can do",
        iconType = "story",
        forceStart = true,
        statsMission = true
      }
    }
  },
  [20] = {
    settings = {
      chapter = 9,
      cityLocking = "CityLockingLevel_Epilogue",
      cityLockingRequired = true,
      initialCutscene = "ch9_finale_01",
      trafficSettings = "Epilogue",
      missionVehiclePot = "Epilogue",
      chunkFile = "Epilogue",
      blockZap = true,
      blockAbilities = true,
      blockActiveChallenges = true,
      blockGarage = true,
      blockWillpower = true,
      blockCollectables = true
    },
    storyMission = {
      {
        ID = "Epilogue",
        iconType = "story",
        forceStart = true,
        statsMission = true
      }
    }
  },
  [21] = {
    settings = {
      chapter = 9,
      initialCutscene = "ch9_finale_02",
      trafficSettings = "Epilogue",
      missionVehiclePot = "Epilogue",
      chunkFile = "Epilogue",
      cityLocking = "CityLockingLevel4",
      achievementUnlock = true,
      blockZap = true,
      blockAbilities = true,
      blockActiveChallenges = true,
      blockWillpower = true,
      blockGarage = true,
      blockCollectables = true
    },
    storyMission = {
      {
        ID = "Epilogue pt 2",
        iconType = "story",
        forceStart = true,
        statsMission = true
      }
    }
  },
  [22] = {
    settings = {
      chapter = 10,
      trafficSettings = "Chapter 7",
      missionVehiclePot = "Free Drive",
      chunkFile = "Chapter7",
      zapStartPosition = {
        position = vec.vector(-819.2914, 77.98473, 1835.854, 1),
        heading = north
      },
      cityLocking = "CityLockingLevel4",
      evidenceBoardUpdate = "Game Complete",
      blockActiveChallenges = true
    },
    missions = {}
  },
  [9999] = {
    settings = {
      cityLocking = "CityLockingLevel4",
      trafficSettings = "Chapter 7",
      infiniteLoop = true
    },
    missions = {
      {
        ID = "RGD Test Mission"
      }
    }
  }
}
