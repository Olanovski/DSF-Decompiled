module("onlineScreenManager", package.seeall)
playerRankStrings = {
  [1] = "mulit_intermission_rank_1",
  [2] = "mulit_intermission_rank_2",
  [3] = "mulit_intermission_rank_3",
  [4] = "mulit_intermission_rank_4",
  [5] = "mulit_intermission_rank_5",
  [6] = "mulit_intermission_rank_6",
  [7] = "mulit_intermission_rank_7",
  [8] = "mulit_intermission_rank_8"
}
playerCompRankStrings = {
  [1] = "multi_complate_1_rank",
  [2] = "multi_complate_2_rank",
  [3] = "multi_complate_3_rank",
  [4] = "multi_complate_4_rank",
  [5] = "multi_complate_5_rank",
  [6] = "multi_complate_6_rank",
  [7] = "multi_complate_7_rank",
  [8] = "multi_complate_8_rank"
}
playerMultiRankStrings = {
  [1] = "multi_screens_player_1_rank",
  [2] = "multi_screens_player_2_rank",
  [3] = "multi_screens_player_3_rank",
  [4] = "multi_screens_player_4_rank",
  [5] = "multi_screens_player_5_rank",
  [6] = "multi_screens_player_6_rank",
  [7] = "multi_screens_player_7_rank",
  [8] = "multi_screens_player_8_rank"
}
playerRankValueStrings = {
  [1] = "1.",
  [2] = "2.",
  [3] = "3.",
  [4] = "4.",
  [5] = "5.",
  [6] = "6.",
  [7] = "7.",
  [8] = "8."
}
playerNameStrings = {
  [1] = "multi_screens_player_1_name",
  [2] = "multi_screens_player_2_name",
  [3] = "multi_screens_player_3_name",
  [4] = "multi_screens_player_4_name",
  [5] = "multi_screens_player_5_name",
  [6] = "multi_screens_player_6_name",
  [7] = "multi_screens_player_7_name",
  [8] = "multi_screens_player_8_name"
}
playerMultiNameStrings = {
  [1] = "multi_complete_1_name",
  [2] = "multi_complete_2_name",
  [3] = "multi_complete_3_name",
  [4] = "multi_complete_4_name",
  [5] = "multi_complete_5_name",
  [6] = "multi_complete_6_name",
  [7] = "multi_complete_7_name",
  [8] = "multi_complete_8_name"
}
playerLevelStrings = {
  [1] = "multi_screens_player_1_level",
  [2] = "multi_screens_player_2_level",
  [3] = "multi_screens_player_3_level",
  [4] = "multi_screens_player_4_level",
  [5] = "multi_screens_player_5_level",
  [6] = "multi_screens_player_6_level",
  [7] = "multi_screens_player_7_level",
  [8] = "multi_screens_player_8_level"
}
playerMultiLevelStrings = {
  [1] = "multi_complete_1_level",
  [2] = "multi_complete_2_level",
  [3] = "multi_complete_3_level",
  [4] = "multi_complete_4_level",
  [5] = "multi_complete_5_level",
  [6] = "multi_complete_6_level",
  [7] = "multi_complete_7_level",
  [8] = "multi_complete_8_level"
}
playerScoreStrings = {
  [1] = "multi_leaderboard_score_1",
  [2] = "multi_leaderboard_score_2",
  [3] = "multi_leaderboard_score_3",
  [4] = "multi_leaderboard_score_4",
  [5] = "multi_leaderboard_score_5",
  [6] = "multi_leaderboard_score_6",
  [7] = "multi_leaderboard_score_7",
  [8] = "multi_leaderboard_score_8"
}
playerMultiScoreStrings = {
  [1] = "multi_complete_1_score",
  [2] = "multi_complete_2_score",
  [3] = "multi_complete_3_score",
  [4] = "multi_complete_4_score",
  [5] = "multi_complete_5_score",
  [6] = "multi_complete_6_score",
  [7] = "multi_complete_7_score",
  [8] = "multi_complete_8_score"
}
playerLevelUpString = {
  [1] = "iMulti_Complete_Show_Level_Icon_1",
  [2] = "iMulti_Complete_Show_Level_Icon_2",
  [3] = "iMulti_Complete_Show_Level_Icon_3",
  [4] = "iMulti_Complete_Show_Level_Icon_4",
  [5] = "iMulti_Complete_Show_Level_Icon_5",
  [6] = "iMulti_Complete_Show_Level_Icon_6",
  [7] = "iMulti_Complete_Show_Level_Icon_7",
  [8] = "iMulti_Complete_Show_Level_Icon_8"
}
playerTeamSwapString = {
  [1] = "iMulti_TeamSwap_Pos1",
  [2] = "iMulti_TeamSwap_Pos2",
  [3] = "iMulti_TeamSwap_Pos3",
  [4] = "iMulti_TeamSwap_Pos4",
  [5] = "iMulti_TeamSwap_Pos5",
  [6] = "iMulti_TeamSwap_Pos6",
  [7] = "iMulti_TeamSwap_Pos7",
  [8] = "iMulti_TeamSwap_Pos8"
}
playerTeamSwapTextString = {
  [1] = "multi_team_swap_pos_1",
  [2] = "multi_team_swap_pos_2",
  [3] = "multi_team_swap_pos_3",
  [4] = "multi_team_swap_pos_4",
  [5] = "multi_team_swap_pos_5",
  [6] = "multi_team_swap_pos_6",
  [7] = "multi_team_swap_pos_7",
  [8] = "multi_team_swap_pos_8"
}
playerRoundScoreTextString = {
  [1] = "multi_leaderboard_plus_score_1",
  [2] = "multi_leaderboard_plus_score_2",
  [3] = "multi_leaderboard_plus_score_3",
  [4] = "multi_leaderboard_plus_score_4",
  [5] = "multi_leaderboard_plus_score_5",
  [6] = "multi_leaderboard_plus_score_6",
  [7] = "multi_leaderboard_plus_score_7",
  [8] = "multi_leaderboard_plus_score_8"
}
playerRoundScoreString = {
  [1] = "iMulti_ScorePlus_P1",
  [2] = "iMulti_ScorePlus_P2",
  [3] = "iMulti_ScorePlus_P3",
  [4] = "iMulti_ScorePlus_P4",
  [5] = "iMulti_ScorePlus_P5",
  [6] = "iMulti_ScorePlus_P6",
  [7] = "iMulti_ScorePlus_P7",
  [8] = "iMulti_ScorePlus_P8"
}
