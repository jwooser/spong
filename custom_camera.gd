extends Camera2D


onready var noise = OpenSimplexNoise.new()
var noise_y = 0

export var decay = 0.8  # How quickly the shaking stops [0, 1].
export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).
export (NodePath) var target  # Assign the node this camera will follow.

var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].

export var flash_decay = 0.6
var flash = 0.0


func _ready():
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2


func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)


func add_flash(amount):
	flash = min(flash + amount, 1.0)


func _process(delta):
	if target:
		global_position = get_node(target).global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	if flash:
		flash = max(flash - flash_decay * delta, 0)
		modulate.a = flash


func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
