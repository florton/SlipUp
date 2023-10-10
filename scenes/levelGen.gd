extends TileMap

onready var Cactus = preload("res://scenes/cactus.tscn")
onready var Spider = preload("res://scenes/spider.tscn")
onready var FlyingCactus = preload("res://scenes/flyingCactus.tscn")
onready var EyeBird = preload("res://scenes/eyebird.tscn")
onready var BonusFly = preload("res://scenes/bonusfly.tscn")
onready var BonusWalk = preload("res://scenes/bonuswalk.tscn")

var y_start = 36
var y_end = -500

var x_start = 2
var x_end = 20

var floor_coords = {}

var rng = RandomNumberGenerator.new()

func floorGen(gap, spawnEnemies):
	var y = y_start
	while y > y_end:
		y -= gap
		var floorStart = rng.randi_range(x_start, x_end)
		var floorLen = rng.randi_range(2, clamp(10 - y/10,2,10))
		var coordArray = []
		var worldCoordArray = []
		for x in range(floorLen):
			set_cell(floorStart + x,y,0)
			coordArray.append(Vector2(floorStart + x,y - 1))
			worldCoordArray.append(map_to_world(Vector2(floorStart + x,y - 1)))
		floor_coords[floor(map_to_world(Vector2(0,y - 1)).y)] = worldCoordArray
		if spawnEnemies:
			loadEntities(coordArray)
	update_bitmask_region(Vector2(x_start, y_start), Vector2(x_end, y_end))
	
func loadEntities(coordArray):
	var walkingEnemy = false
	var flyingEnemy = false
	for x in range(len(coordArray)):
		if x!= 0 && x!=len(coordArray)-1:
			if !walkingEnemy && rng.randf() < 0.05:
				walkingEnemyGen(
					map_to_world(coordArray[x]),
					map_to_world(coordArray[1]).x,
					map_to_world(coordArray[len(coordArray)-1]).x
				)
				walkingEnemy = true
			if !flyingEnemy && rng.randf() < 0.05:
				flyingEnemyGen(
					map_to_world(coordArray[x]-Vector2(0,1)),
					map_to_world(Vector2(x_start + 1, 0)).x,
					map_to_world(Vector2(x_end + 2, 0)).x
				)
				flyingEnemy = true

func flyingEnemyGen(positon, x_min, x_max):
	var num = rng.randi_range(0, 10)
	var enemy = null
	if num < 5:
		enemy = FlyingCactus.instance()
	elif num < 10:
		enemy = EyeBird.instance()
	else:
		enemy = BonusFly.instance()
	add_child(enemy)
	enemy.add_to_group("enemy")
	enemy.global_position = positon
	enemy.init(x_min, x_max)

# Called when the node enters the scene tree for the first time.
func walkingEnemyGen(positon, x_min, x_max):
	var num = rng.randi_range(0, 10)
	var enemy = null
	if num < 6:
		enemy = Cactus.instance()
	elif num < 10:
		enemy = Spider.instance()
	else:
		enemy = BonusWalk.instance()
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
# func _process(delta):
# 	pass
	

