function queryBandwidth()
  local isMonitoring = Network:bandwidthMonitoringStatus()
  if isMonitoring then
    print(Network:queryBandwidth())
  else
    removeUserUpdateFunction("pollBandwidthMonitoring")
  end
end
function startBandwidthMonitoring()
  print(Network:startBandwidthMonitoring())
  addUserUpdateFunction("pollBandwidthMonitoring", queryBandwidth, 1)
end
