extends "player.gd"

onready var ap2 = get_node("Sprite/AnimationPlayer/AnimationPlayer2")
onready var hb = get_node("hitbox/CollisionShape2D")


func _physics_process(delta: float) -> void:
	if is_on_floor():
		hb.disabled=true
		if ap.current_animation != "jumpsqa" and is_on_floor():
			ap.play("run")
	if !Input.is_action_pressed("move_right") and ! Input.is_action_pressed("move_left") and ap.current_animation != "jumpsqa" and!hitstun and is_on_floor():
		ap.play("stand")
	if Input.is_action_pressed("move_left") and !hitstun :
		if ap.current_animation != "jumpsqa" and is_on_floor():
			ap.play("run")
		
	# jump will happen on the next frame
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() and !hitstun:
			ap2.play("jump")
	if Input.is_action_just_pressed("jump") and ap.current_animation == "airidle":
		ap.play("dash")
		hb.disabled=false
		if sprite.flip_h == true:
			velocity=Vector2(-800,-700)
		if sprite.flip_h == false:
			velocity=Vector2(800,-700)

func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		area._die()
