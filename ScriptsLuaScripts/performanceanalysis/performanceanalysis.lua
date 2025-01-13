module("PerformanceAnalysis", package.seeall)
PerformanceAnalysis.Translation = vec.vector(0, 0, 0, 1)
PerformanceAnalysis.Rotation = 0
PerformanceAnalysis.Height = 1.1
PerformanceAnalysis.RotationSample = 1
PerformanceAnalysis.IsAnalysisRunning = false
PerformanceAnalysis.AnalyseNewRegion = false
PerformanceAnalysis.RegionArrayIndex = 0
PerformanceAnalysis.AnalyseNewPoint = false
PerformanceAnalysis.PointIndex = 0
PerformanceAnalysis.AnalyseNewRotation = false
PerformanceAnalysis.RotationIndex = 0
PerformanceAnalysis.FirstStat = false
PerformanceAnalysis.AllRegions = false
PerformanceAnalysis.TwoPi = math.pi * 2
PerformanceAnalysis.Angle = 0
PerformanceAnalysis.CameraMatrix = vec.matrix()
PerformanceAnalysis.TranslationMatrix = vec.matrix()
PerformanceAnalysis.RotationMatrix = vec.matrix()
PerformanceAnalysis.WorkingVector = vec.vector()
PerformanceAnalysis.CosTheta = 0
PerformanceAnalysis.SinTheta = 0
PerformanceAnalysis.RegionCount = 0
PerformanceAnalysis.SamplePointAverage = 0
PerformanceAnalysis.NumRegionPoints = 0
PerformanceAnalysis.Fov = math.rad(75)
function PerformanceAnalysis.SetRotationMatrix(angle)
  PerformanceAnalysis.CosTheta = math.cos(angle)
  PerformanceAnalysis.SinTheta = math.sin(angle)
  PerformanceAnalysis.RotationMatrix:getColumn(0, PerformanceAnalysis.WorkingVector)
  PerformanceAnalysis.WorkingVector.x = PerformanceAnalysis.CosTheta
  PerformanceAnalysis.WorkingVector.z = -PerformanceAnalysis.SinTheta
  PerformanceAnalysis.RotationMatrix[0] = PerformanceAnalysis.WorkingVector
  PerformanceAnalysis.RotationMatrix:getColumn(2, PerformanceAnalysis.WorkingVector)
  PerformanceAnalysis.WorkingVector.x = PerformanceAnalysis.SinTheta
  PerformanceAnalysis.WorkingVector.z = PerformanceAnalysis.CosTheta
  PerformanceAnalysis.RotationMatrix[2] = PerformanceAnalysis.WorkingVector
end
function PerformanceAnalysis.InitialiseCamera()
  allowFreeCam(true)
  while localPlayer.cameraMode ~= "FreeCam" do
    cycleActiveCamera("JustPressed", 1, 0)
  end
  player.setAttachment(localPlayer.localID, free_camera)
  spoolsystem.EnableCameraTracking()
end
function PerformanceAnalysis.Initialise(regionIndex, allRegions)
  if not PerformanceAnalysis.Regions then
    debugOpen("RegionsDefinition.lua")
  end
  if PerformanceAnalysis.Regions then
    PerformanceAnalysis.RegionCount = #PerformanceAnalysis.Regions
    performance.SetProfilerMode("gpu")
    simulation.EnableLuaMemoryDisplay()
    PerformanceAnalysis.InitialiseCamera()
    free_camera.fov = PerformanceAnalysis.Fov
    spooling.enableTraffic(false)
    characterManager.DisablePeds()
    TrafficEventsManager.SetEnable(false)
    PerformanceAnalysis.GetPointsNumber(regionIndex, allRegions)
    print("$performance$INITIALISED:" .. tostring(PerformanceAnalysis.NumRegionPoints))
  end
end
function PerformanceAnalysis.MoveCamera()
  PerformanceAnalysis.TranslationMatrix[3] = PerformanceAnalysis.Translation
  PerformanceAnalysis.SetRotationMatrix(PerformanceAnalysis.Rotation)
  PerformanceAnalysis.TranslationMatrix:multiply(PerformanceAnalysis.RotationMatrix, PerformanceAnalysis.CameraMatrix)
  free_camera.matrix = PerformanceAnalysis.CameraMatrix
end
function PerformanceAnalysis.UpdatePosition(x, y, z)
  PerformanceAnalysis.Translation.x = x
  PerformanceAnalysis.Translation.y = y + PerformanceAnalysis.Height
  PerformanceAnalysis.Translation.z = z
  PerformanceAnalysis.Translation.w = 1
  PerformanceAnalysis.MoveCamera()
