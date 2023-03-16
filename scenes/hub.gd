extends Node2D

onready var scoreLabel = get_node('HighScore')
onready var coinsLabel = get_node('Coins')

# Declare member variables here. Examples:
var door1 = false
var door2 = false

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
	scoreLabel.text ="highest lvl"+highScore 
	coinsLabel.text = "coins"+totalCoins 
	file.close()

# Called when the node enters the scene tree for the first time.
func _ready():

	loadData()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("up"):
		if door1:
			get_tree().change_scene("res://scenes/tower.tscn")
		if door2:
			get_tree().change_scene("res://scenes/bar.tscn")
		pass
	pass


func _on_Area2D_body_entered(body,name):
	if body.is_in_group("player"):
		if name == "door1":
			door1=true
			pass
		if name == "door2":
			door2=true
			pass
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	door1=false

	pass # Replace with function body.


func _on_door2_body_exited(body):
	door2=false
	pass # Replace with function body.
