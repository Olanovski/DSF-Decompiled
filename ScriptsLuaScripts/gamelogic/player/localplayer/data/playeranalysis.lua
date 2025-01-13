module("localPlayer.playerAnalysis", package.seeall)
defaultPlayerAnalysis = {
  Drift = 0.5,
  Jump = 0.7,
  Overtake = 0.35,
  OvertakeOncomming = 0.55,
  Trailer = 1.5,
  HighSpeedDriving = 0.14,
  SafeDriving = 1,
  DrivingInAnAlley = 0,
  PlayerCollision = 0.02
}
playerAnalysisDecay = 0.0003
playerAnalysisForMission = {
  Race = {
    ["1 Downtown race"] = {decay = 4E-05},
    ["Easy Street"] = {decay = 5E-05},
    ["Team colours 01"] = {
      playerAnalysis = {
        Drift = 0.75,
        Jump = 0.3,
        Overtake = 0.35,
        OvertakeOncomming = 0.55,
        Trailer = 1,
        HighSpeedDriving = 0.3,
        SafeDriving = 1.5,
        PlayerCollision = 0.02
      },
      decay = 2E-05
    },
    ["Speed Race"] = {
      playerAnalysis = {Drift = 0.4},
      decay = 4E-05
    },
    ["Race away"] = {decay = 8E-05},
    ["High plains drifter"] = {
      playerAnalysis = {
        Drift = 0.1,
        Jump = 0.2,
        Overtake = 0.35,
        OvertakeOncomming = 0.55,
        Trailer = 1.5,
        HighSpeedDriving = 0.1,
        SafeDriving = 0.4,
        DrivingInAnAlley = 0,
        PlayerCollision = 0.1
      },
      decay = 8E-05
    },
    ["Marin County race"] = {decay = 0.0001},
    ["OR1Activity"] = {
      playerAnalysis = {
        Jump = 0.5,
        Drift = 0.3,
        Overtake = 0.3,
        OvertakeOncomming = 0.2,
        HighSpeedDriving = 0.1,
        SafeDriving = 0.5,
        DrivingInAnAlley = 0.01,
        PlayerCollision = 0.07
      },
      decay = 0.0001
    },
    ["OR2Activity"] = {
      playerAnalysis = {
        Jump = 0.3,
        Overtake = 0.3,
        OvertakeOncomming = 0.2,
        HighSpeedDriving = 0.1,
        SafeDriving = 0.5,
        PlayerCollision = 0.08
      },
      decay = 0.0001
    },
    ["OR3Activity"] = {
      playerAnalysis = {
        Jump = 0.3,
        Overtake = 0.3,
        OvertakeOncomming = 0.2,
        HighSpeedDriving = 0.1,
        SafeDriving = 0.5,
        PlayerCollision = 0.04
      },
      decay = 0.0001
    },
    ["RaceActivity1"] = {
      playerAnalysis = {
        Jump = 0.3,
        Overtake = 0.3,
        OvertakeOncomming = 0.2,
        HighSpeedDriving = 0.1,
        SafeDriving = 0.5,
        PlayerCollision = 0.04
      },
      decay = 0.0001
    },
    ["RaceActivity2"] = {
      playerAnalysis = {
        Overtake = 0.3,
        OvertakeOncomming = 0.2,
        HighSpeedDriving = 0.1,
        SafeDriving = 0.5,
        PlayerCollision = 0.04
      },
      decay = 0.0001
    },
    ["RaceActivity3"] = {
      playerAnalysis = {
        Jump = 0.3,
        Overtake = 0.3,
        OvertakeOncomming = 0.2,
        HighSpeedDriving = 0.1,
        SafeDriving = 0.5,
        PlayerCollision = 0.04
      },
      decay = 0.0001
    },
    ["RaceAwayActivity1"] = {
      playerAnalysis = {
        Jump = 0.3,
        Overtake = 0.3,
        OvertakeOncomming = 0.2,
        SafeDriving = 0.5
      },
      decay = 6E-05
    },
    ["RaceAwayActivity2"] = {
      playerAnalysis = {
        Jump = 0.3,
        Overtake = 0.3,
        OvertakeOncomming = 0.2,
        SafeDriving = 0.5
      },
      decay = 6E-05
    },
    ["RaceAwayActivity3"] = {
      playerAnalysis = {
        Jump = 0.3,
        Overtake = 0.3,
        OvertakeOncomming = 0.2,
        SafeDriving = 0.5
      },
      decay = 0.0001
    },
    ["RelayRaceActivity"] = {
      playerAnalysis = {
        Drift = 0.2,
        Jump = 0.2,
        Overtake = 0.1,
        OvertakeOncomming = 0.2,
        HighSpeedDriving = 0.07,
        SafeDriving = 0.5,
        PlayerCollision = 0.04
      },
      decay = 0.0001
    },
    ["TC1Activity"] = {
      playerAnalysis = {
        Drift = 0.2,
        Jump = 0.2,
        Overtake = 0.15,
        OvertakeOncomming = 0.2,
        HighSpeedDriving = 0.15,
        SafeDriving = 1,
        PlayerCollision = 0.05
      },
      decay = 8E-05
    },
    ["TC2Activity"] = {
      playerAnalysis = {
        Drift = 0.2,
        Jump = 0.2,
        Overtake = 0.15,
        OvertakeOncomming = 0.2,
        HighSpeedDriving = 0.15,
        SafeDriving = 1,
        PlayerCollision = 0.05
      },
      decay = 8E-05
    },
    ["TC3Activity"] = {
      playerAnalysis = {
        Drift = 0.2,
        Jump = 0.2,
        Overtake = 0.15,
        OvertakeOncomming = 0.2,
        HighSpeedDriving = 0.15,
        SafeDriving = 1,
        PlayerCollision = 0.05
      },
      decay = 8E-05
    },
    ["TC4Activity"] = {
      playerAnalysis = {
        Drift = 0.2,
        Jump = 0.2,
        Overtake = 0.15,
        OvertakeOncomming = 0.2,
        HighSpeedDriving = 0.07,
        SafeDriving = 1,
        PlayerCollision = 0.05
      },
      decay = 8E-05
    },
    ["TC5Activity"] = {
      playerAnalysis = {
        Drift = 0.2,
        Jump = 0.2,
        Overtake = 0.15,
        OvertakeOncomming = 0.2,
        HighSpeedDriving = 0.15,
        SafeDriving = 1,
        PlayerCollision = 0.05
      },
      decay = 8E-05
    },
    ["RallyFaceOff"] = {
      playerAnalysis = {
        Drift = 0.6,
        Jump = 0.8,
        Overtake = 0.7,
        OvertakeOncomming = 0.55,
        Trailer = 1.5,
        HighSpeedDriving = 0.2,
        SafeDriving = 1,
        DrivingInAnAlley = 0,
        PlayerCollision = 0.02
      },
      decay = 4E-05
    },
    ["FreewayFaceoff"] = {decay = 4E-05},
    ["MarinEscape"] = {decay = 4E-05},
    ["Team colours tutorial"] = {decay = 4E-05},
    ["Smoketrail"] = {decay = 4E-05},
    ["RelayRace"] = {decay = 4E-05},
    ["Uplaych1"] = {decay = 4E-05},
    ["Uplaych2"] = {decay = 4E-05}
  }
}
