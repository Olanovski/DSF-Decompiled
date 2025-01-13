module("zap.multiplayerSettings", package.seeall)
local onlineZapFuelLevel = 1
zapCosts = {
  [1] = {
    zapOutCost = {
      {range = 0, amount = 25}
    },
    zapAbilityRegen = {
      {
        range = 0,
        amount = 3.85,
        primerSecs = 0,
        abilityPrimerSecs = 0
      },
      {
        range = 25,
        amount = 2.73,
        primerSecs = 0,
        abilityPrimerSecs = 0
      }
    },
    zapAbilityDegen = {
      {
        range = 0,
        amount = 1.82,
        primerSecs = 1
      },
      {
        range = 25,
        amount = 2,
        primerSecs = 1
      }
    }
  },
  [2] = {
    zapOutCost = {
      {range = 0, amount = 25}
    },
    zapAbilityRegen = {
      {
        range = 0,
        amount = 4.62,
        primerSecs = 0,
        abilityPrimerSecs = 0
      },
      {
        range = 25,
        amount = 3.276,
        primerSecs = 0,
        abilityPrimerSecs = 0
      }
    },
    zapAbilityDegen = {
      {
        range = 0,
        amount = 1.82,
        primerSecs = 1
      },
      {
        range = 25,
        amount = 2,
        primerSecs = 1
      }
    }
  },
  [3] = {
    zapOutCost = {
      {range = 0, amount = 0}
    },
    zapAbilityRegen = {
      {
        range = 0,
        amount = 5,
        primerSecs = 0,
        abilityPrimerSecs = 0
      },
      {
        range = 25,
        amount = 7,
        primerSecs = 0,
        abilityPrimerSecs = 0
      }
    },
    zapAbilityDegen = {
      {
        range = 0,
        amount = 0,
        primerSecs = 0
      },
      {
        range = 25,
        amount = 0,
        primerSecs = 0
      }
    }
  }
}
function setOnlineZapFuelLevel(level)
  if level > #zapCosts then
    level = #zapCosts
  end
  onlineZapFuelLevel = level
  for localID, plr in next, localPlayerManager.players, nil do
    scoreSystem.setAbilityUseSettings(localID, zapCosts[onlineZapFuelLevel])
  end
end
