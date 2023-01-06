extends KinematicBody2D

export var move_speed := 10
export var acc_speed := 10
export var gravity := 2000

var velocity := Vector2.ZERO

var acceleration = 0

func _physics_process(delta: float) -> void:
	# reset horizontal velocity
#	velocity.x = 0
	acceleration = acceleration * 0.5
	# set horizontal velocity
	if Input.is_action_pressed("move_right"):
		velocity.x += move_speed
		acceleration += acc_speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= move_speed
		acceleration -= acc_speed

	# apply gravity
	# player always has downward velocity
	velocity.y += gravity * delta
	
	velocity.x += acceleration
	acceleration *= 0.9
	
	print(velocity)

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

	var jump_speed = 1000
	# jump will happen on the next frame
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_speed # negative Y is up in Godot
	print(velocity)
