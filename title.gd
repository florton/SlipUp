extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Label_mouse_entered():
	print("s")
	if Input.is_action_just_pressed("click"):
		get_tree().change_scene("res://scenes/hub.tscn")
	pass # Replace with function body.


func _on_Button_pressed():
	print("s")
	get_tree().change_scene("res://scenes/hub.tscn")
	pass # Replace with function body.
