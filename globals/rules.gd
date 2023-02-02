extends Node


var rules = {
	versus = 1, # 0: Player, 1: Computer
	target_score = 5,
	stage_rotate_spd = 20.0,
	stage_flip_time = [1.5, 8.0],
	ball_speed = 300.0,
	ball_accel = 10.0,
	paddle_speed = 300.0,
	item_cap = 4,
	item_spawn_time = [4.0, 8.0],
	item_boost_enabled = true,
	item_multi_enabled = true,
	item_flash_enabled = true,
}


func _ready():
	var file = File.new()
	if not file.file_exists("rules.json"):
		save()
		return
	file.open("rules.json", File.READ)
	var data = parse_json(file.get_as_text())
	rules = data


func save():
	var file = File.new()
	file.open("rules.json", File.WRITE)
	file.store_line(to_json(rules))
	file.close()
