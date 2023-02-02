extends Node2D

const MIN_SIZE = 30.0
const MAX_SIZE = 150.0
const MIN_FALL = 25.0
const MAX_FALL = 75.0
const PUSH_DIST = 250.0


var size : float
var fall : float
var dir : int
var rect : Rect2
var x_vel : float


func _ready():
	size = rand_range(MIN_SIZE, MAX_SIZE)
	fall = rand_range(MIN_FALL, MAX_FALL)
	dir = 2 * (randi() % 2) - 1
	rect = Rect2(Vector2(-size/2, -size/2), Vector2(size, size))
	$VisibilityNotifier2D.rect = rect
	modulate = Color.transparent
	var tween = $Tween
	tween.interpolate_property(
		self, "modulate", Color.transparent, Color.white, 2.0,
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	tween.start()


func _draw():
	draw_rect(rect, Color.black, true, false)
	draw_rect(rect, Color.white, false, 2.0, false)


func _physics_process(delta : float) -> void:
	spin(delta)
	position.y += fall * delta
	
	x_vel = move_toward(x_vel, 0.0, delta)
	var mouse_pos = get_global_mouse_position()
	var d = position.distance_to(mouse_pos)
	if d < PUSH_DIST:
		var f = (PUSH_DIST - d) / PUSH_DIST
		if mouse_pos.x > position.x:
			x_vel -= delta * f * 5.0
		else:
			x_vel += delta * f * 5.0
	position.x += x_vel


func spin(delta : float) -> void:
	rotation_degrees += dir * Rules.rules.stage_rotate_spd * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
