extends KinematicBody2D
class_name Ball


const MAX_SPEED = 1000


onready var timer : Timer = $Timer
onready var bounce_audioplayer : AudioStreamPlayer = $BounceAudioPlayer
onready var wallbounce_audioplayer : AudioStreamPlayer = $WallBounceAudioPlayer


var velocity : Vector2
var angle : float
var speed : float = 150.0


func _ready():
	reset()


func _physics_process(delta):
	if !timer.is_stopped():
		return
	var collision_data : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_data:
		velocity = velocity.bounce(collision_data.normal)
		if collision_data.collider is Paddle:
			var paddle_pos = collision_data.collider.global_position
			var new_dir = (velocity.normalized() + paddle_pos.direction_to(global_position)).normalized()
			speed += Rules.rules.ball_accel
			speed = min(MAX_SPEED, speed)
			velocity = new_dir * speed
			bounce_audioplayer.play()
		else:
			wallbounce_audioplayer.play()
		angle = velocity.angle()


func _draw():
	draw_circle(Vector2.ZERO, 4.0, Color.white)


func randomize_direction() -> void:
	var x = 0.0
	var y = 0.0
	while x == 0.0 and y == 0.0:
		x = rand_range(-1, 1)
		y = rand_range(-1, 1)
	velocity = Vector2(x, y).normalized() * speed


func reset() -> void:
	speed = Rules.rules.ball_speed
	position = Vector2.ZERO
	randomize_direction()
	angle = velocity.angle()
	timer.start()
