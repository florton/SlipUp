extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var door = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("up") and door:
		get_tree().change_scene("res://scenes/hub.tscn")
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		door=true
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	door=false
	pass # Replace with function body.
