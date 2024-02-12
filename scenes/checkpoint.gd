extends Node2D


# Declare member variables here. Examples:
const Guy= preload("res://scenes/guy.tscn") 
const Ninja= preload("res://scenes/ninja.tscn") 
var player

var elevator = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.savedata.character=="guy":
		var player=Guy.instance()
		player.global_position=Vector2(500,500)
		self.add_child(player)
	if Global.savedata.character=="ninja":
		var player=Ninja.instance()
		player.global_position=Vector2(500,500)
		self.add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("up"):
		if elevator:
			get_tree().change_scene("res://scenes/hub.tscn")

func _on_Hole_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://scenes/tower.tscn")


func _on_Elevator_body_entered(body):
	if body.is_in_group("player"):
		body.find_node("uprompt").visible=true
		elevator = true


func _on_Elevator_body_exited(body):
	if body.is_in_group("player"):
		body.find_node("uprompt").visible=false
		elevator = false
