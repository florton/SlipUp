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


func _on_New_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.button_index == 1 && event.pressed):
		get_tree().change_scene_to(load('res://scenes/hub.tscn'))


func _on_Quit_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.button_index == 1 && event.pressed):
		get_tree().change_scene_to(load('res://scenes/outside.tscn'))
