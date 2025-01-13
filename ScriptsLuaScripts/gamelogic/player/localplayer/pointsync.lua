module("localPlayer.pointSync", package.seeall)
function setSyncedAbilityPoints(player, points)
  if player.abilityPoints ~= points then
    player.abilityPoints = points
  end
end
