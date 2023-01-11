extends KinematicBody2D

export var move_speed := 4
export var acc_speed := 4
export var gravity := 2000
onready var sprite = get_node("Sprite")
onready var ap = get_node("Sprite/AnimationPlayer")
onready var cam = get_node("Camera2D")
var velocity := Vector2.ZERO
var jump_speed = 700
var lasgroundpos= Array()
var hitstun=false

var acceleration = 0
var gpymod =0
var prevgpy =-1

func _physics_process(delta: float) -> void:
	acceleration = acceleration * 0.3
	
	# set horizontal velocity
	if Input.is_action_pressed("move_right") and!hitstun:
		velocity.x += move_speed
		acceleration += acc_speed
		if ap.current_animation != "jsqaut" and is_on_floor():
			ap.play("WALK")
	if !Input.is_action_pressed("move_right") and ! Input.is_action_pressed("move_left") and ap.current_animation != "jsqaut" and!hitstun and is_on_floor():
		ap.play("STAND")
	if Input.is_action_pressed("move_left") and !hitstun:
		velocity.x -= move_speed
		acceleration -= acc_speed
		if ap.current_animation != "jsqaut" and is_on_floor():
			ap.play("WALK")
	if !is_on_floor()and ap.current_animation!= "jsquat" and !hitstun:
		ap.play("air idle")
	#else:
	#	ap.play("STAND")
	# apply gravity
	# player always has downward velocity
	velocity.y += gravity * delta
	
	velocity.x += acceleration
	acceleration *= 0.9
	if velocity.x <0:
		sprite.flip_h = true
	if velocity.x >0:
		sprite.flip_h = false
	#print(velocity)
	if is_on_floor():
		lasgroundpos.push_front(global_position)
		lasgroundpos.resize(15)
	

	# actually move the player
	var prevVelocity = velocity
	velocity = move_and_slide(velocity, Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision && collision.collider.is_in_group("wall"):
			velocity.x = prevVelocity.x * -0.8
			acceleration *= -1
			#print("Collided with: ", collision.collider.name)
			break

	if Input.is_action_just_released("jump") and ap.current_animation == "jsqaut" and ap.current_animation_position < .35:
		ap.play("air idle")
		velocity.y= -jump_speed 
		
		pass
		
	# jump will happen on the next frame
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() and !hitstun:
			ap.play("jsqaut")
			print ("jump")
	
	#print(ap.current_animation_position)

func fullhop():
	velocity.y= -jump_speed - 150

func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	takeDamage()
	self.global_position=lasgroundpos[14]
	
func takeDamage():
	velocity=Vector2.ZERO
	hitstun=true
	ap.play("hurt")
	pass # Replace with function body.

func hitstunend():
	hitstun= false
	if self.is_on_floor():
		ap.play("STAND")
	else:
		ap.play("air idle")
