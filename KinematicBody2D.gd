extends KinematicBody2D

export var move_speed := 4
export var acc_speed := 4
export var gravity := 2000
onready var sprite = get_node("Sprite")
onready var ap = get_node("Sprite/AnimationPlayer")
onready var cam = get_node("Camera2D")
onready var gb= get_node("grabbox/grabbox")
var grab = false
var velocity := Vector2.ZERO
var jump_speed = 700
var lasgroundpos= Array()
var hitstun=false
onready var grabtimer= get_node("grab Timer")
var acceleration = 0
var gpymod =0
var prevgpy =-1
var enemy
var enemyingbo
var heath=3


signal dead 


func _physics_process(delta: float) -> void:
	acceleration = acceleration * 0.3
	
	# set horizontal velocity
	if Input.is_action_pressed("move_right") and!hitstun and!grab:
		velocity.x += move_speed
		acceleration += acc_speed
		if ap.current_animation != "jsqaut" and is_on_floor():
			gb.disabled=true
			ap.play("WALK")
	if !Input.is_action_pressed("move_right") and ! Input.is_action_pressed("move_left") and ap.current_animation != "jsqaut" and!hitstun and is_on_floor():
		ap.play("STAND")
	if Input.is_action_pressed("move_left") and !hitstun and ! grab:
		velocity.x -= move_speed
		acceleration -= acc_speed
		if ap.current_animation != "jsqaut" and is_on_floor():
			gb.disabled=true
			ap.play("WALK")
	if !is_on_floor()and ap.current_animation!= "jsquat" and !hitstun and ap.current_animation != "grab":
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
	
	#grab
	if grab:
		_grab()
	if heath<=0:
		emit_signal("dead")
		pass
	
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
	if Input.is_action_just_pressed("jump") and ap.current_animation == "air idle":
		ap.play("grab")
	#print(ap.current_animation_position)
	

func fullhop():
	velocity.y= -jump_speed - 150

func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	takeDamage()
	self.global_position=lasgroundpos[14]
	
func takeDamage():
	if !hitstun:
		velocity=Vector2.ZERO
		hitstun=true
		ap.play("hurt")
		heath-=1

func hitstunend():
	hitstun= false
	if self.is_on_floor():
		ap.play("STAND")
	else:
		ap.play("air idle")


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		enemy=area
		grab=true
		gravity=0
		velocity=Vector2.ZERO
		grabtimer.start(0)
		return area
		pass
	pass # Replace with function body.


func _on_grab_Timer_timeout():
	grab = false
	gravity=2000
	enemy._throw_up()
	
	pass # Replace with function body.

func _grab():
	grabtimer.stop()
	gb.disabled = true
	if Input.is_action_pressed("move_right") and ! Input.is_action_pressed("up") and ! Input.is_action_pressed("down"):
		enemy._throw_right()
		grab=false
		gravity=2000
		velocity=Vector2(-200,-600)
	if Input.is_action_pressed("move_left")  and ! Input.is_action_pressed("up") and ! Input.is_action_pressed("down"):
		enemy._throw_left()
		grab=false
		gravity=2000
		velocity=Vector2(200,-600)
	if Input.is_action_pressed("up") and ! Input.is_action_pressed("move_right") and ! Input.is_action_pressed("move_left"):
		enemy._throw_up()
		grab=false
		gravity=2000
		velocity=Vector2(0,-600)
	if Input.is_action_pressed("down")and ! Input.is_action_pressed("move_right") and ! Input.is_action_pressed("move_left"):
		enemy._throw_down()
		grab=false
		gravity=2000
		velocity=Vector2(0,-800)
		
	if Input.is_action_pressed("move_right") and  Input.is_action_pressed("up") and ! Input.is_action_pressed("down"):
		enemy._throw_upright()
		grab=false
		gravity=2000
		velocity=Vector2(-200,-600)
	if Input.is_action_pressed("move_left")  and ! Input.is_action_pressed("up") and  Input.is_action_pressed("down"):
		enemy._throw_downleft()
		grab=false
		gravity=2000
		velocity=Vector2(200,-800)
	if Input.is_action_pressed("up") and ! Input.is_action_pressed("move_right") and Input.is_action_pressed("move_left"):
		enemy._throw_upleft()
		grab=false
		gravity=2000
		velocity=Vector2(-200,-600)
	if Input.is_action_pressed("down")and Input.is_action_pressed("move_right") and ! Input.is_action_pressed("move_left"):
		enemy._throw_downright()
		grab=false
		gravity=2000
		velocity=Vector2(200,-800)


func _on_Area2D_body_entered(body):
	if Input.is_action_pressed("up"):
		pass
	pass # Replace with function body.

