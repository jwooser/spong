extends Node2D


var pause_menu = preload("res://scenes/UI/Menus/SubMenus/PauseMenu.tscn")


onready var timer : Timer = $Timer
onready var ball = get_node("%Ball")
onready var player2 = $Paddle2


var dir : int


func _ready():
	dir = 2 * (randi() % 2) - 1
	if Rules.rules.versus == 1:
		player2.is_computer = true
		player2.ball = ball
		player2.timer.start()


func _input(event):
	if (event.is_action_pressed("pause")):
		SceneManager.scene_push(pause_menu.instance())


func _physics_process(delta : float) -> void:
	spin(delta)


func spin(delta : float) -> void:
	rotation_degrees += dir * Rules.rules.stage_rotate_spd * delta


func _on_Timer_timeout():
	timer.start(rand_range(Rules.rules.stage_flip_time[0], Rules.rules.stage_flip_time[1]))
	dir *= -1
