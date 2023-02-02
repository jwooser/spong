extends Area2D
class_name Item

onready var tween = Tween.new()


func _ready():
	add_child(tween)
	modulate = Color.transparent
	tween.interpolate_property(
		self, "modulate", Color.transparent, Color.white, 0.4,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()


func spawn_init(spawner):
	pass


func despawn():
	tween.interpolate_property(
		self, "modulate", Color.white, Color.transparent, 0.4,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()
	tween.connect("tween_completed", self, "remove_item")


func remove_item(obj = null, key = null):
	get_parent().get_parent().pos.append(position)
	queue_free()