end
function PerformanceAnalysis.UpdateRotation(angle)
  PerformanceAnalysis.Rotation = angle
  PerformanceAnalysis.MoveCamera()
end
function PerformanceAnalysis.RunAnalysis(regionIndex, allRegions, rotationSample, height)
  PerformanceAnalysis.Initialise(regionIndex, allRegions)
  if PerformanceAnalysis.Regions then
    PerformanceAnalysis.RotationSample = rotationSample
    PerformanceAnalysis.Height = height
    PerformanceAnalysis.IsAnalysisRunning = true
    performance.EnableBloombergStats(true)
    PerformanceAnalysis.FirstStat = true
    PerformanceAnalysis.AllRegions = allRegions
    if PerformanceAnalysis.AllRegions == true then
      if PerformanceAnalysis.RegionCount > 0 then
        PerformanceAnalysis.AnalyseNewRegion = true
        PerformanceAnalysis.RegionArrayIndex = 1
        addUserUpdateFunction("runAllRegionsAnalysis", PerformanceAnalysis.RunAllRegions, 1, true)
      end
    else
      PerformanceAnalysis.RegionArrayIndex = PerformanceAnalysis.GetRegionArrayIndex(regionIndex)
      if PerformanceAnalysis.RegionArrayIndex ~= -1 then
        PerformanceAnalysis.RunRegion()
      end
    end
  end
end
function PerformanceAnalysis.StopAnalysis()
  PerformanceAnalysis.IsAnalysisRunning = false
end
function PerformanceAnalysis.EndAnalysis()
  performance.ProcessBloombergStats()
  performance.EnableBloombergStats(false)
  PerformanceAnalysis.IsAnalysisRunning = false
  PerformanceAnalysis.FirstStat = false
  characterManager.EnablePeds()
  spooling.enableTraffic(true)
  TrafficEventsManager.SetEnable(true)
  performance.SetProfilerMode("off")
  spoolsystem.DisableCameraTracking()
  simulation.DisableLuaMemoryDisplay()
  print("$performance$COMPLETED")
end
function PerformanceAnalysis.RunAllRegions()
  if PerformanceAnalysis.AnalyseNewRegion == true then
    PerformanceAnalysis.AnalyseNewRegion = false
    if PerformanceAnalysis.RegionArrayIndex <= PerformanceAnalysis.RegionCount and PerformanceAnalysis.IsAnalysisRunning == true then
      PerformanceAnalysis.RunRegion()
    else
      PerformanceAnalysis.EndAnalysis()
      removeUserUpdateFunction("runAllRegionsAnalysis")
    end
  end
end
function PerformanceAnalysis.RunRegion()
  if PerformanceAnalysis.IsRegionValid(PerformanceAnalysis.RegionArrayIndex) and debugOpen("AnalysisRegion_" .. tostring(PerformanceAnalysis.Regions[PerformanceAnalysis.RegionArrayIndex]) .. ".lua") == true then
    PerformanceAnalysis.AnalyseNewPoint = true
    PerformanceAnalysis.PointIndex = 1
    addUserUpdateFunction("runRegionPointsAnalysis", PerformanceAnalysis.RunRegionPoints, 1, false)
  else
    PerformanceAnalysis.StepRegion()
  end
end
function PerformanceAnalysis.RunRegionPoints()
  if PerformanceAnalysis.AnalyseNewPoint == true then
    PerformanceAnalysis.AnalyseNewPoint = false
    if PerformanceAnalysis.SamplePoints and PerformanceAnalysis.PointIndex <= PerformanceAnalysis.MaxSamplePoints and PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex] and PerformanceAnalysis.IsAnalysisRunning == true then
      if PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex].X and PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex].Y and PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex].Z then
        PerformanceAnalysis.UpdatePosition(PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex].X, PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex].Y, PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex].Z)
        print("$performance$JOBSTARTED:" .. tostring(PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex].X) .. ":" .. tostring(PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex].Z))
        addUserUpdateFunction("processAreWeSpooledAnalysis", PerformanceAnalysis.ProcessAreWeSpooled, 1, true)
      else
        PerformanceAnalysis.AnalyseNewPoint = true
        PerformanceAnalysis.PointIndex = PerformanceAnalysis.PointIndex + 1
      end
    else
      PerformanceAnalysis.StepRegion()
      removeUserUpdateFunction("runRegionPointsAnalysis")
    end
  end
end
function PerformanceAnalysis.StepRegion()
  if PerformanceAnalysis.AllRegions then
    PerformanceAnalysis.RegionArrayIndex = PerformanceAnalysis.RegionArrayIndex + 1
    PerformanceAnalysis.AnalyseNewRegion = true
  else
    PerformanceAnalysis.EndAnalysis()
  end
