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
		if $Sprite.flip_v:
			$Sprite.flip_v=false
		if state==0 and Input.is_action_pressed("move_left") or state==0 and Input.is_action_pressed("move_right"):
			state=1
			$Sprite.animation="running"
			pass
		if state==0:
			$Sprite.animation="default"
		pass
		
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() and state<2:
			state=2
			$Sprite/AnimationPlayer.play("jsquat")
		if state!=3 and !is_on_floor():
			state=3
			$Sprite.animation="dive"
			velocity=Vector2.ZERO
			velocity.y-=500
			
			
	if state==3:
		velocity.x=0
		if velocity.y>0:
			$Sprite.flip_v=true
		
	pass
