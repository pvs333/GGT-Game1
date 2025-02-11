extends Node

var win_count_1 = 0
var win_count_2 = 0

func loses(player_no):
	if(player_no == 1):
		win_count_2 += 1
		print("Player 2 Wins :", win_count_2)
		get_tree().reload_current_scene()
	elif(player_no == 2):
		win_count_1 += 1
		print("Player 1 Wins :", win_count_1)
		get_tree().reload_current_scene()
		
		
		
