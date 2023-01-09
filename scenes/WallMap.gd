extends TileMap

var y_start = 100
var y_end = -200
var x_start = 0
var x_end = 16

var rng = RandomNumberGenerator.new()

func wallGen(x):
	for y in range(y_start - y_end):
		set_cell(x, y_start - y,0)
#	update_bitmask_region(Vector2(x_start, y_start), Vector2(x_end, y_end))

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	wallGen(x_start)
	wallGen(x_end)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
