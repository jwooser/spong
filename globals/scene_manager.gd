extends Node


var click_audioplayer_scene = preload("res://scenes/audio/ClickAudioPlayer.tscn")
var click_audioplayer

var scene_stack = []


func _ready():
	click_audioplayer = click_audioplayer_scene.instance()
	add_child(click_audioplayer)


func play_click():
	click_audioplayer.play()


func scene_push(scene):
	scene_stack.push_back(get_tree().get_current_scene())
	get_tree().get_root().remove_child(scene_stack.back())
	get_tree().get_root().add_child(scene)
	get_tree().set_current_scene(scene)


func scene_pop():
	var scene = scene_stack.pop_back()
	var current = get_tree().get_current_scene()
	get_tree().get_root().remove_child(current)
	get_tree().get_root().add_child(scene)
	get_tree().set_current_scene(scene)
