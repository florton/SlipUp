extends KinematicBody2D

export var move_speed := 4
export var acc_speed := 4
export var gravity := 2000
onready var sprite = get_node("Sprite")
onready var ap = get_node("Sprite/AnimationPlayer")
var velocity := Vector2.ZERO
var jump_speed = 700

var acceleration = 0

func _physics_process(delta: float) -> void:
	# reset horizontal velocity
#	velocity.x = 0
	acceleration = acceleration * 0.3
	# set horizontal velocity
	if Input.is_action_pressed("move_right"):
		velocity.x += move_speed
		acceleration += acc_speed
		if ap.current_animation != "jsqaut":
			ap.play("WALK")
	if !Input.is_action_pressed("move_right") and ! Input.is_action_pressed("move_left") and ap.current_animation != "jsqaut":
		ap.play("STAND")
	if Input.is_action_pressed("move_left"):
		velocity.x -= move_speed
		acceleration -= acc_speed
		if ap.current_animation != "jsqaut":
			ap.play("WALK")
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

	# actually move the player
#	velocity = move_and_slide(velocity, Vector2.UP)
#	var collide = move_and_collide(velocity * delta)
	var prevVelocity = velocity
	velocity = move_and_slide(velocity, Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision && collision.collider.is_in_group("wall"):
			velocity.x = prevVelocity.x * -0.8
			velocity.y *= 1.1
#			velocity = velocity.bounce(collision.normal)
			acceleration *= -1
			print("Collided with: ", collision.collider.name)
			break
#	if collide && collide.collider.is_in_group("wall"):
#	if collide:
		
#	else:
#		velocity = move_and_slide(velocity, Vector2.UP)

	if Input.is_action_just_released("jump") and ap.current_animation == "jsqaut" and ap.current_animation_position < .35:
		ap.play("air idle")
		velocity.y= -jump_speed 
		
		pass
		
	# jump will happen on the next frame
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			ap.play("jsqaut")
			print ("jump")
	#print(velocity)
	print(ap.current_animation_position)

func fullhop():
	velocity.y= -jump_speed - 150
