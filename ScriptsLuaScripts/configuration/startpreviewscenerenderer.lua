open("configuration\\configselector.lua")
open("configuration\\gamePauseMenu.lua")
if previewLaunched == nil then
  configSelector.configLaunch("Preview Scene Renderer")
  previewLaunched = true
end
