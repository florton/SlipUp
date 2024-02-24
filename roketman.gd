extends "res://scenes/player.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_on_floor():
		state=0
		if state==0 and Input.is_action_pressed("move_left") or state==0 and Input.is_action_pressed("move_right"):
			state=1
			$Path2D/PathFollow2D/Sprite.animation="running"
			pass
		if state==0:
			$Path2D/PathFollow2D/Sprite.animation="default"
		pass
		
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() and state<2:
			state=2
			$Path2D/PathFollow2D/Sprite/AnimationPlayer.play("jsquat")
		else:
			velocity=Vector2.ZERO
			$Path2D/PathFollow2D.offset+=1
			
			
		
	pass
