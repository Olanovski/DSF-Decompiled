local copCars = {
  267,
  271,
  280,
  269,
  265
}
local trucks = {
  186,
  152,
  185,
  284,
  285,
  286,
  298,
  118,
  180,
  181,
  199,
  252,
  251,
  156,
  287,
  288,
  26,
  197
}
local taxis = {
  268,
  270,
  272,
  282
}
local tankers = {131, 291}
dareLookupTable = {
  stunt = {
    [1] = {
      [301] = {
        params = {distance = 30},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare distance travelled in air",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:183866",
        hint = "ID:183866",
        position = vec.vector(-131.6605, 50.97536, 616.942, 1),
        heading = 0.4109604,
        iconType = "dareStunt",
        allowJumpSound = true
      },
      [302] = {
        params = {distance = 150, time = 45},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Dare distance jumped in time",
              params = {timer = "time", value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:183862",
        hint = "ID:183862",
        position = vec.vector(-800.5936, 37.49043, 733.8923, 1),
        heading = 2.576994,
        iconType = "dareStunt",
        timer = "time",
        allowJumpSound = true
      },
      [303] = {
        params = {quantity = 3, time = 45},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Player has jumped off a vehicle",
              params = {
                value = "quantity",
                modelID = {298},
                time = "time",
                highlight = true,
                vehicleID = {298},
                centralFeedback = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183864",
        hint = "ID:183864",
        position = vec.vector(756.0925, 6.981713, -42.81136, 1),
        heading = 1.723728,
        iconType = "dareStunt",
        timer = "time",
        allowJumpSound = true
      },
      [403] = {
        params = {distance = 30},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {promptType = "Thrillcam"}
            },
            {
              goal = "Is player camera",
              params = {value = "ThrillCam", showTutorial = true}
            },
            {
              goal = "Dare distance travelled in drift",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:248618",
        hint = "ID:248618",
        position = vec.vector(-514.3379, 76.55372, 2605.157, 1),
        heading = 0.5353553,
        iconType = "dareStunt",
        allowDriftSound = true
      },
      [203] = {
        params = {distance = 80},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player above speed",
              params = {value = 5}
            },
            {
              goal = "Is jumping",
              params = {inverse = true}
            },
            {
              goal = "Button being held",
              params = {
                button = "Vehicle_Accelerate",
                inverse = true
              }
            },
            {
              goal = "Button being held",
              params = {
                button = "Vehicle_HandBrake"
              }
            },
            {
              goal = "Player driven X metres",
              params = {
                value = "distance",
                feedbackDistance = true,
                button = "Vehicle_HandBrake"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183888",
        hint = "ID:183888",
        position = vec.vector(435.9229, 27.46315, 2665.944, 1),
        heading = -0.02650802,
        iconType = "dareStunt"
      }
    },
    [2] = {
      [405] = {
        params = {distance = 30},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {promptType = "Thrillcam"}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player camera",
              params = {value = "ThrillCam", showTutorial = true}
            },
            {
              goal = "Dare distance travelled in air",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:248619",
        hint = "ID:248619",
        position = vec.vector(-2651.73, 2.480305, -285.562, 1),
        heading = -1.587311,
        iconType = "dareStunt",
        allowJumpSound = true
      },
      [305] = {
        params = {quantity = 4, time = 60},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {promptType = "Car type", requiresTransporter = true}
            },
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Player has jumped off a vehicle",
              params = {
                value = "quantity",
                modelID = {298},
                highlight = true,
                vehicleID = {298},
                timer = "time",
                centralFeedback = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183864",
        hint = "ID:183864",
        position = vec.vector(-3398.417, 46.86267, 1881.708, 1),
        heading = -1.832952,
        iconType = "dareStunt",
        timer = "time",
        allowJumpSound = true
      },
      [306] = {
        params = {quantity = 100, time = 30},
        goals = {
          {
            {
              goal = "willpower collection",
              params = {value = "quantity", timer = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:183865",
        hint = "ID:183865",
        position = vec.vector(-4417.72, 21.21257, 2501.6, 1),
        heading = -3.101882,
        iconType = "dareStunt",
        timer = "time",
        noCops = true,
        allowJumpSound = true,
        allowDriftSound = true
      },
      [104] = {
        params = {distance = 40},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare distance travelled in air",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:183866",
        hint = "ID:183866",
        position = vec.vector(-3891.3, 27.7, 2553.6, 1),
        heading = 0.5732664,
        iconType = "dareStunt",
        allowJumpSound = true
      },
      [304] = {
        params = {distance = 35},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {
                promptType = "Car type",
                carModel = taxis,
                vehType = "Taxi"
              }
            },
            {
              goal = "Dare is player in vehicle model",
              params = {
                value = taxis,
                highlight = true,
                vehicleID = taxis
              }
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare distance travelled in air",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:182729",
        hint = "ID:182729",
        position = vec.vector(-1925.977, 24.10637, 487.238, 1),
        heading = 2.552228,
        iconType = "dareStunt",
        allowJumpSound = true
      },
      [106] = {
        params = {quantity = 5, time = 30},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Tag x number of y vehicle",
              params = {
                value = "quantity",
                vehicleID = taxis,
                timer = "time",
                highlight = true,
                centralFeedback = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:182730",
        hint = "ID:182730",
        position = vec.vector(-1153.601, 43.86417, 1006.313, 1),
        heading = 0.1263841,
        iconType = "dareStunt",
        timer = "time"
      },
      [105] = {
        params = {quantity = 30, time = 40},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Dare number of props smashed",
              params = {
                value = "quantity",
                timer = "time",
                highlightTargets = false
              },
              feedback = true
            }
          }
        },
        objective = "ID:182748",
        hint = "ID:182748",
        position = vec.vector(-3885.188, 37.49681, 1610.495, 1),
        heading = -0.5661388,
        iconType = "dareStunt",
        timer = "time"
      },
      [406] = {
        params = {distance = 40},
        goals = {
          {
            {
              goal = "Is player camera",
              params = {
                value = "firstPersonCamera",
                showTutorial = true
              }
            },
            {
              goal = "Dare distance travelled in drift",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:183892",
        hint = "ID:183892",
        position = vec.vector(-1521.982, 65.8918, 1765.935, 1),
        heading = -2.498588,
        iconType = "dareStunt",
        allowDriftSound = true
      }
    },
    [3] = {
      [307] = {
        params = {quantity = 4, time = 60},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {
                promptType = "Car type",
                carModel = taxis,
                vehType = "Taxi",
                requiresTransporter = true
              }
            },
            {
              goal = "Player in x vehicle and jumped off y vehicle z times",
              params = {
                value = "quantity",
                timer = "time",
                highlight = true,
                vehicleID = {298},
                inVehicleID = taxis,
                centralFeedback = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183867",
        hint = "ID:183867",
        position = vec.vector(1438.985, 7.961743, 2305.671, 1),
        heading = -0.1772484,
        iconType = "dareStunt",
        timer = "time",
        allowJumpSound = true
      },
      [207] = {
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player jumped over a vehicle",
              params = {centralFeedback = true}
            }
          }
        },
        objective = "ID:183868",
        hint = "ID:183868",
        position = vec.vector(-2995.268, 60.21375, 2405.77, 1),
        heading = 0.0130105,
        iconType = "dareStunt",
        allowJumpSound = true
      },
      [309] = {
        params = {quantity = 200, time = 30},
        goals = {
          {
            {
              goal = "willpower collection",
              params = {value = "quantity", timer = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:183865",
        hint = "ID:183865",
        position = vec.vector(751.6795, 5.958748, 1016.52, 1),
        heading = 2.701937,
        iconType = "dareStunt",
        timer = "time",
        noCops = true,
        allowJumpSound = true,
        allowDriftSound = true
      },
      [308] = {
        params = {distance = 50},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player camera",
              params = {
                value = "firstPersonCamera",
                showTutorial = true
              }
            },
            {
              goal = "Dare distance travelled in air",
              params = {
                value = "distance",
                inCameraMode = "firstPersonCamera"
              },
              feedback = true
            }
          }
        },
        objective = "ID:182734",
        hint = "ID:182734",
        position = vec.vector(-4137.192, 35.49788, 3042.122, 1),
        heading = -0.2196898,
        iconType = "dareStunt",
        allowJumpSound = true
      },
      [107] = {
        params = {quantity = 5, time = 30},
        goals = {
          {
            {
              goal = "Jump x times in y time",
              params = {
                value = "quantity",
                transition = "landing",
                centralFeedback = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:182733",
        hint = "ID:182733",
        position = vec.vector(-1115.6, 66.7, 2114.8, 1),
        heading = 1.521345,
        iconType = "dareStunt",
        timer = "time"
      },
      [407] = {
        params = {quantity = 15},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Dare number of props smashed",
              params = {
                value = "quantity",
                propData = {
                  name = "busStopGroup"
                },
                highlightTargets = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183831",
        hint = "ID:183831",
        position = vec.vector(-1134.568, 14.60004, 116.4821, 1),
        heading = -0.0730239,
        iconType = "dareStunt"
      },
      [408] = {
        params = {distance = 125},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player above speed",
              params = {value = 5}
            },
            {
              goal = "Is jumping",
              params = {inverse = true}
            },
            {
              goal = "Button being held",
              params = {
                button = "Vehicle_Accelerate",
                inverse = true
              }
            },
            {
              goal = "Button being held",
              params = {
                button = "Vehicle_HandBrake"
              }
            },
            {
              goal = "Player driven X metres",
              params = {
                value = "distance",
                feedbackDistance = true,
                button = "Vehicle_HandBrake"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183888",
        hint = "ID:183888",
        position = vec.vector(-3143.262, 27.0027, 244.451, 1),
        heading = -1.79859,
        iconType = "dareStunt"
      },
      [409] = {
        params = {distance = 50},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare distance travelled in drift",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:183887",
        hint = "ID:183887",
        position = vec.vector(-3001.541, 57.31853, 2204.793, 1),
        heading = 0.01841107,
        iconType = "dareStunt",
        allowDriftSound = true
      }
    },
    [4] = {
      [312] = {
        params = {distance = 60},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare distance travelled in air",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:183866",
        hint = "ID:183866",
        position = vec.vector(-3472.204, 80.5332, 3021.21, 1),
        heading = 1.188969,
        iconType = "dareStunt",
        allowJumpSound = true
      },
      [112] = {
        params = {distance = 300, time = 60},
        goals = {
          {
            {
              goal = "Dare same vehicle"
            },
            {
              goal = "Dare distance jumped in time",
              params = {timer = "time", value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:183871",
        hint = "ID:183871",
        position = vec.vector(-4424.337, 21.22251, 3130.716, 1),
        heading = -3.136337,
        iconType = "dareStunt",
        timer = "time",
        allowJumpSound = true
      },
      [311] = {
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player camera",
              params = {
                value = "firstPersonCamera",
                showTutorial = true
              }
            },
            {
              goal = "Player jumped over a vehicle",
              params = {
                inCameraMode = "firstPersonCamera",
                centralFeedback = true
              }
            }
          }
        },
        objective = "ID:183872",
        hint = "ID:183872",
        position = vec.vector(75.03753, 21.51743, 4140.878, 1),
        heading = -2.098674,
        iconType = "dareStunt",
        allowJumpSound = true
      },
      [110] = {
        params = {quantity = 500, time = 60},
        goals = {
          {
            {
              goal = "willpower collection",
              params = {value = "quantity", timer = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:183865",
        hint = "ID:183865",
        position = vec.vector(1033.939, 8.253898, 3457.916, 1),
        heading = -0.03851114,
        iconType = "dareStunt",
        timer = "time",
        noCops = true,
        allowJumpSound = true,
        allowDriftSound = true
      },
      [310] = {
        params = {quantity = 60, time = 60},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Dare number of props smashed",
              params = {
                value = "quantity",
                timer = "time",
                highlightTargets = false
              },
              feedback = true
            }
          }
        },
        objective = "ID:182748",
        hint = "ID:182748",
        position = vec.vector(-790.6644, 79.70192, 2680.32, 1),
        heading = 2.76608,
        iconType = "dareStunt",
        timer = "time"
      },
      [411] = {
        params = {quantity = 5},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Drive x vehicles under a trailer",
              params = {
                value = "quantity",
                highlight = true,
                vehicleID = {123},
                centralFeedback = true,
                markerArrows = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183893",
        hint = "ID:183893",
        position = vec.vector(120.5622, 36.09947, 3052.139, 1),
        heading = -2.072279,
        iconType = "dareStunt"
      },
      [410] = {
        params = {distance = 70},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare distance travelled in drift",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:183887",
        hint = "ID:183887",
        position = vec.vector(-1860.094, 184.8468, 4207.349, 1),
        heading = 0.8360006,
        iconType = "dareStunt",
        allowDriftSound = true
      }
    },
    [5] = {
      [313] = {
        params = {quantity = 700, time = 60},
        goals = {
          {
            {
              goal = "willpower collection",
              params = {value = "quantity", timer = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:183865",
        hint = "ID:183865",
        position = vec.vector(-1127.45, 24.51683, -2956.163, 1),
        heading = 0.8675674,
        iconType = "dareStunt",
        timer = "time",
        noCops = true,
        allowJumpSound = true,
        allowDriftSound = true
      },
      [314] = {
        params = {quantity = 6, time = 60},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {promptType = "Car type", requiresTransporter = true}
            },
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Player has jumped off a vehicle",
              params = {
                value = "quantity",
                modelID = {298},
                timer = "time",
                highlight = true,
                vehicleID = {298},
                centralFeedback = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183874",
        hint = "ID:183874",
        position = vec.vector(758.4858, 17.71631, -3163.923, 1),
        heading = -1.632502,
        iconType = "dareStunt",
        timer = "time",
        allowJumpSound = true
      },
      [115] = {
        params = {distance = 70},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare distance travelled in air",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:183866",
        hint = "ID:183866",
        position = vec.vector(-2160.573, 67.42891, -2772.178, 1),
        heading = 2.768905,
        iconType = "dareStunt",
        allowJumpSound = true
      },
      [315] = {
        params = {quantity = 30, time = 60},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Tag x number of y vehicle",
              params = {
                value = "quantity",
                timer = "time",
                centralFeedback = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183833",
        hint = "ID:183833",
        position = vec.vector(-3432.474, 48.00714, -2065.751, 1),
        heading = -0.5613431,
        iconType = "dareStunt",
        timer = "time"
      },
      [113] = {
        params = {quantity = 250},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Dare number of props smashed",
              params = {
                value = "quantity",
                inCameraMode = "firstPersonCamera"
              },
              feedback = true
            }
          }
        },
        objective = "ID:248720",
        hint = "ID:248720",
        position = vec.vector(-3293.2, 182.6, -3706.1, 1),
        heading = 2.396156,
        iconType = "dareStunt"
      },
      [415] = {
        params = {distance = 100},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare distance travelled in drift",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:183887",
        hint = "ID:183887",
        position = vec.vector(-2739.357, 75.49294, -2615.859, 1),
        heading = 2.79227,
        iconType = "dareStunt",
        allowDriftSound = true
      },
      [413] = {
        params = {distance = 200},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player above speed",
              params = {value = 5}
            },
            {
              goal = "Is jumping",
              params = {inverse = true}
            },
            {
              goal = "Button being held",
              params = {
                button = "Vehicle_Accelerate",
                inverse = true
              }
            },
            {
              goal = "Button being held",
              params = {
                button = "Vehicle_HandBrake"
              }
            },
            {
              goal = "Player driven X metres",
              params = {
                value = "distance",
                feedbackDistance = true,
                button = "Vehicle_HandBrake"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183888",
        hint = "ID:183888",
        position = vec.vector(-1440.606, 7.767979, -2520.043, 1),
        heading = -1.752207,
        iconType = "dareStunt"
      },
      [414] = {
        params = {distance = 80},
        goals = {
          {
            {
              goal = "Dare is player in vehicle model",
              params = {
                value = tankers,
                highlight = true,
                vehicleID = tankers,
                allowZap = true
              }
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare distance travelled in drift",
              params = {
                value = "distance",
                highlight = true,
                requiredModel = tankers
              },
              feedback = true
            }
          }
        },
        objective = "ID:183898",
        hint = "ID:183898",
        position = vec.vector(-403.3712, 62.19909, -4433.112, 1),
        heading = -0.9319549,
        iconType = "dareStunt",
        allowDriftSound = true
      },
      [114] = {
        params = {time = 10},
        goals = {
          {
            {
              goal = "Dare highlight vehicle",
              params = {
                highlightList = {298}
              }
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player riding a vehicle",
              params = {
                value = "time",
                modelID = {298}
              },
              feedback = true
            }
          }
        },
        objective = "ID:183899",
        hint = "ID:183899",
        position = vec.vector(2228.759, 27.75019, -3950.309, 1),
        heading = -0.01250362,
        iconType = "dareStunt",
        timer = "time",
        timerComplete = true
      }
    },
    [6] = {
      [316] = {
        params = {distance = 80},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player camera",
              params = {
                value = "firstPersonCamera",
                showTutorial = true
              }
            },
            {
              goal = "Dare distance travelled in air",
              params = {
                value = "distance",
                inCameraMode = "firstPersonCamera"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183861",
        hint = "ID:183861",
        position = vec.vector(-53.46528, 19.9882, -45.61327, 1),
        heading = 1.747615,
        iconType = "dareStunt",
        allowJumpSound = true
      },
      [317] = {
        params = {quantity = 1000, time = 60},
        goals = {
          {
            {
              goal = "willpower collection",
              params = {value = "quantity", timer = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:183865",
        hint = "ID:183865",
        position = vec.vector(-935.9783, 52.10506, -4103.848, 1),
        heading = -0.3422109,
        iconType = "dareStunt",
        timer = "time",
        noCops = true,
        allowJumpSound = true,
        allowDriftSound = true
      },
      [318] = {
        params = {quantity = 60, time = 60},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Dare number of props smashed",
              params = {
                value = "quantity",
                timer = "time",
                onlyAlleyProps = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183834",
        hint = "ID:183834",
        position = vec.vector(-1264.896, 47.25473, 1193.593, 1),
        heading = -2.994277,
        iconType = "dareStunt",
        timer = "time"
      },
      [116] = {
        params = {quantity = 20, time = 60},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {
                promptType = "Car type",
                carModel = {285, 286},
                vehType = "Big rig"
              }
            },
            {
              goal = "Dare is player in vehicle model",
              params = {
                value = {285, 286},
                highlight = true,
                vehicleID = {285, 286},
                allowZap = true
              }
            },
            {
              goal = "Tag x number of y vehicle",
              params = {
                value = "quantity",
                timer = "time",
                centralFeedback = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183838",
        hint = "ID:183838",
        position = vec.vector(-1705.036, 148.6662, -3944.235, 1),
        heading = 3.034919,
        iconType = "dareStunt",
        timer = "time"
      },
      [417] = {
        params = {quantity = 10, time = 60},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Drive x vehicles under a trailer",
              params = {
                timer = "time",
                value = "quantity",
                highlight = true,
                vehicleID = {123},
                centralFeedback = true,
                markerArrows = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183835",
        hint = "ID:183835",
        position = vec.vector(494.9428, 34.25424, -3917.447, 1),
        heading = 0.5298509,
        iconType = "dareStunt",
        timer = "time"
      },
      [418] = {
        params = {time = 20},
        goals = {
          {
            {
              goal = "Dare highlight vehicle",
              params = {
                highlightList = {298}
              }
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player riding a vehicle",
              params = {
                value = "time",
                modelID = {298}
              },
              feedback = true
            }
          }
        },
        objective = "ID:183899",
        hint = "ID:183899",
        position = vec.vector(-858.4748, 4.995284, -107.319, 1),
        heading = 1.362546,
        iconType = "dareStunt",
        timer = "time",
        timerComplete = true
      }
    },
    [7] = {
      [320] = {
        params = {quantity = 3, time = 45},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Player jumped over a vehicle",
              params = {
                value = "quantity",
                timer = "time",
                centralFeedback = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183878",
        hint = "ID:183878",
        position = vec.vector(813.9, 30, -3628.4, 1),
        heading = -1.362446,
        iconType = "dareStunt",
        timer = "time",
        allowJumpSound = true
      },
      [120] = {
        params = {quantity = 1500, time = 60},
        goals = {
          {
            {
              goal = "willpower collection",
              params = {value = "quantity", timer = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:183865",
        hint = "ID:183865",
        position = vec.vector(263.1, 68.7, 269.8, 1),
        heading = -1.84557,
        iconType = "dareStunt",
        timer = "time",
        noCops = true,
        allowJumpSound = true,
        allowDriftSound = true
      },
      [319] = {
        params = {distance = 150},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare distance travelled in air",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:183866",
        hint = "ID:183866",
        position = vec.vector(853.2, 8.2, 2886.9, 1),
        heading = 2.257297,
        iconType = "dareStunt",
        allowJumpSound = true
      },
      [119] = {
        params = {quantity = 200, time = 60},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Dare number of props smashed",
              params = {
                value = "quantity",
                timer = "time",
                highlightTargets = false
              },
              feedback = true
            }
          }
        },
        objective = "ID:182748",
        hint = "ID:182748",
        position = vec.vector(962.9391, 5.104661, -2182.867, 1),
        heading = -2.093363,
        iconType = "dareStunt",
        timer = "time"
      },
      [419] = {
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player has barrel rolled"
            }
          }
        },
        objective = "ID:183903",
        hint = "ID:183903",
        position = vec.vector(1567.2, 30, -4370.2, 1),
        heading = -1.613694,
        iconType = "dareStunt"
      },
      [420] = {
        params = {distance = 200},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare distance travelled in drift",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:183887",
        hint = "ID:183887",
        position = vec.vector(-963.5461, 173.3017, 4234.131, 1),
        heading = 1.660544,
        iconType = "dareStunt",
        allowDriftSound = true
      }
    }
  },
  speed = {
    [0] = {
      [402] = {
        params = {distance = 800, time = 45},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare started driving"
            },
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Player hasn't had collision above x force (TEMP)",
              params = {force = 4000, typeOfHit = "Vehicle"}
            },
            {
              goal = "Player hasn't had collision above x force (TEMP)",
              params = {force = 4000, typeOfHit = "Static"}
            },
            {
              goal = "Player driven X metres",
              params = {value = "distance", timer = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:183886",
        hint = "ID:183886",
        position = vec.vector(-42.5105, 4.415333, -319.5985, 1),
        heading = -0.6098903,
        iconType = "dareSpeed",
        timer = "time"
      }
    },
    [1] = {
      [201] = {
        params = {speed = 140},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player camera",
              params = {
                value = "firstPersonCamera",
                showTutorial = true
              }
            },
            {
              goal = "Dare above speed feedback",
              params = {value = "speed"},
              feedback = true
            }
          }
        },
        objective = "ID:183849",
        hint = "ID:183849",
        position = vec.vector(1141.141, 6.051567, 694.0483, 1),
        heading = 1.002059,
        iconType = "dareSpeed"
      },
      [102] = {
        params = {speed = 60, time = 20},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Stay above x mph for y seconds",
              params = {
                speed = "speed",
                displayed = true,
                value = "time"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183840",
        hint = "ID:183840",
        position = vec.vector(-1097.896, 53.94656, 1462.522, 1),
        heading = 1.703307,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [101] = {
        params = {speed = 50, time = 20},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare above speed feedback",
              params = {value = "speed", oncoming = true}
            },
            {
              goal = "Forgiving against traffic flow",
              params = {value = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:182724",
        hint = "ID:182724",
        position = vec.vector(-1382.967, 34.20124, 331.0472, 1),
        heading = -2.157681,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [202] = {
        params = {quantity = 5, speed = 90},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Get x vehicles above y mph",
              params = {
                value = "quantity",
                speed = "speed",
                displayed = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:182726",
        hint = "ID:182726",
        position = vec.vector(-5.851867, 40.74535, 2115.25, 1),
        heading = -0.1396585,
        iconType = "dareSpeed"
      },
      [103] = {
        params = {time = 3},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {promptType = "Ability", abilityLevel = 0}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Player using nitro"
            },
            {
              goal = "Dare time trigger",
              params = {value = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:182727",
        hint = "ID:182727",
        position = vec.vector(1237.027, 5.968143, 1704.034, 1),
        heading = -0.9491904,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [401] = {
        params = {quantity = 15, time = 30},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Is player camera",
              params = {
                value = "firstPersonCamera",
                showTutorial = true
              }
            },
            {
              goal = "Dare overtakes in time",
              params = {timer = "time", value = "quantity"},
              feedback = true
            }
          }
        },
        objective = "ID:183885",
        hint = "ID:183885",
        position = vec.vector(-127.178, 40.82658, 1755.844, 1),
        heading = 0.4773759,
        iconType = "dareSpeed",
        timer = "time"
      }
    },
    [2] = {
      [205] = {
        params = {speed = 85},
        goals = {
          {
            {
              goal = "Dare is towing above x speed",
              params = {
                value = "speed",
                displayed = true,
                showSpeed = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183843",
        hint = "ID:183843",
        position = vec.vector(-2411.266, 35.04287, 446.0497, 1),
        heading = -2.587605,
        iconType = "dareSpeed"
      },
      [204] = {
        params = {speed = 70, time = 20},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {
                promptType = "Car type",
                carModel = {
                  167,
                  246,
                  201
                },
                vehType = "Bus"
              }
            },
            {
              goal = "Dare is player in vehicle model",
              params = {
                value = {
                  167,
                  246,
                  201
                },
                highlight = true,
                vehicleID = {
                  167,
                  246,
                  201
                }
              }
            },
            {
              goal = "Stay above x mph for y seconds",
              params = {
                speed = "speed",
                displayed = true,
                value = "time"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183844",
        hint = "ID:183844",
        position = vec.vector(-1813.118, 73.2595, 1994.68, 1),
        heading = 1.306646,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [206] = {
        params = {speed = 170},
        goals = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Prompt upgrade",
              params = {value = 170, promptType = "Faster"}
            },
            {
              goal = "Accelerated from startValue to value",
              params = {
                startValue = 0.1,
                value = "speed",
                displayed = true,
                showSpeed = true,
                noAbilities = true
              },
              feedback = true
            }
          }
        },
        objective = "ID:183842",
        hint = "ID:183842",
        position = vec.vector(-3794.117, 23.78943, 725.4775, 1),
        heading = 1.656667,
        iconType = "dareSpeed"
      },
      [404] = {
        params = {quantity = 25, time = 60},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Dare overtakes in time",
              params = {timer = "time", value = "quantity"},
              feedback = true
            }
          }
        },
        objective = "ID:183890",
        hint = "ID:183890",
        position = vec.vector(-2915.52, 59.28704, 1500.773, 1),
        heading = 1.176599,
        iconType = "dareSpeed",
        timer = "time"
      }
    },
    [3] = {
      [208] = {
        params = {speed = 95, time = 20},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player camera",
              params = {
                value = "firstPersonCamera",
                showTutorial = true
              }
            },
            {
              goal = "Stay above x mph for y seconds",
              params = {
                speed = "speed",
                displayed = true,
                value = "time"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183850",
        hint = "ID:183850",
        position = vec.vector(-3062.874, 66.33984, 968.9692, 1),
        heading = 1.811057,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [209] = {
        params = {speed = 70, time = 20},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare above speed feedback",
              params = {value = "speed", oncoming = true}
            },
            {
              goal = "Forgiving against traffic flow",
              params = {value = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:182724",
        hint = "ID:182724",
        position = vec.vector(68.50726, 43.99425, 2614.042, 1),
        heading = 1.884262,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [108] = {
        params = {time = 4},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {promptType = "Ability", abilityLevel = 1}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player using nitro"
            },
            {
              goal = "Dare time trigger",
              params = {value = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:182727",
        hint = "ID:182727",
        position = vec.vector(-3434.761, 9.912906, 147.1568, 1),
        heading = -2.576032,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [109] = {
        params = {distance = 1800, time = 60},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare started driving"
            },
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Player hasn't had collision above x force (TEMP)",
              params = {force = 4000, typeOfHit = "Vehicle"}
            },
            {
              goal = "Player hasn't had collision above x force (TEMP)",
              params = {force = 4000, typeOfHit = "Static"}
            },
            {
              goal = "Player driven X metres",
              params = {value = "distance", timer = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:183886",
        hint = "ID:183886",
        position = vec.vector(-2652.649, 60.21632, 1734.045, 1),
        heading = -0.7995572,
        iconType = "dareSpeed",
        timer = "time"
      }
    },
    [4] = {
      [211] = {
        params = {
          quantity = 5,
          speed = 100,
          time = 45
        },
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Get x vehicles above y mph",
              params = {
                value = "quantity",
                speed = "speed",
                displayed = true,
                timer = "time"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183848",
        hint = "ID:183848",
        position = vec.vector(-2823.518, 104.7164, 2942.456, 1),
        heading = 0.4922373,
        iconType = "dareSpeed",
        timer = "time"
      },
      [212] = {
        params = {speed = 190},
        goals = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false, objectiveID = "ID:183849"}
            },
            {
              goal = "Prompt upgrade",
              params = {value = "speed", promptType = "Faster"}
            },
            {
              goal = "Is player camera",
              params = {
                value = "firstPersonCamera",
                showTutorial = true
              }
            },
            {
              goal = "Dare above speed feedback",
              params = {value = "speed", checkForChangeInZap = true},
              feedback = true
            }
          }
        },
        objective = "ID:183849",
        hint = "ID:183849",
        position = vec.vector(-527.9698, 126.1508, 3801.672, 1),
        heading = 1.82568,
        iconType = "dareSpeed"
      },
      [210] = {
        params = {speed = 130, time = 20},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Stay above x mph for y seconds",
              params = {
                speed = "speed",
                displayed = true,
                value = "time"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183840",
        hint = "ID:183840",
        position = vec.vector(745.6523, 8.236362, 4160.774, 1),
        heading = 0.1597952,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [111] = {
        params = {quantity = 30, time = 60},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Dare overtakes in time",
              params = {value = "quantity", timer = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:183890",
        hint = "ID:183890",
        position = vec.vector(-1896.772, 99.8105, 2351.749, 1),
        heading = 0.5138047,
        iconType = "dareSpeed",
        timer = "time"
      },
      [412] = {
        params = {distance = 1000},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {promptType = "Thrillcam"}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare started driving"
            },
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Is player camera",
              params = {value = "ThrillCam", showTutorial = true}
            },
            {
              goal = "Player hasn't had collision above x force (TEMP)",
              params = {force = 4000, typeOfHit = "Vehicle"}
            },
            {
              goal = "Player hasn't had collision above x force (TEMP)",
              params = {force = 4000, typeOfHit = "Static"}
            },
            {
              goal = "Player driven X metres",
              params = {value = "distance"},
              feedback = true
            }
          }
        },
        objective = "ID:248620",
        hint = "ID:248620",
        position = vec.vector(-3005.9, 120.7, 3594.3, 1),
        heading = 3.015965,
        iconType = "dareSpeed"
      }
    },
    [5] = {
      [215] = {
        params = {speed = 150, time = 30},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Player hasn't had collision above x force (TEMP)",
              params = {force = 4000, typeOfHit = "Vehicle"}
            },
            {
              goal = "Player hasn't had collision above x force (TEMP)",
              params = {force = 4000, typeOfHit = "Static"}
            },
            {
              goal = "Stay above x mph for y seconds",
              params = {
                speed = "speed",
                displayed = true,
                value = "time"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183851",
        hint = "ID:183851",
        position = vec.vector(120.7248, 14.94339, -2586.332, 1),
        heading = 0.8700905,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [213] = {
        params = {
          quantity = 5,
          speed = 110,
          time = 60
        },
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Get x vehicles above y mph",
              params = {
                value = "quantity",
                speed = "speed",
                displayed = true,
                timer = "time"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183848",
        hint = "ID:183848",
        position = vec.vector(45.20216, 30.00418, -3435.093, 1),
        heading = 1.246308,
        iconType = "dareSpeed",
        timer = "time"
      },
      [214] = {
        params = {speed = 95, time = 20},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare above speed feedback",
              params = {value = "speed", oncoming = true}
            },
            {
              goal = "Forgiving against traffic flow",
              params = {value = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:182724",
        hint = "ID:182724",
        position = vec.vector(812.3174, 53.67585, -4569.349, 1),
        heading = -2.605872,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      }
    },
    [6] = {
      [218] = {
        params = {speed = 135, time = 60},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Stay above x mph for y seconds",
              params = {
                speed = "speed",
                displayed = true,
                value = "time"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183840",
        hint = "ID:183840",
        position = vec.vector(3026.685, 20.86556, 957.8889, 1),
        heading = 1.945625,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [216] = {
        params = {
          quantity = 5,
          speed = 120,
          time = 60
        },
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Get x vehicles above y mph",
              params = {
                value = "quantity",
                speed = "speed",
                displayed = true,
                timer = "time"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183848",
        hint = "ID:183848",
        position = vec.vector(-3624.381, 75.48674, 3983.165, 1),
        heading = -1.501629,
        iconType = "dareSpeed",
        timer = "time"
      },
      [217] = {
        params = {time = 5},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {promptType = "Ability", abilityLevel = 2}
            },
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Is player camera",
              params = {
                value = "firstPersonCamera",
                showTutorial = true
              }
            },
            {
              goal = "Player using nitro"
            },
            {
              goal = "Dare time trigger",
              params = {value = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:183858",
        hint = "ID:183858",
        position = vec.vector(-515.8749, 118.6866, 3545.359, 1),
        heading = -1.998866,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [118] = {
        params = {speed = 90, time = 30},
        goals = {
          {
            {
              goal = "Prompt upgrade",
              params = {
                promptType = "Car type",
                carModel = {286},
                vehType = "Haulier"
              }
            },
            {
              goal = "Dare highlight vehicle",
              params = {
                inVehicle = 286,
                highlightList = {123, 289}
              }
            },
            {
              goal = "Dare is player in vehicle model",
              params = {
                value = {286}
              }
            },
            {
              goal = "Is towing",
              params = {usePlayer = true}
            },
            {
              goal = "Stay above x mph for y seconds",
              params = {
                speed = "speed",
                displayed = true,
                value = "time"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183856",
        hint = "ID:183856",
        position = vec.vector(2799.787, 7.493449, -2241.165, 1),
        heading = -2.874114,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [117] = {
        params = {distance = 2500, time = 90},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare started driving"
            },
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Player hasn't had collision above x force (TEMP)",
              params = {force = 4000, typeOfHit = "Vehicle"}
            },
            {
              goal = "Player hasn't had collision above x force (TEMP)",
              params = {force = 4000, typeOfHit = "Static"}
            },
            {
              goal = "Player driven X metres",
              params = {value = "distance", timer = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:183886",
        hint = "ID:183886",
        position = vec.vector(149.5195, 17.91836, 969.0095, 1),
        heading = 0.1572365,
        iconType = "dareSpeed",
        timer = "time"
      },
      [416] = {
        params = {quantity = 50, time = 60},
        goals = {
          {
            {
              goal = "Player has currentVehicle"
            },
            {
              goal = "Dare overtakes in time",
              params = {timer = "time", value = "quantity"},
              feedback = true
            }
          }
        },
        objective = "ID:183890",
        hint = "ID:183890",
        position = vec.vector(1039.402, 5.984468, 1063.55, 1),
        heading = -0.5303866,
        iconType = "dareSpeed",
        timer = "time"
      }
    },
    [7] = {
      [219] = {
        params = {speed = 110, time = 30},
        goals = {
          {
            {
              goal = "Player in zap",
              params = {value = false}
            },
            {
              goal = "Dare above speed feedback",
              params = {value = "speed", oncoming = true}
            },
            {
              goal = "Forgiving against traffic flow",
              params = {value = "time"},
              feedback = true
            }
          }
        },
        objective = "ID:182724",
        hint = "ID:182724",
        position = vec.vector(-1376.425, 42.33015, 657.6843, 1),
        heading = -0.5129406,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      },
      [220] = {
        params = {speed = 170, time = 30},
        goals = {
          {
            {
              goal = "In cutscene",
              params = {inverse = true}
            },
            {
              goal = "Player in zap",
              params = {value = false, objectiveID = "ID:183840"}
            },
            {
              goal = "Prompt upgrade",
              params = {
                value = 170,
                promptType = "Faster",
                objectiveID = "ID:183840"
              }
            },
            {
              goal = "Stay above x mph for y seconds",
              params = {
                speed = "speed",
                displayed = true,
                value = "time"
              },
              feedback = true
            }
          }
        },
        objective = "ID:183840",
        hint = "ID:183840",
        position = vec.vector(-3344.612, 25.91947, -1589.873, 1),
        heading = -1.508909,
        iconType = "dareSpeed",
        timer = "time",
        timerComplete = true
      }
    }
  }
}
daresByChapter = {}
daresByUID = {}
for type, chapters in next, dareLookupTable, nil do
  for chapter, dares in next, chapters, nil do
    for uid, dare in next, dares, nil do
      dare.type = type
      dare.uid = uid
      dare.chapter = chapter
      dare.active = false
      daresByUID[uid] = dare
      daresByChapter[chapter] = daresByChapter[chapter] or {}
      daresByChapter[chapter][uid] = dare
    end
  end
end
