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
var pb

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

	file.close()

# Called when the node enters the scene tree for the first time.
func _ready():
	if !Global.Music.is_playing():
		Global.Music.play()
	if !Global.savedata.ninjaunlocked:
		ninjaframe.queue_free()
	scoreLabel.text ="highest lvl"+str(Global.savedata.highscore )
	coinsLabel.text = "coins"+str(Global.savedata.coins )
	pbFrame.frame = int(Global.savedata.highscoresetter)
	for child in get_children():
		if child is KinematicBody2D:
			if Global.checkpoint:
				child.global_position = $Elevator.global_position
				Global.checkpoint = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_children():
		if child is KinematicBody2D:
			if child.global_position.y>=620:
				child.global_position.y=300
	if Input.is_action_pressed("up"):
		if door1:
			door1 = false
			get_tree().change_scene("res://scenes/tower.tscn")
		if door2:
			door2 = false
			get_tree().change_scene("res://scenes/bar.tscn")
		if pb:
			var textforpb="current record   "+str(Global.savedata.highscore)
			$pb_frame/dailoge._display_text(textforpb,.1)
			pass

func _on_Area2D_body_entered(body,name):
	if body.is_in_group("player"):
		body.velocity.x=0
		body.find_node("uprompt").visible=true
		if name == "door1":
			door1=true
		if name == "door2":
			door2=true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		body.find_node("uprompt").visible=false
		door1=false

func _on_door2_body_exited(body):
	if body.is_in_group("player"):
		body.find_node("uprompt").visible=false
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


func _on_door5_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://scenes/outside.tscn")
	pass # Replace with function body.


func _on_pb__body_entered(body):
	if body.is_in_group("player"):
		body.velocity.x*=0.33
		body.find_node("uprompt").visible=true
		pb=true
	pass # Replace with function body.


func _on_pb__body_exited(body):
	if body.is_in_group("player"):
		pb=false
		body.find_node("uprompt").visible=false
		pass # Replace with function body.
