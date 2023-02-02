extends Node


onready var sfx_bus = AudioServer.get_bus_index("SFX")


var settings = {
	audio_muted = false,
	audio_sfx_volume = 0.0,
	keymaps = {
		p1_forward = KEY_W,
		p1_back = KEY_S,
		p2_forward = KEY_UP,
		p2_back = KEY_DOWN
	}
}


func restore():
	AudioServer.set_bus_volume_db(sfx_bus, settings.audio_sfx_volume)
	AudioServer.set_bus_mute(sfx_bus, settings.audio_muted)
	for action in settings.keymaps.keys():
		var event = InputEventKey.new()
		event.set_scancode(settings.keymaps[action])
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, event)


func set_sfx_volume(value):
	settings.audio_sfx_volume = value
	AudioServer.set_bus_volume_db(sfx_bus, value)


func set_muted(state):
	settings.audio_muted = state
	AudioServer.set_bus_mute(sfx_bus, state)


func set_key_action(action, event):
	Settings.settings.keymaps[action] = event.scancode
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)


func _ready():
	var file = File.new()
	if not file.file_exists("settings.json"):
		save()
		return
	file.open("settings.json", File.READ)
	var data = parse_json(file.get_as_text())
	settings = data
	
	restore()


func save():
	var file = File.new()
	file.open("settings.json", File.WRITE)
	file.store_line(to_json(settings))
	file.close()
