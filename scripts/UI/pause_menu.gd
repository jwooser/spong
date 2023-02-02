extends Control


var settings = preload("res://scenes/UI/Menus/SubMenus/SettingMenu.tscn")


func _on_BackButton_pressed():
	SceneManager.play_click()
	SceneManager.scene_pop()


func _on_SettingsButton_pressed():
	SceneManager.play_click()
	SceneManager.scene_pop()
	SceneManager.scene_push(settings.instance())


func _on_MenuButton_pressed():
	SceneManager.play_click()
	SceneManager.scene_pop()
	SceneManager.scene_pop()
