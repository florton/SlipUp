extends Node2D

onready var player = get_node("KinematicBody2D")
onready var healthSprite = get_node("UI/HP")
onready var scoreLabel = get_node("UI/Score")

var playerStart = 525
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	healthSprite.frame = player.heath
	var playerY = floor((1 - (player.position.y - playerStart)) / 48)
	if player.is_on_floor() && playerY > score:
		score = playerY
	scoreLabel.text = str(score)


func _on_KinematicBody2D_dead():
	get_tree().change_scene("res://scenes/hub.tscn")
	pass # Replace with function body.
