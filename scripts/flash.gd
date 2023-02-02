extends Item


# Set by ItemSpawner
var cam


onready var shape = $Polygon2D

var t = 0.0
var y = position.y
var x = position.x


func _process(delta):
	t += delta
	shape.position.y = y + sin(30 * t) * 1.5
	shape.position.x = x + sin(15 * t)
	if t >= 2 * PI:
		t -= 2 * PI


func spawn_init(spawner):
	cam = spawner.camera


func _on_Flash_body_entered(ball):
	cam.add_flash(rand_range(0.8, 1.0))
	cam.add_trauma(rand_range(0.8, 1.0))
	get_parent().get_parent().thunder_audioplayer.play()
	remove_item()
