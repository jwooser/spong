extends VBoxContainer


export (int, 1, 2) var player_id : int = 1


onready var player_label = $Player
onready var score_label = $Score


func _ready():
	player_label.text = "P" + str(player_id)


func set_score(score) -> void:
	score_label.text = str(score).pad_zeros(2)
