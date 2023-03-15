extends Node2D

onready var scoreLabel = get_node('HighScore')
onready var coinsLabel = get_node('Coins')

# Declare member variables here. Examples:
var door = false

var highScore = 0
var totalCoins = 0

func loadData():
	var file = File.new()
	file.open("user://save_game.dat", File.READ)
	var content = file.get_as_text()
	var values = content.split("|")
	highScore = values[0]
	if (len(values) > 1):
		totalCoins = values[1]
	scoreLabel.text = highScore if highScore else str(0)
	coinsLabel.text = totalCoins if totalCoins else str(0)
	file.close()

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.window_position.x = 0
	OS.window_position.y = 0
	loadData()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("up") and door:
		get_tree().change_scene("res://scenes/tower.tscn")
		pass
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		door=true
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	door=false
	pass # Replace with function body.
