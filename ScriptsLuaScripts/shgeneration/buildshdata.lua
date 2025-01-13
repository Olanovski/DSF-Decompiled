function GenerateSH()
  local regionSize = 2400
  local xRes = 512
  local zRes = 512
  xCentre = 0
  zCentre = 0
  regionSize = 1200
  xRes = 128
  zRes = 128
  xCentre = -600
  zCentre = -600
  local xOffset = xCentre - regionSize / 2
  local zOffset = zCentre - regionSize / 2
  local xStep = regionSize / xRes
  local zStep = regionSize / zRes
  simulation.pause()
  sh.shConvertBegin("/app_home/y:/alienbrainWork/tmp/cake.sh", xRes, zRes, 32, 32)
  for z = 0, zRes - 1 do
    for x = 0, xRes - 1 do
      sh.shGenerate((xRes - 1 - x) * xStep + xOffset, 0.5, (zRes - 1 - z) * zStep + zOffset)
    end
  end
end
