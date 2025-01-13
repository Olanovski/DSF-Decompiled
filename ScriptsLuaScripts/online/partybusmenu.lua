local PartyBusStrings = {
  playlist_list_title = {string = "ID:169383"},
  playlist_menu_title_private = {string = "ID:169397"},
  playlist_menu_title_public = {string = "ID:169398"},
  playlist_title_custom = {string = "ID:169401"},
  faceoff_list_title = {string = "ID:169816"},
  faceoff_list_enabled = {string = "ID:169843"},
  faceoff_list_disabled = {string = "ID:169844"},
  max_players_list_title = {string = "ID:169845"},
  network_mode_list_title = {string = "ID:169846"},
  network_mode_list_internet = {string = "ID:169847"},
  network_mode_list_lan = {string = "ID:169848"},
  lan_browser_wait = {string = "ID:169866"},
  lan_browser_no_sessions = {string = "ID:169867"},
  playlist_description_custom = {string = "ID:236568"},
  playlist_unlock_condition_custom = {string = "DBG TEXT"}
}
function getPartyBusString(tag)
  if PartyBusStrings[tag] then
    return PartyBusStrings[tag].string
  else
    return "UNKNOWN TAG"
  end
end
