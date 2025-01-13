module("zap.settings", package.seeall)
function initialise(localID)
  CityLockManager.MaxDistanceAllowedOutsideOfArea = 100
  for k, v in next, missile, nil do
    zapcontroller[k](v, localID)
  end
  ZapAIPresence.Settings(ZapPresenceSettings)
end
topLevelZapPositions = {
  ["Install\\san_francisco.dngc"] = {
    lookFrom = vec.vector(1000, 7500, 2500, 1),
    lookAt = vec.vector(500, 0, 100, 1)
  },
  ["Install\\san_francisco_road_network.dngc"] = {
    lookFrom = vec.vector(1500, 6500, 4250, 1),
    lookAt = vec.vector(750, 0, 1950, 1)
  }
}
levelData = {
  [0] = {
    radii = {
      missile = 0,
      low = 0,
      mid = 0,
      high = 0
    },
    locked = {
      missile = true,
      low = true,
      mid = true,
      high = true,
      top = true
    }
  },
  [1] = {
    radii = {
      missile = 150,
      low = 150,
      mid = 150,
      high = 150
    },
    locked = {
      missile = false,
      low = true,
      mid = true,
      high = true,
      top = true
    }
  },
  [2] = {
    mood = "TopZap2",
    radii = {
      missile = 300,
      low = 300,
      mid = 300,
      high = 300
    },
    locked = {
      missile = false,
      low = true,
      mid = true,
      high = true,
      top = true
    }
  },
  [3] = {
    mood = "TopZap3",
    radii = {
      missile = 900,
      low = 900,
      mid = 900,
      high = 900
    },
    locked = {
      missile = false,
      low = true,
      mid = false,
      high = true,
      top = true
    }
  },
  [4] = {
    mood = "TopZap4",
    radii = {
      missile = 1800,
      low = 1800,
      mid = 1800,
      high = 1800
    },
    locked = {
      missile = false,
      low = true,
      mid = false,
      high = false,
      top = true
    }
  },
  [5] = {
    mood = "TopZap4",
    radii = {
      missile = 2000,
      low = 2000,
      mid = 2000,
      high = 2000
    },
    locked = {
      missile = false,
      low = true,
      mid = false,
      high = false,
      top = false
    }
  }
}
heightData = {
  [1] = {mood = "Zap", sky_scale = 85},
  [2] = {mood = "TopZap1", sky_scale = 85},
  [3] = {mood = "TopZap2", sky_scale = 100},
  [4] = {mood = "TopZap3", sky_scale = 150},
  [5] = {mood = "TopZap4", sky_scale = 150}
}
missile = {
  SetZapFlareZoomStart = 0.78,
  SetZapFlareZoomRange = 0.08,
  SetZapFlareBrightness = 0.4,
  SetZapFlareMaskScrollU = 0,
  SetZapFlareMaskScrollV = 15,
  SetZapSelectionRadius = 8,
  SetZapSelectionReleaseRadius = 16,
  SetZapSelectionRadiusHigherZap = 14,
  SetZapSelectionReleaseRadiusHigherZap = 20,
  SetZapSelectionRadiusMajor = 0.9,
  SetZapSelectionRadiusMinor = 0.4,
  SetZapSelectionHeightOffset = -0.35,
  SetZapSelectionMissileZapScale = 1.2,
  SetZapSelectionAerialLowScale = 1.4,
  SetZapSelectionAerialMidScale = 2.5
}
spZapSettings = {
  zapOutCost = {
    {range = 0, amount = 0}
  },
  zapAbilityRegen = {
    {
      range = 0,
      amount = 7,
      primerSecs = 0.5,
      abilityPrimerSecs = 0
    },
    {
      range = 15,
      amount = 9,
      primerSecs = 0,
      abilityPrimerSecs = 0
    },
    {
      range = 100,
      amount = 11,
      primerSecs = 0,
      abilityPrimerSecs = 0
    }
  },
  zapAbilityDegen = {
    {
      range = 0,
      amount = 0,
      primerSecs = 0
    }
  }
}
zapButtonPrompts = {
  [1] = {
    [1] = infMoveHighlight,
    [2] = infSelect,
    [3] = infZapUp
  },
  [2] = {
    [1] = infMoveHighlight,
    [2] = infSelect,
    [3] = infZapDown,
    [4] = infZapUp
  },
  [3] = {
    [1] = infMoveHighlight,
    [2] = infSelect,
    [3] = infZapDown,
    [4] = infZapUp
  },
  [4] = {
    [1] = infMoveHighlight,
    [2] = infZapDown,
    [3] = infZapUp
  },
  [5] = {
    [1] = infMoveHighlight,
    [2] = infZapDown
  },
  [6] = {
    [1] = infMoveHighlight,
    [2] = infSelect
  },
  [7] = {
    [1] = infMoveHighlight,
    [2] = infSelect,
    [3] = infZapDown
  },
  [8] = {
    [1] = infMoveHighlight,
    [2] = infZapDown
  }
}
ZapPresenceSettings = {
  TransitionOutTime = 0.17,
  TransitionInTime = 0.4,
  TransitionOutStartTime = 0.14,
  Radius = 0.5,
  Height = 100,
  Color = vec.vector(40, 40, 40, 0.2),
  Offset = vec.vector(0, 0, 0, 0)
}
