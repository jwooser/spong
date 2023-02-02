extends Button


func _ready():
	display_text()


func _on_Button_pressed():
	Rules.rules.versus = int(Rules.rules.versus + 1) % 2
	display_text()
	pressed = false


func display_text():
	if Rules.rules.versus == 0:
		text = "Player"
	else:
		text = "Computer"
