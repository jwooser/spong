extends KinematicBody2D
class_name Paddle

export (int, 1, 2) var player_id : int = 1

export var max_coord : float = 220.0
export var min_coord : float = -220.0

onready var timer = $Timer


var speed = 0


# For computer opponent
const DETECTION_THRESHHOLD = 0.2
var is_computer = false
var ball = null
var choose_dir = true
var dot_prod = 0


func _ready():
	speed = Rules.rules.paddle_speed


func _physics_process(delta):
	if is_computer:
		do_computer_movement(delta)
	else:
		do_player_movement(delta)


func do_computer_movement(delta):
	if choose_dir:
		var dist_to_ball = global_position.distance_to(ball.global_position)
		if dist_to_ball > 50:
			var perp = to_global(Vector2.UP) - global_position
			var dir_to_ball = global_position.direction_to(ball.global_position)
			dot_prod = perp.dot(dir_to_ball)
		choose_dir = false
	if dot_prod < -DETECTION_THRESHHOLD:
		position.y = min(position.y + speed * delta, max_coord)
	elif dot_prod > DETECTION_THRESHHOLD:
		position.y = max(position.y - speed * delta, min_coord)


func do_player_movement(delta):
	var p = "p" + str(player_id)
	if Input.is_action_pressed(p + "_forward"):
		position.y = max(position.y - speed * delta, min_coord)
	elif Input.is_action_pressed(p + "_back"):
		position.y = min(position.y + speed * delta, max_coord)


func _on_Timer_timeout():
	choose_dir = true
