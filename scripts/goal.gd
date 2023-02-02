extends Area2D


export (int, 1, 2) var player_id : int = 1


onready var scored_audioplayer = $ScoredAudioPlayer


func _on_Goal_body_entered(body):
	if body is Ball:
		Score.increase_score(player_id)
		body.reset()
		scored_audioplayer.play()
	else:
		body.queue_free()
