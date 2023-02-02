extends Control


onready var counters = [$ScoreCounter1, $ScoreCounter2]


func _ready():
	Score.scoreboard = self


func update_score(player_id):
	counters[player_id - 1].set_score(Score.scores[player_id - 1])
