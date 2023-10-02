extends TileMap

var y_start = 100
var y_end = -500
var x_start = 0
var x_end = 16

var xtiles = 4

var rng = RandomNumberGenerator.new()


func wallGen(x):
	for y in range(y_start - y_end):
		set_cell(x, y_start - y, 0, false, false ,false, Vector2(rng.randi() % xtiles, 0))

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	wallGen(x_start)
	wallGen(x_end)

