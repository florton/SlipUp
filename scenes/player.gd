extends KinematicBody2D

export var move_speed := 3
export var acc_speed := 2
export var vertical_speed_modifier := 70
export var gravity := 2000
var invinc = false
onready var sprite = get_node("Sprite")
onready var ap = get_node("Sprite/AnimationPlayer")
var in_turnaround =false
var turntimer=0

var velocity := Vector2.ZERO
var jump_speed = 700
#var lasgroundpos= Array()
var hitstun=false
var acceleration = 0
var gpymod =0
var prevgpy =-1
var enemy
var enemyingbo
var heath=3
var moveDisabled = false
var hitstun_time = 1

signal dead 
signal get_coin

func _physics_process(delta: float) -> void:
	acceleration = acceleration * 0.5
	
	if hitstun:
		acceleration = 0
	
	# set horizontal velocity
	if !hitstun and ! moveDisabled and !in_turnaround:
		if Input.is_action_pressed("move_right"):
			
			if velocity.x <=-200 :
				turntimer+=delta
				
				if turntimer>=.3:
					if self.is_on_floor():
						turntimer=0
						turn_around()
					else:
						turntimer=0
						air_turn_around()
			else:
				velocity.x += move_speed
				acceleration += acc_speed
		if Input.is_action_pressed("move_left"):
			if velocity.x >=200:
				turntimer-=delta

				if turntimer<=-.4:
					if self.is_on_floor():
						turntimer=0
						turn_around()
					else:
						turntimer=0
						air_turn_around()
			else:
				velocity.x -= move_speed
				acceleration -= acc_speed
		if Input.is_action_just_released("move_left"):
			if turntimer<0&&turntimer>-.4:
				velocity.x*=.2
				turntimer=0
				print("ok")
		if Input.is_action_just_released("move_right") :
			if turntimer>0&&turntimer<.4:
				velocity.x*=.2
				turntimer=0
	velocity.y += gravity * delta
	if velocity.y < 0:
		velocity.y -= abs(velocity.x / vertical_speed_modifier)
	velocity.x += acceleration
	acceleration *= 0.9
	if velocity.x <0:
		sprite.flip_h = !Global.backwards
	if velocity.x >0:
		sprite.flip_h = Global.backwards
	
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
			break

	if Input.is_action_just_released("jump") and ap.current_animation == "jsqaut"  and !hitstun and ap.current_animation_position < .35:
		ap.play("air idle")
		velocity.y= -jump_speed 


func fullhop():
	velocity.y= -jump_speed - 150
	
func takeDamage():
	if !hitstun and !invinc:
		velocity=Vector2.ZERO
		hitstun=true
		ap.play("hurt")
		heath-=1
		yield(get_tree().create_timer(hitstun_time), "timeout")
		hitstunend()
		
func getCoin():
	emit_signal("get_coin")

func hitstunend():
	hitstun= false
	if self.is_on_floor():
		ap.play("STAND")
	else:
		ap.play("air idle")
	sprite.modulate = Color("#FFFFFF")

func fallDown():
	invinc=false
	takeDamage()
	if heath <= 0:
		return
	var floors = get_parent().find_node("FloorMap").floor_coords
	while !get_parent().playerOnScreen:
		var found_floor = 0
		for i in range(100):
			if (floors.has(floor(position.y) - i)):
				found_floor = floor(position.y) - i
		if found_floor == 0:
			self.global_position.y -= 100
			yield(get_tree().create_timer(0.001), "timeout")
		else:
			var x = floor(len(floors[found_floor])/2)
			self.global_position = floors[found_floor][x]
			self.global_position.y -= 15
			yield(get_tree().create_timer(0.001), "timeout")
func turn_around():
	in_turnaround=true
	var curntvelo=velocity.x
	velocity.x=velocity.x * .5
	var t= Timer.new()
	t.set_wait_time(.02)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t,"timeout")
	velocity.x=0
	t.queue_free()
	t= Timer.new()
	t.set_wait_time(.02)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t,"timeout")
	velocity.x = curntvelo*-.9
	in_turnaround=false
	t.queue_free()
func air_turn_around():
	in_turnaround=true
	var curntvelo=velocity.x
	velocity.x=velocity.x * .8
	var t= Timer.new()
	t.set_wait_time(.05)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t,"timeout")
	velocity.x=0
	t.queue_free()
	t= Timer.new()
	t.set_wait_time(.05)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t,"timeout")
	velocity.x = curntvelo*-.5
	t.queue_free()
	in_turnaround=false

	
