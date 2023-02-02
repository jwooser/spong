extends Control


var winner : int


onready var label = $ReferenceRect/RichTextLabel
onready var animation = $AnimationPlayer


func _ready():
	label.bbcode_text = "[center][wave amp=40 freq=5]Player " + str(winner) + " Wins!"
	animation.play("Enter")


func _on_PlayButton_pressed():
	SceneManager.play_click()
	Score.reset_game()


func _on_QuitButton_pressed():
	SceneManager.play_click()
	SceneManager.scene_pop()
