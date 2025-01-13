open("configuration\\configselector.lua")
if distributedbuilder == nil then
  configSelector.configLaunch("DistributedBuilder")
  distributedbuilder = true
end
