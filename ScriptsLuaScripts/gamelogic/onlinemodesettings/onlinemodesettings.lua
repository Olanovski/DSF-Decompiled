PLAYER_STRING_TABLE = {
  [1] = "Player 1",
  [2] = "Player 2",
  [3] = "Player 3",
  [4] = "Player 4",
  [5] = "Player 5",
  [6] = "Player 6",
  [7] = "Player 7",
  [8] = "Player 8"
}
OBJ_TEAM_ONE_STRING_TABLE = {
  [1] = "Objective Team 1 member 1",
  [2] = "Objective Team 1 member 2",
  [3] = "Objective Team 1 member 3",
  [4] = "Objective Team 1 member 4",
  [5] = "Objective Team 1 member 5",
  [6] = "Objective Team 1 member 6",
  [7] = "Objective Team 1 member 7",
  [8] = "Objective Team 1 member 8"
}
OBJ_TEAM_TWO_STRING_TABLE = {
  [1] = "Objective Team 2 member 1",
  [2] = "Objective Team 2 member 2",
  [3] = "Objective Team 2 member 3",
  [4] = "Objective Team 2 member 4",
  [5] = "Objective Team 2 member 5",
  [6] = "Objective Team 2 member 6",
  [7] = "Objective Team 2 member 7",
  [8] = "Objective Team 2 member 8"
}
OBJ_TEAM_THREE_STRING_TABLE = {
  [1] = "Objective Team 3 member 1",
  [2] = "Objective Team 3 member 2",
  [3] = "Objective Team 3 member 3",
  [4] = "Objective Team 3 member 4",
  [5] = "Objective Team 3 member 5",
  [6] = "Objective Team 3 member 6",
  [7] = "Objective Team 3 member 7",
  [8] = "Objective Team 3 member 8"
}
module("OnlineModeSettings", package.seeall)
onlineDisableAssert = false
alphaMask32 = vec.vector(0, 0, 0, -51)
alphaMask128 = vec.vector(0, 0, 0, -0.2)
targetAlphaMask32 = vec.vector(0, 0, 0, -96)
targetAlphaMask128 = vec.vector(0, 0, 0, -0.375)
flagAlphaMask = vec.vector(255, 255, 255, 102)
yellow32 = vec.vector(246, 196, 14, 255)
yellow128 = vec.vector(0.9647, 0.7686, 0.0549, 1)
yellow32a = yellow32 + alphaMask32
yellow128a = yellow128 + alphaMask128
teamYellow = yellow32
teamDevYellow = yellow128
red32 = vec.vector(205, 37, 50, 255)
red128 = vec.vector(0.8039, 0.1451, 0.1961, 1)
red32a = red32 + alphaMask32
red128a = red128 + alphaMask128
teamRed = red32
teamDevRed = red128
blue32 = vec.vector(57, 150, 196, 255)
blue128 = vec.vector(0.2235, 0.5882, 0.7686, 1)
blue32a = blue32 + alphaMask32
blue128a = blue128 + alphaMask128
teamBlue = blue32
teamDevBlue = blue128
pink32 = vec.vector(255, 0, 255, 255)
pink128 = vec.vector(1, 0, 1, 1)
pink32a = pink32 + alphaMask32
pink128a = pink128 + alphaMask128
green32 = vec.vector(0, 200, 0, 255)
green128 = vec.vector(0, 0.8, 0, 1)
green32a = green32 + alphaMask32
green128a = green128 + alphaMask128
grey32 = vec.vector(224, 221, 212, 255)
grey128 = vec.vector(0.8784, 0.8667, 0.8314, 1)
grey32a = grey32 + alphaMask32
grey128a = grey128 + alphaMask128
orange32 = vec.vector(255, 178, 0, 255)
orange128 = vec.vector(1, 0.698, 0, 1)
orange32a = orange32 + alphaMask32
orange128a = orange128 + alphaMask128
targetOffset = vec.vector(0, 5, 0, 0)
basetargetOffset = vec.vector(0, 2.5, 0, 0)
function createTargetMarker()
  return {
    type = "Target",
    targetType = "Destination",
    gadgetID = 73,
    radius = 50,
    visible = true,
    showDistance = true,
    colour = yellow32 + targetAlphaMask32,
    position = vec.vector(0, 10, 0, 0),
    twoDMarker = false,
    twoDMarkerRadius = 0,
    flashes = false,
    proximityFlash = true,
    zapBackPrompt = false,
    zapBackPromptAboveCar = false,
    introType = "Fade",
    outroType = "Fade"
  }
