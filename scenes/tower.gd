extends Node2D

onready var player = get_node("KinematicBody2D")
onready var healthSprite = get_node("UI/HP")
onready var scoreLabel = get_node("UI/Score")
onready var coinsLabel = get_node("UI/Coins")
onready var cam = get_node("Camera2D")
onready var pbar= get_node("pbbar")
const camera_offset_y = 50
const death_offset_y = 380

var playerStart = 525
var score = 0
var highScore = 0
var totalCoins = 0
var coins = 0

func loadData():
	var file = File.new()
	file.open("user://save_game.dat", File.READ)
	var content = file.get_as_text()
	var values = content.split("|")
	highScore = int(values[0]) if content else 0
	if (len(values) > 1):
		totalCoins = int(values[1]) if content else 0
	file.close()

func saveData(newScore, totalCoins):
	var file = File.new()
	file.open("user://save_game.dat", File.WRITE)
	file.store_string(str(score) + "|" + str(totalCoins))
	file.close()

# Called when the node enters the scene tree for the first time.
func _ready():
	cam.global_position.y = player.global_position.y - camera_offset_y
	loadData()
	pbar.position.y=(1 - (highScore * 48)) + playerStart

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	healthSprite.frame = player.heath
	var playerY = floor((1 - (player.position.y - playerStart)) / 48)
	if player.is_on_floor() && playerY > score:
		score = playerY
		if score > highScore:
			saveData(score, totalCoins + coins)
			scoreLabel.add_color_override("font_color", '00ff28')
	scoreLabel.text = str("LVL.",score)
	if player.global_position.y - camera_offset_y < cam.global_position.y:
		cam.global_position.y = player.global_position.y - camera_offset_y
#
#	print(player.global_position.y - cam.global_position.y)
	if player.global_position.y - death_offset_y > cam.global_position.y:
		player.fallDown()
	
func _on_KinematicBody2D_dead():
	get_tree().change_scene("res://scenes/hub.tscn")

func _on_KinematicBody2D_get_coin():
	coins = coins + 1
	coinsLabel.text = str("$",coins)
