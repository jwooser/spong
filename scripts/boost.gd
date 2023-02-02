extends Item


# Set by ItemSpawner
var ball


func _process(delta):
	rotation = lerp_angle(rotation, ball.velocity.angle(), 6 * delta)


func spawn_init(spawner):
	ball = spawner.ball


func _on_Boost_body_entered(ball):
	var spd = min(ball.MAX_SPEED, ball.velocity.length() * 2)
	var dir = ball.velocity.normalized()
	ball.velocity = dir * spd
	get_parent().get_parent().boost_audioplayer.play()
	remove_item()
