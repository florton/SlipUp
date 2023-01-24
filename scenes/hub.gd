extends Node2D


# Declare member variables here. Examples:
var door= true
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.window_position.x = 0
	OS.window_position.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("up") and door:
		print("d")
		get_tree().change_scene("res://scenes/tower.tscn")
		pass
	pass


func _on_Area2D_body_entered(body):
	door=true
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	door==false
	pass # Replace with function body.
