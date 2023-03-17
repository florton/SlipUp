extends Node2D

const Ninja = preload("res://scenes/ninja.tscn")

onready var player = get_node("KinematicBody2D")

var door = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.character == "ninja":
		var ninja = Ninja.instance()
		ninja.global_position = player.global_position
		ninja.scale = player.scale
		player.queue_free()
		player = ninja
		get_parent().call_deferred("add_child", ninja)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("up") and door:
		player.queue_free()
		get_tree().change_scene("res://scenes/hub.tscn")
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		door=true
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	door=false
	pass # Replace with function body.
