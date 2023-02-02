extends Node


var scoreboard


var endmenu = preload("res://scenes/UI/Menus/EndMenu.tscn")


var scores = [0, 0]
var ended : bool = false


func _ready():
	randomize()


func increase_score(player_id):
	if ended:
		return
	scores[player_id - 1] += 1
	scoreboard.update_score(player_id)
	if scores[player_id - 1] == Rules.rules.target_score:
		ended = true
		var s = endmenu.instance()
		s.winner = player_id
		scoreboard.get_parent().add_child(s)


func reset_score():
	ended = false
	scores[0] = 0
	scores[1] = 0
	

func reset_game():
	reset_score()
	get_tree().change_scene("res://scenes/Game.tscn")
