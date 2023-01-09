extends TileMap

var y_start = 36
var y_end = -200

var x_start = 1
var x_end = 30

var rng = RandomNumberGenerator.new()

func floorGen(gap):
	var y = y_start
	while y > y_end:
		y -= gap
		var floorStart = rng.randi_range(x_start, x_end)
		var floorLen = rng.randi_range(4, 10)
		for x in range(floorLen):
			set_cell(floorStart + x,y,0)
	update_bitmask_region(Vector2(x_start, y_start), Vector2(x_end, y_end))

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	floorGen(8)
	floorGen(4)
#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

