extends Item


const decoy_color = Color(1.0, 1.0, 1.0, 0.7)

var decoy = preload("res://scenes/Decoy.tscn")
var num = 4
var angle = 2 * PI / (num + 1)

var rotation_speed = 260
var icon_angle = 6 * Vector2.UP


func _process(delta):
	rotation_degrees += rotation_speed * delta


func _draw():
	draw_circle(icon_angle, 4.0, Color.white)
	draw_circle(icon_angle.rotated(2*PI/3), 4.0, decoy_color)
	draw_circle(icon_angle.rotated(4*PI/3), 4.0, decoy_color)
	

func _on_Multi_body_entered(ball):
	var s = angle
	for i in range(num):
		var d = decoy.instance()
		d.position = ball.position
		d.speed = ball.speed
		d.velocity = ball.velocity.rotated(s)
		s += angle
		get_parent().call_deferred("add_child", d)
	get_parent().get_parent().multi_audioplayer.play()
	remove_item()