end
function createMiniMapMarker()
  return {
    type = "Minimap",
    gadgetID = 73,
    radius = 30,
    visible = true,
    colour = yellow32,
    flash = true,
    nofade = true,
    canrotate = false,
    introType = "BigScaleDown",
    animationType = "WaveScale",
    outroType = "Fade"
  }
end
vehicleTypeRally = {
  [1] = {
    vehicleID = 217,
    shader = {
      [0] = -1
    }
  },
  [2] = {
    vehicleID = 195,
    shader = {
      [0] = -1
    }
  },
  [3] = {
    vehicleID = 142,
    shader = {
      [0] = -1
    }
  },
  [4] = {
    vehicleID = 275,
    shader = {
      [0] = -1
    }
  },
  [5] = {
    vehicleID = 292,
    shader = {
      [0] = -1
    }
  }
}
vehicleTypeRoad = {
  [1] = {
    vehicleID = 226,
    shader = {
      [0] = -1
    }
  },
  [2] = {
    vehicleID = 135,
    shader = {
      [0] = -1
    }
  },
  [3] = {
    vehicleID = 243,
    shader = {
      [0] = -1
    }
  },
  [4] = {
    vehicleID = 139,
    shader = {
      [0] = -1
    }
  },
  [5] = {
    vehicleID = 189,
    shader = {
      [0] = -1
    }
  },
  [6] = {
    vehicleID = 225,
    shader = {
      [0] = -1
    }
  }
}
vehicleTypeMixed = {
  [1] = {
    vehicleID = 229,
    shader = {
      [0] = -1
    }
  },
  [2] = {
    vehicleID = 182,
    shader = {
      [0] = -1
    }
  },
  [3] = {
    vehicleID = 228,
    shader = {
      [0] = -1
    }
  },
  [4] = {
    vehicleID = 143,
    shader = {
      [0] = -1
    }
  },
  [5] = {
    vehicleID = 139,
    shader = {
      [0] = -1
    }
  },
  [6] = {
    vehicleID = 133,
    shader = {
      [0] = -1
    }
  },
  [7] = {
    vehicleID = 299,
    shader = {
      [0] = -1
    }
  }
}
vehicleTypeMixed02 = {
  [1] = {
    vehicleID = 229,
    shader = {
      [0] = -1
    }
  },
  [2] = {
    vehicleID = 182,
    shader = {
      [0] = -1
    }
  },
  [3] = {
    vehicleID = 228,
    shader = {
      [0] = -1
    }
  },
  [4] = {
    vehicleID = 143,
    shader = {
      [0] = -1
    }
  },
  [5] = {
    vehicleID = 133,
    shader = {
      [0] = -1
    }
  },
  [6] = {
    vehicleID = 299,
    shader = {
      [0] = -1
    }
  }
}
vehicleTypeMuscle = {
  [1] = {
    vehicleID = 236,
    shader = {
      [0] = -1
    }
  },
  [2] = {
    vehicleID = 191,
    shader = {
      [0] = -1
    }
  },
  [3] = {
    vehicleID = 233,
    shader = {
      [0] = -1
    }
  },
  [4] = {
    vehicleID = 175,
    shader = {
      [0] = -1
    }
  },
  [5] = {
    vehicleID = 160,
    shader = {
      [0] = -1
    }
  },
  [6] = {
    vehicleID = 230,
    shader = {
      [0] = -1
    }
  }
}
vehicleTypeTraffic = {
  [1] = {
    vehicleID = 241,
    shader = {
      [0] = -1
    }
  },
  [2] = {
    vehicleID = 173,
    shader = {
      [0] = -1
    }
  },
  [3] = {
    vehicleID = 158,
    shader = {
      [0] = -1
    }
  },
  [4] = {
    vehicleID = 194,
    shader = {
      [0] = -1
    }
  },
  [5] = {
    vehicleID = 242,
    shader = {
      [0] = -1
    }
  }
}
vehicleTypeTraffic01 = {
  [1] = {
    vehicleID = 241,
    shader = {
      [0] = -1
    }
  },
  [2] = {
    vehicleID = 173,
    shader = {
      [0] = -1
    }
  },
  [3] = {
    vehicleID = 158,
    shader = {
      [0] = -1
    }
  },
  [4] = {
    vehicleID = 242,
    shader = {
      [0] = -1
    }
  }
}
vehicleTypeTraffic02 = {
  [1] = {
    vehicleID = 138,
    shader = {
      [0] = -1
    }
  },
  [2] = {
    vehicleID = 176,
    shader = {
      [0] = -1
    }
  },
  [3] = {
    vehicleID = 147,
    shader = {
      [0] = -1
    }
  },
  [4] = {
    vehicleID = 213,
    shader = {
      [0] = -1
    }
  }
}
vehicleTypeTraffic03 = {
  [1] = {
    vehicleID = 136,
    shader = {
      [0] = -1
    }
  },
  [2] = {
    vehicleID = 229,
    shader = {
      [0] = -1
    }
  },
  [3] = {
    vehicleID = 274,
    shader = {
      [0] = -1
    }
  },
  [4] = {
    vehicleID = 192,
    shader = {
      [0] = -1
    }
  }
}
vehicleTypeMixedRally = {
  [1] = {
    vehicleID = 217,
    shader = {
      [0] = -1
    }
  },
  [2] = {
    vehicleID = 195,
    shader = {
      [0] = -1
    }
  },
  [3] = {
    vehicleID = 142,
    shader = {
      [0] = -1
    }
  },
  [4] = {
    vehicleID = 275,
    shader = {
      [0] = -1
    }
  }
}
vehicleTypePureRally = {
  [1] = {
    vehicleID = 217,
    shader = {
      [0] = -1
    }
  },
  [2] = {
    vehicleID = 195,
    shader = {
      [0] = -1
    }
  },
  [3] = {
    vehicleID = 142,
    shader = {
      [0] = -1
    }
  },
  [4] = {
    vehicleID = 275,
    shader = {
      [0] = -1
    }
  },
  [5] = {
    vehicleID = 293,
    shader = {
      [0] = -1
    }
  }
}
vehicleTypeDriftRally = {
  [1] = {
    vehicleID = 217,
    shader = {
      [0] = -1
    }
  },
  [2] = {
    vehicleID = 195,
    shader = {
      [0] = -1
    }
  },
  [3] = {
    vehicleID = 142,
    shader = {
      [0] = -1
    }
  },
  [4] = {
    vehicleID = 293,
    shader = {
      [0] = -1
    }
  }
}
onlineDefaultMoodIndex = 1
onlineChapterMoods = {
  [1] = "OnlineDefault"
}
onlineMoodsDowntown1 = {
  [1] = "OnlineBlues",
  [2] = "OnlineBullitt",
  [3] = "OnlineLAConnection",
  [4] = "OnlineWhiteStripe"
}
onlineMoodsDowntown2 = {
  [1] = "OnlineBandit",
  [2] = "OnlineComa",
  [3] = "OnlineDefault",
  [4] = "OnlineEscape"
}
onlineMoodsDowntownFog = {
  [1] = "OnlineBandit",
  [2] = "OnlineBlues",
  [3] = "OnlineBullitt",
  [4] = "OnlineComa",
  [5] = "OnlineDefault",
  [6] = "OnlineEscape",
  [7] = "OnlineFog",
  [8] = "OnlineLAConnection",
  [9] = "OnlineWhiteStripe"
}
onlineMoodsSuburbs1 = {
  [1] = "OnlineBandit",
  [2] = "OnlineBlues",
  [3] = "OnlineComa",
  [4] = "OnlineDukes",
  [5] = "OnlineWhiteStripe"
}
onlineMoodsSuburbs2 = {
  [1] = "OnlineBullitt",
  [2] = "OnlineCannonBall",
  [3] = "OnlineDefault",
  [4] = "OnlineEscape",
  [5] = "OnlineVanishing"
}
onlineMoodsSuburbFog = {
  [1] = "OnlineBandit",
  [2] = "OnlineBlues",
  [3] = "OnlineBullitt",
  [4] = "OnlineCannonBall",
  [5] = "OnlineComa",
  [6] = "OnlineDefault",
  [7] = "OnlineDukes",
  [8] = "OnlineEscape",
  [9] = "OnlineFog",
  [10] = "OnlineVanishing",
  [11] = "OnlineWhiteStripe"
}
onlineMoodsNatural1 = {
  [1] = "OnlineBandit",
  [2] = "OnlineCannonBall",
  [3] = "OnlineComa",
  [4] = "OnlineDukes",
  [5] = "OnlineVanishing"
}
onlineMoodsNatural2 = {
  [1] = "OnlineBandit",
  [2] = "OnlineCannonBall",
  [3] = "OnlineDefault",
  [4] = "OnlineDukes",
  [5] = "OnlineLAConnection"
}
onlineMoodsNaturalFog = {
  [1] = "OnlineBandit",
  [2] = "OnlineBandit",
  [3] = "OnlineCannonBall",
  [4] = "OnlineComa",
  [5] = "OnlineDefault",
  [6] = "OnlineDefault",
  [7] = "OnlineDukes",
  [8] = "OnlineDukes",
  [9] = "OnlineFog",
  [10] = "OnlineLAConnection",
  [11] = "OnlineVanishing"
}
onlineMoodsMarin = {
  [1] = "OnlineComa",
  [2] = "OnlineDefault"
}
onlineMoodsFreeway = {
  [1] = "OnlineBelViaggio",
  [2] = "OnlineBullitt",
  [3] = "OnlineComa",
  [4] = "OnlineDefault",
  [5] = "OnlineLAConnection",
  [6] = "OnlineTheDriver"
}
onlineMoodsCoastal = {
  [1] = "OnlineBandit",
  [2] = "OnlineBullitt",
  [3] = "OnlineCannonBall"
}
onlineMoodsCoastalFog = {
  [1] = "OnlineBandit",
  [2] = "OnlineBandit",
  [3] = "OnlineBullitt",
  [4] = "OnlineBullitt",
  [5] = "OnlineCannonBall",
  [6] = "OnlineCannonBall",
  [7] = "OnlineFog"
}
onlineMoodsTakedown1 = {
  [1] = "OnlineBlues",
  [2] = "OnlineBullitt",
  [3] = "OnlineComa",
  [4] = "OnlineDefault",
  [5] = "OnlineJerichoLite",
  [6] = "OnlineLAConnection"
}
onlineMoodsTakedown2 = {
  [1] = "OnlineBlues",
  [2] = "OnlineBullitt",
  [3] = "OnlineCannonBall",
  [4] = "OnlineDefault",
  [5] = "OnlineDukes",
  [6] = "OnlineVanishing"
}
onlineMoodsTakedown3 = {
  [1] = "OnlineBlues",
  [2] = "OnlineBlues",
  [3] = "OnlineBullitt",
  [4] = "OnlineComa",
  [5] = "OnlineDefault",
  [6] = "OnlineDefault",
  [7] = "OnlineDefault",
  [8] = "OnlineFog"
}
onlineMoodsQualifying = {
  [1] = "OnlineDefault"
}
onlineMoodsBlitz = {
  [1] = "OnlineDefault"
}
