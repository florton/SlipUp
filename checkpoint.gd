extends Node2D


# Declare member variables here. Examples:
const Guy= preload("res://scenes/guy.tscn") 
const Ninja= preload("res://scenes/ninja.tscn") 
var player

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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hole_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://scenes/tower.tscn")
