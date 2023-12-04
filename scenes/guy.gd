extends "player.gd"

onready var gb= get_node("grabbox/grabbox")

var grab = false
onready var grabtimer= get_node("grab Timer")

func _physics_process(delta: float) -> void:
	moveDisabled = grab
	if ap.current_animation != "jsqaut" and !hitstun and is_on_floor():
		gb.disabled=true
		ap.play("WALK")
	if !Input.is_action_pressed("move_right") and ! Input.is_action_pressed("move_left") and ap.current_animation != "jsqaut" and !hitstun and is_on_floor():
		ap.play("STAND")
	if Input.is_action_pressed("move_left") and !hitstun and ! grab:
		if ap.current_animation != "jsqaut" and is_on_floor():
			gb.disabled=true
			ap.play("WALK")
	if !is_on_floor()and ap.current_animation!= "jsquat" and !hitstun and ap.current_animation != "grab":
		ap.play("air idle")
	#else:
	#	ap.play("STAND")
	# apply gravity
	# player always has downward velocity

	#grab
	if grab:
		_grab()

	# jump will happen on the next frame
	if Input.is_action_pressed("jump"):

		if is_on_floor() and !hitstun:
			ap.play("jsqaut")
	if Input.is_action_just_pressed("jump") and ap.current_animation == "air idle":
		ap.play("grab")

func _on_grabbox_area_entered(area):
	if area.is_in_group("enemy"):
		enemy=area
		grab=true
		gravity=0
		velocity=Vector2.ZERO
		grabtimer.start(0)
		return area

func _on_grab_Timer_timeout():
	grab = false
	gravity=2000
	enemy._throw_up()

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


func _on_prejump_timeout():
	
	pass # Replace with function body.
