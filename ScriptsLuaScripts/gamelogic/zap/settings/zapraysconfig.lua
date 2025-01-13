module("ZapRays", package.seeall)
cfgtable = {
  bDrawingDisc = false,
  vDiscScale = vec.vector(1.5, 1.5, 0.75, 0),
  vDiscOffset = vec.vector(0, 0.3, 0, 0),
  vHighlightCol = vec.vector(1, 1, 1, 1.7),
  fDiscAnimRotSpeed = 2,
  vAnimScale = vec.vector(1.25, 1, 1.25, 0),
  fAnimScaleSpeedControl = 2,
  bDrawingCheapLight = true,
  cheapLightCol = vec.vector(1.3, 1.15, 0.82, 1.5),
  cheapLightScale = 0.5,
  fCheapLightAnimRotSpeed = 1,
  cheapLightAnimScale = 1.25,
  cheapLightAnimScaleSpeedControl = 1,
  iZapSelModelSwitch = 1
}
addInitObject(function()
  SetConfig(cfgtable)
end)
