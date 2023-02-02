extends Node2D


const SPAWN_RADIUS = 150
const OUTER_ITEMS = 8
const INNER_ITEMS = 4
const TOTAL_ITEMS = OUTER_ITEMS + INNER_ITEMS
const DESPAWN_INTERVALS = 3


var boost = preload("res://scenes/items/Boost.tscn")
var flash = preload("res://scenes/items/Flash.tscn")
var multi = preload("res://scenes/items/Multi.tscn")
var item_types = []
var intervals : int = 0


onready var timer = $Timer
onready var items = $Items
onready var thunder_audioplayer = $ThunderAudioPlayer
onready var boost_audioplayer = $BoostAudioPlayer
onready var multi_audioplayer = $MultiAudioPlayer
onready var ball = get_node("%Ball")
onready var camera = get_node("%Camera2D")


var pos = []


func _ready():
	if Rules.rules.item_cap >= 0:
		timer.wait_time = rand_range(Rules.rules.item_spawn_time[0], Rules.rules.item_spawn_time[1])
		timer.start()
	
	var v = Vector2.RIGHT * SPAWN_RADIUS
	var rot = 2 * PI / OUTER_ITEMS
	for i in range(OUTER_ITEMS):
		pos.push_back(v.rotated(i * rot))
		
	v /= 2
	rot = 2 * PI / INNER_ITEMS
	for i in range(INNER_ITEMS):
		pos.push_back(v.rotated(i * rot))
		
	if Rules.rules.item_boost_enabled:
		item_types.push_back(boost)
	if Rules.rules.item_flash_enabled:
		item_types.push_back(flash)
	if Rules.rules.item_multi_enabled:
		item_types.push_back(multi)


func make_rand_item():
	var item_type = item_types[randi() % item_types.size()]
	var item = item_type.instance()
	item.spawn_init(self)
	return item


func _on_Timer_timeout():
	if TOTAL_ITEMS - pos.size() >= Rules.rules.item_cap: # Rules.rules.item_cap is nonzero if the timer is active
		intervals += 1
		if intervals > DESPAWN_INTERVALS:
			var item_nodes = items.get_children()
			item_nodes[(randi()%item_nodes.size()) / 2].despawn()
			intervals = 0
		return
	intervals = 0
	timer.wait_time = rand_range(Rules.rules.item_spawn_time[0], Rules.rules.item_spawn_time[1])
	var i = randi() % pos.size()
	var item = make_rand_item()
	item.position = pos[i]
	pos.remove(i)
	items.add_child(item)
