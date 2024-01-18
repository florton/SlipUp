extends TileMap

onready var Cactus = preload("res://scenes/cactus.tscn")
onready var Spider = preload("res://scenes/spider.tscn")
onready var FlyingCactus = preload("res://scenes/flyingCactus.tscn")
onready var EyeBird = preload("res://scenes/eyebird.tscn")
onready var BonusFly = preload("res://scenes/bonusfly.tscn")
onready var BonusWalk = preload("res://scenes/bonuswalk.tscn")

var y_start = 36.0

var y_end = -5000.0

var y_end = -500.0
#var y_end = -100.0

var x_start = 2
var x_end = 20

var floor_coords = {}

var rng = RandomNumberGenerator.new()

func floorGen(gap, spawnEnemies):
	var y = y_start
	while y > y_end:
		y -= gap
		var floorStart = rng.randi_range(x_start, x_end)
		var progress =(1 - (y / y_end))
		var floorLen = rng.randi_range(clamp(10 * progress,2,20), clamp(20 * progress,2,20))
		if progress < 0.01:
			floorLen = 60
			floorStart = 0
		var coordArray = []
		var worldCoordArray = []
		for x in range(floorLen):
			set_cell(floorStart + x,y,0)
			coordArray.append(Vector2(floorStart + x,y - 1))
			worldCoordArray.append(map_to_world(Vector2(floorStart + x,y - 1)))
		floor_coords[floor(map_to_world(Vector2(0,y - 1)).y)] = worldCoordArray
		if spawnEnemies:
			loadEntities(coordArray, y)
	update_bitmask_region(Vector2(x_start, y_start), Vector2(x_end, y_end))
	
func loadEntities(coordArray, y):
	var progress =(y / y_end)
	print(progress)
	var enemyChance = 0.04 + (progress / 10)
	var walkingEnemy = false
	var flyingEnemy = false
	for x in range(len(coordArray)):
		if x!= 0 && x!=len(coordArray)-1:
			if !walkingEnemy && rng.randf() < enemyChance:
				walkingEnemyGen(
					map_to_world(coordArray[x]),
					map_to_world(coordArray[1]).x,
					map_to_world(coordArray[len(coordArray)-1]).x,
					y
				)
				walkingEnemy = true
			if !flyingEnemy && rng.randf() < enemyChance:
				flyingEnemyGen(
					map_to_world(coordArray[x]-Vector2(0,1)),
					map_to_world(Vector2(x_start + 1, 0)).x,
					map_to_world(Vector2(x_end + 2, 0)).x,
					y
				)
				flyingEnemy = true

func flyingEnemyGen(positon, x_min, x_max, y):
	var progress =(y / y_end)
	var num = rng.randi_range(0, progress*10)
	var enemy = null
	if num < 3:
		enemy = FlyingCactus.instance()
	elif num < 6:
		enemy = EyeBird.instance()
	else:
		enemy = BonusFly.instance()
	add_child(enemy)
	enemy.add_to_group("enemy")
	enemy.global_position = positon
	enemy.init(x_min, x_max)

# Called when the node enters the scene tree for the first time.
func walkingEnemyGen(positon, x_min, x_max, y):
	var progress =(y / y_end)
	var num = rng.randi_range(0, progress*10)
	var enemy = null
	if num < 3:
		enemy = Cactus.instance()
	elif num < 5:
		enemy = Spider.instance()
	else:
		enemy = BonusWalk.instance()
	add_child(enemy)
	enemy.add_to_group("enemy")
#	enemy.gravity_scale = 0
	enemy.global_position = positon
	enemy.init(x_min, x_max)

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
#	floorGen(16, true)
	floorGen(10, true)
#	floorGen(8, false)
	floorGen(5, true)
#
# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass
	