end
function PerformanceAnalysis.ProcessAreWeSpooled()
  if spoolsystem.IsLocationResident(PerformanceAnalysis.Translation) == true then
    PerformanceAnalysis.AnalyseNewRotation = true
    PerformanceAnalysis.RotationIndex = 0
    removeUserUpdateFunction("processAreWeSpooledAnalysis")
    addUserUpdateFunction("processCameraRotationAnalysis", PerformanceAnalysis.ProcessCameraRotation, 1, true)
  end
end
function PerformanceAnalysis.ProcessCameraRotation()
  if PerformanceAnalysis.AnalyseNewRotation == true then
    PerformanceAnalysis.AnalyseNewRotation = false
    if PerformanceAnalysis.RotationIndex < PerformanceAnalysis.RotationSample and PerformanceAnalysis.IsAnalysisRunning == true then
      PerformanceAnalysis.Angle = PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex].Angle + PerformanceAnalysis.TwoPi * PerformanceAnalysis.RotationIndex / PerformanceAnalysis.RotationSample
      if PerformanceAnalysis.Angle > PerformanceAnalysis.TwoPi then
        PerformanceAnalysis.Angle = PerformanceAnalysis.Angle - PerformanceAnalysis.TwoPi
      elseif PerformanceAnalysis.Angle < -PerformanceAnalysis.TwoPi then
        PerformanceAnalysis.Angle = PerformanceAnalysis.Angle + PerformanceAnalysis.TwoPi
      end
      PerformanceAnalysis.UpdateRotation(PerformanceAnalysis.Angle)
      performance.ResetCityBuffers()
      addUserUpdateFunction("processAreCityBuffersFullAnalysis", PerformanceAnalysis.ProcessAreCityBuffersFull, 1, true)
    else
      PerformanceAnalysis.PointIndex = PerformanceAnalysis.PointIndex + 1
      PerformanceAnalysis.AnalyseNewPoint = true
      print("$performance$JOBFINISHED")
      removeUserUpdateFunction("processCameraRotationAnalysis")
    end
  end
end
function PerformanceAnalysis.ProcessAreCityBuffersFull()
  if performance.AreCityBuffersFull() == true then
    PerformanceAnalysis.SamplePointAverage = performance.GetCityDrawTimeAverage()
    print("$performance$DATA:" .. tostring(PerformanceAnalysis.SamplePointAverage))
    if PerformanceAnalysis.FirstStat == true then
      performance.LogBloombergSubSession()
      PerformanceAnalysis.FirstStat = false
    end
    performance.LogBloombergStats(PerformanceAnalysis.SamplePointAverage, PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex].X, PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex].Y, PerformanceAnalysis.SamplePoints[PerformanceAnalysis.PointIndex].Z, PerformanceAnalysis.Rotation * 180 / math.pi, PerformanceAnalysis.Regions[PerformanceAnalysis.RegionArrayIndex])
    PerformanceAnalysis.RotationIndex = PerformanceAnalysis.RotationIndex + 1
    PerformanceAnalysis.AnalyseNewRotation = true
    removeUserUpdateFunction("processAreCityBuffersFullAnalysis")
  end
end
function PerformanceAnalysis.GetPointsNumber(regionIndex, allRegions)
  if allRegions == true then
    if PerformanceAnalysis.Regions then
      for i = 1, PerformanceAnalysis.RegionCount do
        GetRegionPointsNumber(i)
      end
    end
  else
    GetRegionPointsNumber(PerformanceAnalysis.GetRegionArrayIndex(regionIndex))
  end
end
function PerformanceAnalysis.GetRegionPointsNumber(regionArrayIndex)
  if PerformanceAnalysis.IsRegionValid(regionArrayIndex) and debugOpen("AnalysisRegion_" .. tostring(PerformanceAnalysis.Regions[regionArrayIndex]) .. ".lua") == true then
    PerformanceAnalysis.NumRegionPoints = PerformanceAnalysis.NumRegionPoints + PerformanceAnalysis.MaxSamplePoints
  end
end
function PerformanceAnalysis.GetRegionArrayIndex(region)
  if PerformanceAnalysis.Regions then
    for i = 1, PerformanceAnalysis.RegionCount do
      if PerformanceAnalysis.Regions[i] == region then
        return i
      end
    end
  end
  return -1
end
function PerformanceAnalysis.IsRegionValid(regionArrayIndex)
  if PerformanceAnalysis.Regions and PerformanceAnalysis.Regions[regionArrayIndex] then
    return true
  end
  return false
end
