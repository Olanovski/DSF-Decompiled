moodList = moodList or {}
moodList.Neutral = {
  lighting = {
    ambientLightColour = vec.vector(0.7, 0.7, 0.7, 1),
    directionalLightColour = vec.vector(0.8, 0.8, 0.8, 1),
    directionalLightDirection = vec.vector(-0.539164, -0.539164, 0.646997, 1),
    skyDomeIndex = 2,
    skyGradientIndex = 0,
    skyGradientBlending = 0,
    skyAnimationScaler = 3,
    skyCloudsToneBias = 0,
    skyCloudsDensity = 1.5,
    fogNearDistance = 0,
    fogFarDistance = 275,
    fogFarValue = 100,
    fogColour = vec.vector(0.75, 0.8, 0.85, 1),
    zapColour = vec.vector(0.3, 0.3, 0.3, 1),
    zapCoefficient = 0
  },
  postProcess = {
    bloomThreshold = 2,
    bloomScale = 0,
    bloomTintColour = vec.vector(1, 1, 1, 1),
    bloomFilterWeight = 0,
    bloomFirstBlurX = 0.003125,
    bloomFirstBlurY = 0,
    bloomSecondBlurX = 0,
    bloomSecondBlurY = 0.00555555,
    contrastAmount = 0,
    saturationAmount = 0,
    saturationDesatThreshold = 1,
    saturationDesatScale = 1,
    vignetteAmount = 0,
    vignetteColour = vec.vector(0, 0, 0, 0),
    vignetteCentreX = 0.5,
    vignetteCentreY = 0.6
  }
}
