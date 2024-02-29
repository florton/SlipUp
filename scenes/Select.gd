extends Node2D

const Ninja = preload("res://scenes/ninja.tscn")
const Guy = preload("res://scenes/guy.tscn")
const Rman = preload("res://scenes/rocketman.tscn")
onready var player = get_parent().get_node("KinematicBody2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.savedata.character == "ninja":
		var ninja = Ninja.instance()
		ninja.global_position =Vector2 (player.global_position.x,player.global_position.y-20)
		player.queue_free()
		player = ninja
		get_parent().call_deferred("add_child", ninja)

func _on_Guy_body_entered(body):
	if body.is_in_group("player"):
		if Global.savedata.character != "guy":
			Global.savedata.character = "guy"
			var guy = Guy.instance()
			guy.global_position = player.global_position
			player.queue_free()
			player = guy
			get_parent().add_child(guy)
			Global.save_data()


func _on_Ninja_body_entered(body):
	if body.is_in_group("player"):
		if Global.savedata.character != "ninja":
			Global.savedata.character = "ninja"
			var ninja = Ninja.instance()
			ninja.global_position = player.global_position
			player.queue_free()
			player = ninja
			get_parent().add_child(ninja)
			Global.save_data()


func _on_rman_body_entered(body):
	if body.is_in_group("player"):
		if Global.savedata.character != "rman":
			Global.savedata.character = "rman"
			var rman = Rman.instance()
			rman.global_position = player.global_position
			player.queue_free()
			player = rman
			get_parent().add_child(rman)
			Global.save_data()

	pass # Replace with function body.
