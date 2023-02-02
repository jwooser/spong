extends Control

var initialized = false

onready var target_score_spinbox = $ScrollContainer/VBoxContainer/GridContainer/TargetScoreSpinBox
onready var rotation_speed_spinbox = $ScrollContainer/VBoxContainer/GridContainer2/RotationSpeedSpinBox
onready var min_flip_time_spinbox = $ScrollContainer/VBoxContainer/GridContainer2/MinFlipTimeSpinBox
onready var max_flip_time_spinbox = $ScrollContainer/VBoxContainer/GridContainer2/MaxFlipTimeSpinbox
onready var speed_spinbox = $ScrollContainer/VBoxContainer/GridContainer3/SpeedSpinBox
onready var accel_spinbox = $ScrollContainer/VBoxContainer/GridContainer3/AccelerationSpinBox
onready var paddle_speed_spinbox = $ScrollContainer/VBoxContainer/GridContainer4/PaddleSpeedSpinBox
onready var cap_spinbox = $ScrollContainer/VBoxContainer/GridContainer5/CapSpinBox
onready var min_spawn_time_spinbox = $ScrollContainer/VBoxContainer/GridContainer5/MinSpawnTimeSpinBox
onready var max_spawn_time_spinbox = $ScrollContainer/VBoxContainer/GridContainer5/MaxSpawnTimeSpinbox
onready var boost_checkbox = $ScrollContainer/VBoxContainer/GridContainer5/HBoxContainer/BoostCheckBox
onready var flash_checkbox = $ScrollContainer/VBoxContainer/GridContainer5/HBoxContainer/FlashCheckBox
onready var multi_checkbox = $ScrollContainer/VBoxContainer/GridContainer5/HBoxContainer/MultiCheckBox


func _ready():
	target_score_spinbox.value = Rules.rules.target_score
	
	rotation_speed_spinbox.value = Rules.rules.stage_rotate_spd
	min_flip_time_spinbox.value = Rules.rules.stage_flip_time[0]
	max_flip_time_spinbox.value = Rules.rules.stage_flip_time[1]
	
	speed_spinbox.value = Rules.rules.ball_speed
	accel_spinbox.value = Rules.rules.ball_accel
	
	paddle_speed_spinbox.value = Rules.rules.paddle_speed
	
	cap_spinbox.value = Rules.rules.item_cap
	min_spawn_time_spinbox.value = Rules.rules.item_spawn_time[0]
	max_spawn_time_spinbox.value = Rules.rules.item_spawn_time[1]
	boost_checkbox.pressed = Rules.rules.item_boost_enabled
	flash_checkbox.pressed = Rules.rules.item_flash_enabled
	multi_checkbox.pressed = Rules.rules.item_multi_enabled
	
	max_flip_time_spinbox.min_value = Rules.rules.stage_flip_time[0]
	min_flip_time_spinbox.max_value = Rules.rules.stage_flip_time[1]
	
	max_spawn_time_spinbox.min_value = Rules.rules.item_spawn_time[0]
	min_spawn_time_spinbox.max_value = Rules.rules.item_spawn_time[1]
	
	initialized = true


func _on_TargetScoreSpinBox_value_changed(value):
	if not initialized:
		return
	Rules.rules.target_score = value


func _on_RotationSpeedSpinBox_value_changed(value):
	if not initialized:
		return
	Rules.rules.stage_rotate_spd = value


func _on_MinFlipTimeSpinBox_value_changed(value):
	if not initialized:
		return
	Rules.rules.stage_flip_time[0] = value
	max_flip_time_spinbox.min_value = value


func _on_MaxFlipTimeSpinbox_value_changed(value):
	if not initialized:
		return
	Rules.rules.stage_flip_time[1] = value
	min_flip_time_spinbox.max_value = value


func _on_SpeedSpinBox_value_changed(value):
	if not initialized:
		return
	Rules.rules.ball_speed = value


func _on_AccelerationSpinBox_value_changed(value):
	if not initialized:
		return
	Rules.rules.ball_accel = value


func _on_CapSpinBox_value_changed(value):
	if not initialized:
		return
	Rules.rules.item_cap = value


func _on_MinSpawnTimeSpinBox_value_changed(value):
	if not initialized:
		return
	Rules.rules.item_spawn_time[0] = value
	max_spawn_time_spinbox.min_value = value


func _on_MaxSpawnTimeSpinbox_value_changed(value):
	if not initialized:
		return
	Rules.rules.item_spawn_time[1] = value
	min_spawn_time_spinbox.max_value = value


func _on_BoostCheckBox_toggled(button_pressed):
	if not initialized:
		return
	Rules.rules.item_boost_enabled = button_pressed


func _on_FlashCheckBox_toggled(button_pressed):
	if not initialized:
		return
	Rules.rules.item_flash_enabled = button_pressed


func _on_MultiCheckBox_toggled(button_pressed):
	if not initialized:
		return
	Rules.rules.item_multi_enabled = button_pressed


func _on_PaddleSpeedSpinBox_value_changed(value):
	if not initialized:
		return
	Rules.rules.paddle_speed = value


func _on_SaveButton_pressed():
	SceneManager.play_click()
	SceneManager.scene_pop()
	Rules.save()
