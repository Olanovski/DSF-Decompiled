module("moodSystem", package.seeall)
function createMoodGroups()
  moodGroups = {
    ClearDay = {
      main = moodSystem.ClearDay,
      incar = moodSystem.ClearDayCar,
      sky = "ClearDay2"
    },
    Coma = {
      main = moodSystem.Coma,
      incar = moodSystem.ComaCar,
      sky = "Dreamy"
    },
    Fog = {
      main = moodSystem.Fog,
      incar = moodSystem.Fog,
      sky = "ClearDay2"
    },
    JericohLite = {
      main = moodSystem.JericohLite,
      incar = moodSystem.JericohLiteCar,
      sky = "Dreamy"
    },
    JericohFull = {
      main = moodSystem.JericohFull,
      incar = moodSystem.JericohFullCar,
      sky = "Dreamy"
    },
    Frozen = {
      main = moodSystem.Frozen,
      incar = moodSystem.FrozenCar,
      sky = "Chapter62"
    },
    LastChapter = {
      main = moodSystem.LastChapter,
      incar = moodSystem.LastChapterCar,
      sky = "ClearDay2"
    },
    LastChapterPre = {
      main = moodSystem.LastChapterPre,
      incar = moodSystem.LastChapterPreCar,
      sky = "ClearDay2"
    },
    Garage = {
      main = moodSystem.Garage,
      incar = moodSystem.GarageCar,
      sky = "ClearDay2"
    },
    Cutscene = {
      main = moodSystem.Cutscene,
      incar = moodSystem.CutsceneCar,
      sky = "Dreamy"
    },
    Challenge_Escape = {
      main = moodSystem.Challenge_Escape,
      incar = moodSystem.Challenge_EscapeCar,
      sky = "Desert2"
    },
    Challenge_WhiteStripe = {
      main = moodSystem.Challenge_WhiteStripe,
      incar = moodSystem.Challenge_WhiteStripeCar,
      sky = "Chapter6"
    },
    Challenge_Bullitt = {
      main = moodSystem.Challenge_Bullitt,
      incar = moodSystem.Challenge_BullittCar,
      sky = "Chapter6"
    },
    Challenge_LAConnexion = {
      main = moodSystem.Challenge_LAConnexion,
      incar = moodSystem.Challenge_LAConnexionCar,
      sky = "Chapter6"
    },
    Challenge_Blues = {
      main = moodSystem.Challenge_Blues,
      incar = moodSystem.Challenge_BluesCar,
      sky = "Dreamy"
    },
    Challenge_Cannonball = {
      main = moodSystem.Challenge_Cannonball,
      incar = moodSystem.Challenge_CannonballCar,
      sky = "Chapter6"
    },
    Challenge_Dukes = {
      main = moodSystem.Challenge_Dukes,
      incar = moodSystem.Challenge_DukesCar,
      sky = "Chapter62"
    },
    Challenge_Vanishing = {
      main = moodSystem.Challenge_Vanishing,
      incar = moodSystem.Challenge_VanishingCar,
      sky = "Orange"
    },
    Challenge_TheDriver = {
      main = moodSystem.Challenge_TheDriver,
      incar = moodSystem.Challenge_TheDriverCar,
      sky = "Sunset"
    },
    Challenge_LuckyBandit = {
      main = moodSystem.Challenge_LuckyBandit,
      incar = moodSystem.Challenge_LuckyBanditCar,
      sky = "Chapter6"
    },
    Challenge_BelViaggio = {
      main = moodSystem.Challenge_BelViaggio,
      incar = moodSystem.Challenge_BelViaggioCar,
      sky = "Desert3"
    },
    Challenge_RufStuff = {
      main = moodSystem.Challenge_RufStuff,
      incar = moodSystem.Challenge_RufStuffCar,
      sky = "Chapter62"
    },
    RushdownRed = {
      main = moodSystem.RushdownRed,
      incar = moodSystem.RushdownRedCar
    },
    RushdownBlue = {
      main = moodSystem.RushdownBlue,
      incar = moodSystem.RushdownBlueCar
    },
    RushdownBlueNoSky = {
      main = moodSystem.RushdownBlue,
      incar = moodSystem.RushdownBlueCar
    },
    Impulse_Attack = {
      main = moodSystem.Impulse_Attack,
      incar = moodSystem.Impulse_AttackCar
    },
    Impulse_Target = {
      main = moodSystem.Impulse_Target,
      incar = moodSystem.Impulse_TargetCar
    }
  }
  for moodName, moodTable in next, moodGroups, nil do
    moodTable.name = moodName
  end
end
