extends Control

onready var sound_checkbox = $ScrollContainer/VBoxContainer/GridContainer/SoundCheckBox
onready var sfx_slider = $ScrollContainer/VBoxContainer/GridContainer/SFXSlider


var initialized = false


func _ready():
	sfx_slider.value = Settings.settings.audio_sfx_volume
	sound_checkbox.pressed = not Settings.settings.audio_muted
	
	initialized = true


func _on_SFXSlider_drag_ended(value_changed):
	if not initialized:
		return
	if value_changed:
		Settings.set_sfx_volume(sfx_slider.value)
		SceneManager.play_click()


func _on_SoundCheckBox_toggled(button_pressed):
	if not initialized:
		return
	Settings.set_muted(not button_pressed)	


func _on_SaveButton_pressed():
	SceneManager.play_click()
	SceneManager.scene_pop()
	Settings.save()


