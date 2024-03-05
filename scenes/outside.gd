extends Node2D

const Guy= preload("res://scenes/guy.tscn") 
const Ninja= preload("res://scenes/ninja.tscn") 
const rman= preload("res://scenes/rocketman.tscn") 
var vend=false
var player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.backwards = true
	if Global.savedata.character=="guy":
		var player=Guy.instance()
		player.global_position=Vector2(798,528)
		self.add_child(player)
	if Global.savedata.character=="ninja":
		var player=Ninja.instance()
		player.global_position=Vector2(798,528)
		self.add_child(player)
	if Global.savedata.character=="rman":
		var player=rman.instance()
		player.global_position=Vector2(798,528)
		self.add_child(player)
		
		pass
	pass # Replace with function body.
func _process(delta):
	$coinsLabel.text="Coins: "+str(Global.savedata.coins)
	if Input.is_action_pressed("up"):
		if vend:
			$Vend/Panel.visible=true
			$AnimationPlayer.play("store popin")
			Global.paused=true
			$Vend/Panel/Button.grab_focus()
			#player.velocity=Vector2.ZERO
			
			pass
		pass
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		$KinematicBody2D/uprompt.visible=true
		body.velocity.x *=.5
		vend =true
	pass # Replace with function body.


func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	
	if body.is_in_group("player"):
		$KinematicBody2D/uprompt.visible=false
		vend =false
		#$Sprite/Panel.visible=false
		#$AnimationPlayer.play("store popout")
	pass # Replace with function body.


func _on_door_body_entered(body):
	if body.is_in_group("player"):
		Global.backwards = false
		get_tree().change_scene("res://scenes/hub.tscn")
	pass # Replace with function body.





func _on_well_ch():
	$KinematicBody2D.change_hat()
	pass # Replace with function body.


func _on_Button3_pressed():
	$AnimationPlayer.play("store popout")
	Global.paused=false
	
	pass # Replace with function body.





func _on_xButton_pressed():
	pass # Replace with function body.
