extends KinematicBody2D

export var move_speed := 4
export var acc_speed := 4
export var gravity := 2000
onready var sprite = get_node("Sprite")
onready var ap = get_node("Sprite/AnimationPlayer")

var velocity := Vector2.ZERO
var jump_speed = 700
var lasgroundpos= Array()
var hitstun=false
var acceleration = 0
var gpymod =0
var prevgpy =-1
var enemy
var enemyingbo
var heath=3
var moveDisabled = false

signal dead 
signal get_coin

func _ready():
	lasgroundpos.push_front(global_position)

func _physics_process(delta: float) -> void:
	acceleration = acceleration * 0.3
	
	if hitstun:
		acceleration = 0
	
	# set horizontal velocity
	if Input.is_action_pressed("move_right") and!hitstun and !moveDisabled:
		velocity.x += move_speed
		acceleration += acc_speed
	if Input.is_action_pressed("move_left") and !hitstun and ! moveDisabled:
		velocity.x -= move_speed
		acceleration -= acc_speed
	velocity.y += gravity * delta
	
	velocity.x += acceleration
	acceleration *= 0.9
	if velocity.x <0:
		sprite.flip_h = true
	if velocity.x >0:
		sprite.flip_h = false
	if is_on_floor():
			lasgroundpos.push_front(global_position)
			lasgroundpos.resize(clamp(lasgroundpos.size(), 1, 15))
	
	#grab
	# if grab:
	# 	_grab()
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


func fullhop():
	velocity.y= -jump_speed - 150
	
func takeDamage():
	if !hitstun:
		velocity=Vector2.ZERO
		hitstun=true
		ap.play("hurt")
		heath-=1
		yield(get_tree().create_timer(2), "timeout")
		hitstunend()
		
func getCoin():
	emit_signal("get_coin")

func hitstunend():
	hitstun= false
	if self.is_on_floor():
		ap.play("STAND")
	else:
		ap.play("air idle")

func fallDown():
	takeDamage()
	self.global_position=lasgroundpos[lasgroundpos.size() - 8]
