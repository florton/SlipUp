extends Node2D

const Guy= preload("res://scenes/guy.tscn") 
const Ninja= preload("res://scenes/ninja.tscn") 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.savedata.character=="guy":
		var guy=Guy.instance()
		add_child(guy)
	if Global.savedata.character=="ninja":
		var ninja=Ninja.instance()
		add_child(ninja)
		pass
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
