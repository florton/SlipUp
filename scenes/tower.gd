extends Node2D

onready var player = get_node("KinematicBody2D")
onready var healthSprite = get_node("UI/HP")
onready var scoreLabel = get_node("UI/Score")

var playerStart = 525
var score = 0
var highScore = 0
var coins = 0

func loadData():
	var file = File.new()
	file.open("user://save_game.dat", File.READ)
	var content = file.get_as_text()
	highScore = int(content) if content else 0
	file.close()

func saveData(newScore):
	var file = File.new()
	file.open("user://save_game.dat", File.WRITE)
	file.store_string(str(score))
	file.close()

# Called when the node enters the scene tree for the first time.
func _ready():
	loadData()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	healthSprite.frame = player.heath
	var playerY = floor((1 - (player.position.y - playerStart)) / 48)
	if player.is_on_floor() && playerY > score:
		score = playerY
		if score > highScore:
			saveData(score)
			scoreLabel.add_color_override("font_color", '00ff28')
	scoreLabel.text = str(score)


func _on_KinematicBody2D_dead():
	get_tree().change_scene("res://scenes/hub.tscn")
	pass # Replace with function body.
