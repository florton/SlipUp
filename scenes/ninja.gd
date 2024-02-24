extends "player.gd"

onready var ap2 = get_node("Sprite/AnimationPlayer/AnimationPlayer2")
#onready var hb = get_node("hitbox/CollisionShape2D")
#onready var db = get_node("hitbox/CollisionShape2D")

var isDashing = false

func _physics_process(delta: float) -> void:
	if is_on_floor():
		isDashing = false
		# invinc = false
		if ap.current_animation != "jumpsqa" and !hitstun:
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
	if Input.is_action_just_pressed("jump") and ap.current_animation == "airidle" and !hitstun:
		ap.play("dash")
		isDashing = true
		if sprite.flip_h == true:
			velocity=Vector2(-500,-400)
		if sprite.flip_h == false:
			velocity=Vector2(500,-400)

func _on_hitbox_area_entered(area):
	if area.is_in_group("enemy") && isDashing:
		if velocity.x>0:
			area._throw_upright()
		else:
			area._throw_upleft()
		#area._die()
