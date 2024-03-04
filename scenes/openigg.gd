extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		changescene()
		
func changescene():
	get_tree().change_scene("res://scenes/hub.tscn")
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func runtext():
	for s in 26:
		$AnimationPlayer/Label.lines_skipped+=3
		yield(get_tree().create_timer(7),"timeout")
		pass
	pass
