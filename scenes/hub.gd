extends Node2D

onready var scoreLabel = get_node('HighScore')
onready var coinsLabel = get_node('Coins')
onready var pbFrame = get_node('pb_frame')
onready var ninjaframe = get_node("Select/Ninja")

onready var cam0 = find_node("Camera0")
onready var cam1 = find_node("Camera1")

# Declare member variables here. Examples:
var door1 = false
var door2 = false
var hubSide = 0

var highScore = 0
var totalCoins = 0

func loadData():
	var file = File.new()
	file.open("user://save.dat", File.READ)
	var content = file.get_as_text()
	var values = content.split("|")
	var highscore_setter = 1
	highScore = values[0]
	if (len(values) > 1):
		totalCoins = values[1]
	if (len(values) > 2):
		highscore_setter = values[2]
	scoreLabel.text ="highest lvl"+str(highScore )
	coinsLabel.text = "coins"+str(totalCoins )
	pbFrame.frame = int(highscore_setter)
	file.close()

# Called when the node enters the scene tree for the first time.
func _ready():
	loadData()
	if !Global.savedata.ninjaunlocked:
		ninjaframe.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("up"):
		if door1:
			door1 = false
			get_tree().change_scene("res://scenes/tower.tscn")
		if door2:
			door2 = false
			get_tree().change_scene("res://scenes/bar.tscn")

func _on_Area2D_body_entered(body,name):
	if body.is_in_group("player"):
		if name == "door1":
			door1=true
		if name == "door2":
			door2=true

func _on_Area2D_body_exited(body):
	door1=false

func _on_door2_body_exited(body):
	door2=false

func _on_door3_body_entered(body):
	if body.is_in_group("player"):
		if hubSide == 1:
			hubSide = 0
			cam0.current = true

func _on_door4_body_entered(body):
	if body.is_in_group("player"):
		if hubSide == 0:
			hubSide = 1
			cam1. current = true
