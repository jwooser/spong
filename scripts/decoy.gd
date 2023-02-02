extends KinematicBody2D
class_name Decoy


const decoy_color = Color(1.0, 1.0, 1.0, 0.7)


var velocity : Vector2
var speed : float


func _physics_process(delta):
	var collision_data : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_data:
		velocity = velocity.bounce(collision_data.normal);
		if collision_data.collider is Paddle:
			var paddle_pos = collision_data.collider.global_position
			var new_dir = (velocity.normalized() + paddle_pos.direction_to(global_position)).normalized()
			speed += Rules.rules.ball_accel
			velocity = new_dir * speed


func _draw():
	draw_circle(Vector2.ZERO, 4.0, decoy_color)
