local NetworkEmulationConfigurations = {
  {
    name = "Disabled",
    inputLatency = 0,
    inputJitter = 0,
    inputBandwidth = 8000000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 0,
    outputJitter = 0,
    outputBandwidth = 8000000,
    outputPacketLossAvg = 0,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  },
  {
    name = "Limited Bandwidth TRC",
    inputLatency = 0,
    inputJitter = 0,
    inputBandwidth = 64000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 0,
    outputJitter = 0,
    outputBandwidth = 64000,
    outputPacketLossAvg = 0,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  },
  {
    name = "High Latency TRC",
    inputLatency = 100,
    inputJitter = 0,
    inputBandwidth = 8000000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 100,
    outputJitter = 0,
    outputBandwidth = 8000000,
    outputPacketLossAvg = 0,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  },
  {
    name = "High Packet Loss (Burst) TRC",
    inputLatency = 0,
    inputJitter = 0,
    inputBandwidth = 8000000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 0,
    outputJitter = 0,
    outputBandwidth = 8000000,
    outputPacketLossAvg = 0,
    outputPacketLossBurst = 0.1,
    outputPacketLossBurstLength = 1000,
    outputPacketLossBurstInterval = 10000
  },
  {
    name = "High Packet Loss (Sustained) TRC",
    inputLatency = 0,
    inputJitter = 0,
    inputBandwidth = 8000000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 0,
    outputJitter = 0,
    outputBandwidth = 8000000,
    outputPacketLossAvg = 0.02,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  },
  {
    name = "Average ADSL",
    inputLatency = 35,
    inputJitter = 10,
    inputBandwidth = 2000000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 35,
    outputJitter = 10,
    outputBandwidth = 500000,
    outputPacketLossAvg = 0,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  },
  {
    name = "Slow ADSL",
    inputLatency = 60,
    inputJitter = 15,
    inputBandwidth = 2000000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 60,
    outputJitter = 15,
    outputBandwidth = 500000,
    outputPacketLossAvg = 0,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  },
  {
    name = "Bad connection",
    inputLatency = 90,
    inputJitter = 15,
    inputBandwidth = 2000000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 85,
    outputJitter = 10,
    outputBandwidth = 500000,
    outputPacketLossAvg = 0,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  },
  {
    name = "Just Plain Bad",
    inputLatency = 250,
    inputJitter = 250,
    inputBandwidth = 64000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 250,
    outputJitter = 250,
    outputBandwidth = 64000,
    outputPacketLossAvg = 0.1,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  },
  {
    name = "BW Throttled",
    inputLatency = 35,
    inputJitter = 10,
    inputBandwidth = 36000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 35,
    outputJitter = 10,
    outputBandwidth = 36000,
    outputPacketLossAvg = 0,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  },
  {
    name = "BW Throttled2",
    inputLatency = 35,
    inputJitter = 10,
    inputBandwidth = 70000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 35,
    outputJitter = 10,
    outputBandwidth = 70000,
    outputPacketLossAvg = 0,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  },
  {
    name = "BW 16Kb",
    inputLatency = 35,
    inputJitter = 10,
    inputBandwidth = 16000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 35,
    outputJitter = 10,
    outputBandwidth = 16000,
    outputPacketLossAvg = 0,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  },
  {
    name = "BW 128Kb",
    inputLatency = 35,
    inputJitter = 10,
    inputBandwidth = 128000,
    inputPacketLossAvg = 0,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 35,
    outputJitter = 10,
    outputBandwidth = 128000,
    outputPacketLossAvg = 0,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  },
  {
    name = "packet loss",
    inputLatency = 0,
    inputJitter = 0,
    inputBandwidth = 8000000,
    inputPacketLossAvg = 1,
    inputPacketLossBurst = 0,
    inputPacketLossBurstLength = 0,
    inputPacketLossBurstInterval = 0,
    outputLatency = 0,
    outputJitter = 0,
    outputBandwidth = 8000000,
    outputPacketLossAvg = 1,
    outputPacketLossBurst = 0,
    outputPacketLossBurstLength = 0,
    outputPacketLossBurstInterval = 0
  }
}
function getNetworkEmulationCount()
  return #NetworkEmulationConfigurations
end
Network.setEmulationConfigCount(#NetworkEmulationConfigurations)
function getNetworkEmulationName(configurationID)
  return NetworkEmulationConfigurations[configurationID].name
end
function getNetworkEmulationLatency(device, configurationID)
  if device == 0 then
    return NetworkEmulationConfigurations[configurationID].inputLatency
  else
    return NetworkEmulationConfigurations[configurationID].outputLatency
  end
end
function getNetworkEmulationJitter(device, configurationID)
  if device == 0 then
    return NetworkEmulationConfigurations[configurationID].inputJitter
  else
    return NetworkEmulationConfigurations[configurationID].outputJitter
  end
end
function getNetworkEmulationBandwidth(device, configurationID)
  if device == 0 then
    return NetworkEmulationConfigurations[configurationID].inputBandwidth
  else
    return NetworkEmulationConfigurations[configurationID].outputBandwidth
  end
end
function getNetworkEmulationPacketLoss(device, configurationID)
  if device == 0 then
    return NetworkEmulationConfigurations[configurationID].inputPacketLossAvg, NetworkEmulationConfigurations[configurationID].inputPacketLossBurst, NetworkEmulationConfigurations[configurationID].inputPacketLossBurstLength, NetworkEmulationConfigurations[configurationID].inputPacketLossBurstInterval
  else
    return NetworkEmulationConfigurations[configurationID].outputPacketLossAvg, NetworkEmulationConfigurations[configurationID].outputPacketLossBurst, NetworkEmulationConfigurations[configurationID].outputPacketLossBurstLength, NetworkEmulationConfigurations[configurationID].outputPacketLossBurstInterval
  end
end
