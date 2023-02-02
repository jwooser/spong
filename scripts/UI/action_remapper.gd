extends Button


export(String) var action = "p1_forward"

func _ready():
	assert(InputMap.has_action(action))
	set_process_unhandled_key_input(false)
	display_current_key()


func _unhandled_key_input(event):
	Settings.set_key_action(action, event)
	text = event.as_text() + " Key"
	pressed = false


func _toggled(button_pressed):
	set_process_unhandled_key_input(button_pressed)
	if button_pressed:
		text = "... Key"
		release_focus()
	else:
		display_current_key()


func display_current_key():
	var current_key = InputMap.get_action_list(action)[0].as_text()
	text = current_key + " Key"
