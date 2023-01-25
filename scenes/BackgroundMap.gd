extends TileMap

var y_start = 100
var y_end = -500
var x_start = 0
var x_end = 16

var xTiles = 3
var yTiles = 2

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for y in range(y_start - y_end):
		for x in range(x_end - x_start):
			var autoTileIndex = Vector2(0,0)
			if rng.randf() > 0.8:
				autoTileIndex = Vector2(rng.randi() % xTiles, rng.randi() % yTiles)
			set_cell(x, y_start - y,0, false, false ,false, autoTileIndex)
#	update_bitmask_region(Vector2(x_start -1, y_start +1), Vector2(x_end +1, y_end -1))
