extends Control


var spin = preload("res://scenes/UI/SpinningSquare.tscn")
var game = preload("res://scenes/Game.tscn")
var rules = preload("res://scenes/UI/Menus/SubMenus/RuleMenu.tscn")
var settings = preload("res://scenes/UI/Menus/SubMenus/SettingMenu.tscn")


onready var background = $Background

const TARGET_SPREAD = 200.0
const VEC_NULL = Vector2(-9999, -9999)

var prev_pos = [VEC_NULL, VEC_NULL, VEC_NULL, VEC_NULL]


func _ready():
	for i in range(6):
		spawn_background_spinning_square()


func _on_PlayButton_pressed():
	Score.reset_score()
	SceneManager.scene_push(game.instance())
	SceneManager.play_click()


func _on_RulesButton_pressed():
	SceneManager.scene_push(rules.instance())
	SceneManager.play_click()


func _on_SettingsButton_pressed():
	SceneManager.scene_push(settings.instance())
	SceneManager.play_click()


func _on_Timer_timeout():
	spawn_background_spinning_square()


func spawn_background_spinning_square():
	var s = spin.instance()
	var screensize = get_viewport().get_visible_rect().size
	while true:
		s.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y - 200.0))
		var too_close = false
		for pos in prev_pos:
			if s.position.distance_to(pos) <= TARGET_SPREAD:
				too_close = true
				break
		if not too_close:
			break
	prev_pos.pop_front()
	prev_pos.push_back(s.position)
	background.add_child(s)
