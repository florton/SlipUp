extends TileMap

onready var Cactus = preload("res://scenes/cactus.tscn")
onready var flyingCactus = preload("res://scenes/flyingCactus.tscn")


var y_start = 36
var y_end = -500

var x_start = 2
var x_end = 20

var rng = RandomNumberGenerator.new()

func floorGen(gap, spawnEnemies):
	var y = y_start
	while y > y_end:
		y -= gap
		var floorStart = rng.randi_range(x_start, x_end)
		var floorLen = rng.randi_range(2, clamp(10 - y/10,2,10))
		var coordArray = []
		for x in range(floorLen):
			set_cell(floorStart + x,y,0)
			coordArray.append(Vector2(floorStart + x,y - 1))
		if spawnEnemies:
			loadEntities(coordArray)
	update_bitmask_region(Vector2(x_start, y_start), Vector2(x_end, y_end))
	
func loadEntities(coordArray):
	var cactusSet = false
	var enemySet = false
	for x in range(len(coordArray)):
		if x!= 0 && x!=len(coordArray)-1:
			if !cactusSet && rng.randf() < 0.05:
				cactusGen(
					map_to_world(coordArray[x]),
					map_to_world(coordArray[0]).x,
					map_to_world(coordArray[len(coordArray)-1]).x
				)
				cactusSet = true
			if !enemySet && rng.randf() < 0.05:
				flyingCactusGen(
					map_to_world(coordArray[x]-Vector2(0,1)),
					map_to_world(Vector2(x_start + 1, 0)).x,
					map_to_world(Vector2(x_end + 2, 0)).x
				)
				enemySet = true

func flyingCactusGen(positon, x_min, x_max):
	var enemy = flyingCactus.instance()
	add_child(enemy)
	enemy.add_to_group("enemy")
	enemy.global_position = positon
	enemy.init(x_min, x_max)

# Called when the node enters the scene tree for the first time.
func cactusGen(positon, x_min, x_max):
	var enemy = Cactus.instance()
	add_child(enemy)
	enemy.add_to_group("cactus")
#	enemy.gravity_scale = 0
	enemy.global_position = positon
	enemy.init(x_min, x_max)

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	floorGen(16, true)
	floorGen(8, true)
	floorGen(8, false)
	floorGen(4, true)
#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

