extends TileMap

onready var Cactus = preload("res://scenes/cactus.tscn")
onready var walkingEnemy = preload("res://scenes/walkingEnemy.tscn")


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
		var coordArray = []
		for x in range(floorLen):
			set_cell(floorStart + x,y,0)
			coordArray.append(Vector2(floorStart + x,y - 1))
		loadEntities(coordArray)
	update_bitmask_region(Vector2(x_start, y_start), Vector2(x_end, y_end))
	
func loadEntities(coordArray):
	var cactusSet = false
	var enemySet = false
	for x in range(len(coordArray)):
		if x!= 0 && x!=len(coordArray)-1:
			if !cactusSet && rng.randf() < 0.05:
				cactusGen(map_to_world(coordArray[x]))
				cactusSet = true
			if !enemySet && rng.randf() < 0.05:
				enemyGen(
					map_to_world(coordArray[x]-Vector2(0,1))
				)
				enemySet = true

func enemyGen(v):
	var enemy = walkingEnemy.instance()
	add_child(enemy)
	enemy.add_to_group("enemy")
	enemy.global_position = v
	enemy.init(map_to_world(Vector2(x_start, 0)).x, map_to_world(Vector2(x_end, 0)).x)

# Called when the node enters the scene tree for the first time.
func cactusGen(v):
	var enemy = Cactus.instance()
	add_child(enemy)
	enemy.add_to_group("cactus")
#	enemy.gravity_scale = 0
	enemy.global_position = v

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	floorGen(8)
	floorGen(4)
#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

