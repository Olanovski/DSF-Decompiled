module("vehicleManager")
collisionResilience = {
  ["Unstoppable"] = {
    seriousCollisionThresholdSmall = 0.5,
    seriousCollisionThresholdLarge = 25,
    loseControlTimeMinSmall = 0.01,
    loseControlTimeMaxSmall = 0.02,
    loseControlTimeMinLarge = 0.02,
    loseControlTimeMaxLarge = 0.03,
    emergencySteerAntiRearSlipSmall = 0.02,
    emergencySteerAntiRearSlipLarge = 0.05,
    emergencyReflexTimeSmall = 0.01,
    emergencyReflexTimeLarge = 0.02,
    emergencyLateralVelocityStableSmall = 10,
    emergencyLateralVelocityStableLarge = 10
  },
  ["Very tough"] = {
    seriousCollisionThresholdSmall = 0.5,
    seriousCollisionThresholdLarge = 20,
    loseControlTimeMinSmall = 0.03,
    loseControlTimeMaxSmall = 0.05,
    loseControlTimeMinLarge = 0.05,
    loseControlTimeMaxLarge = 0.08,
    emergencySteerAntiRearSlipSmall = 0.1,
    emergencySteerAntiRearSlipLarge = 0.3,
    emergencyReflexTimeSmall = 0.03,
    emergencyReflexTimeLarge = 0.05,
    emergencyLateralVelocityStableSmall = 0.6,
    emergencyLateralVelocityStableLarge = 0.3
  },
  ["Tough"] = {
    seriousCollisionThresholdSmall = 0.5,
    seriousCollisionThresholdLarge = 15,
    loseControlTimeMinSmall = 0.1,
    loseControlTimeMaxSmall = 0.15,
    loseControlTimeMinLarge = 0.15,
    loseControlTimeMaxLarge = 0.3,
    emergencySteerAntiRearSlipSmall = 0.4,
    emergencySteerAntiRearSlipLarge = 0.8,
    emergencyReflexTimeSmall = 0.05,
    emergencyReflexTimeLarge = 0.05,
    emergencyLateralVelocityStableSmall = 0.4,
    emergencyLateralVelocityStableLarge = 0.2
  },
  ["Average"] = {
    seriousCollisionThresholdSmall = 0.5,
    seriousCollisionThresholdLarge = 10,
    loseControlTimeMinSmall = 0.15,
    loseControlTimeMaxSmall = 0.2,
    loseControlTimeMinLarge = 0.2,
    loseControlTimeMaxLarge = 0.4,
    emergencySteerAntiRearSlipSmall = 0.25,
    emergencySteerAntiRearSlipLarge = 1,
    emergencyReflexTimeSmall = 0.05,
    emergencyReflexTimeLarge = 0.05,
    emergencyLateralVelocityStableSmall = 0,
    emergencyLateralVelocityStableLarge = 0
  },
  ["Weak"] = {
    seriousCollisionThresholdSmall = 0.5,
    seriousCollisionThresholdLarge = 5,
    loseControlTimeMinSmall = 0.2,
    loseControlTimeMaxSmall = 0.3,
    loseControlTimeMinLarge = 0.3,
    loseControlTimeMaxLarge = 0.4,
    emergencySteerAntiRearSlipSmall = 0.5,
    emergencySteerAntiRearSlipLarge = 1,
    emergencyReflexTimeSmall = 0.05,
    emergencyReflexTimeLarge = 0.05,
    emergencyLateralVelocityStableSmall = 0,
    emergencyLateralVelocityStableLarge = 0
  }
}
drivingSkill = {
  ["Reckless"] = {
    corneringAccuracy = 0.5,
    vehicleExtentsEnlargeLength = 0.5,
    vehicleInfluenceAreaLength = 0.5,
    stickToDesiredSpeed = 1,
    reckless = true
  },
  ["Professional"] = {
    corneringAccuracy = 0.5,
    vehicleExtentsEnlargeLength = 0.5,
    vehicleInfluenceAreaLength = 0.5,
    stickToDesiredSpeed = 0.85
  },
  ["Average"] = {
    corneringAccuracy = 0.5,
    vehicleExtentsEnlargeLength = 0.5,
    vehicleInfluenceAreaLength = 0.5,
    stickToDesiredSpeed = 0.8
  },
  ["Cautious"] = {
    corneringAccuracy = 0.5,
    vehicleExtentsEnlargeLength = 0.75,
    vehicleInfluenceAreaLength = 0.5,
    stickToDesiredSpeed = 0.7
  },
  ["Over-cautious"] = {
    corneringAccuracy = 0.4,
    vehicleExtentsEnlargeLength = 0.8,
    vehicleInfluenceAreaLength = 0.5,
    stickToDesiredSpeed = 0.6
  },
  ["Frozen-Ambulance"] = {
    corneringAccuracy = 0,
    vehicleExtentsEnlargeLength = 0.4,
    vehicleInfluenceAreaLength = 0.5,
    stickToDesiredSpeed = 1
  }
}
rubberbandingStrength = {
  Unshakable = {rubberBandGroupStrength = 1, rubberBandGroupFollowRange = 40},
  High = {rubberBandGroupStrength = 0.75, rubberBandGroupFollowRange = 30},
  Average = {rubberBandGroupStrength = 0.5, rubberBandGroupFollowRange = 60},
  Low = {rubberBandGroupStrength = 0.25, rubberBandGroupFollowRange = 75},
  None = {rubberBandGroupStrength = 0, rubberBandGroupFollowRange = 0}
}
rubberbandingToPlayerStrength = {
  Strong = {
    rubberBandPlayerStrength = 0.9,
    rubberBandPlayerFollowRange = 30,
    rubberBandCatchupPerformanceTweak = 0.2
  },
  Medium = {
    rubberBandPlayerStrength = 0.8,
    rubberBandPlayerFollowRange = 40,
    rubberBandCatchupPerformanceTweak = 0.1
  },
  Weak = {
    rubberBandPlayerStrength = 0.6,
    rubberBandPlayerFollowRange = 75,
    rubberBandCatchupPerformanceTweak = 0.05
  },
  Weaker = {
    rubberBandPlayerStrength = 0.4,
    rubberBandPlayerFollowRange = 75,
    rubberBandCatchupPerformanceTweak = 0
  },
  VeryWeak = {
    rubberBandPlayerStrength = 0.2,
    rubberBandPlayerFollowRange = 75,
    rubberBandCatchupPerformanceTweak = 0
  },
  None = {
    rubberBandPlayerStrength = 0,
    rubberBandPlayerFollowRange = 0,
    rubberBandCatchupPerformanceTweak = 0
  }
}
groupAggression = {
  Relentless = {
    groupTakeDownTimeBetweenAttacks = 0.01,
    groupTakeDownFollowDistanceforNonAttackers = 0,
    groupTakeDownMaxAttackersAtOnceFollowing = 100,
    groupTakeDownMaxAttackersAtOnceIntercepting = 100,
    groupTakeDownMaxAttackersAtOnceStationary = 100,
    groupTakeDownPerformanceBoost = 1
  },
  Evil = {
    groupTakeDownTimeBetweenAttacks = 0.01,
    groupTakeDownFollowDistanceforNonAttackers = 0,
    groupTakeDownMaxAttackersAtOnceFollowing = 3,
    groupTakeDownMaxAttackersAtOnceIntercepting = 10,
    groupTakeDownMaxAttackersAtOnceStationary = 4,
    groupTakeDownPerformanceBoost = 1
  },
  High = {
    groupTakeDownTimeBetweenAttacks = 5,
    groupTakeDownFollowDistanceforNonAttackers = 0,
    groupTakeDownMaxAttackersAtOnceFollowing = 2,
    groupTakeDownMaxAttackersAtOnceIntercepting = 5,
    groupTakeDownMaxAttackersAtOnceStationary = 3,
    groupTakeDownPerformanceBoost = 0.3
  },
  Average = {
    groupTakeDownTimeBetweenAttacks = 10,
    groupTakeDownFollowDistanceforNonAttackers = 0,
    groupTakeDownMaxAttackersAtOnceFollowing = 1,
    groupTakeDownMaxAttackersAtOnceIntercepting = 1,
    groupTakeDownMaxAttackersAtOnceStationary = 3,
    groupTakeDownPerformanceBoost = 0.2
  },
  Low = {
    groupTakeDownTimeBetweenAttacks = 20,
    groupTakeDownFollowDistanceforNonAttackers = 5,
    groupTakeDownMaxAttackersAtOnceFollowing = 1,
    groupTakeDownMaxAttackersAtOnceIntercepting = 1,
    groupTakeDownMaxAttackersAtOnceStationary = 10,
    groupTakeDownPerformanceBoost = 0
  },
  DejaVu = {
    groupTakeDownTimeBetweenAttacks = 1,
    groupTakeDownFollowDistanceforNonAttackers = 1,
    groupTakeDownMaxAttackersAtOnceFollowing = 4,
    groupTakeDownMaxAttackersAtOnceIntercepting = 4,
    groupTakeDownMaxAttackersAtOnceStationary = 0,
    groupTakeDownPerformanceBoost = 1
  }
}
reactionTime = {
  Fastest = {minReactionTime = 0.3},
  Fast = {minReactionTime = 0.5},
  Average = {minReactionTime = 0.7},
  Slow = {minReactionTime = 1.5},
  None = {minReactionTime = 0}
}
