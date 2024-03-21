extends Node2D

var door = false

func _ready():
	$Kramer/Face.visible = false

var txt = "Oh hey so you made it up here too huh? Nice work, but it looks like the floors above collapsed, maybe theyll get fixed soon...  "
func _on_Kramer_body_entered(body):
	if body.is_in_group("player"):
		$dailoge._display_text(txt,.1, 4)
		if !$Kramer/AnimationPlayer.is_playing():
			$Kramer/AnimationPlayer.play("fadein")
			$Kramer/Face.visible = true

func _on_Door_body_entered(body):
	if body.is_in_group("player"):
		door=true

func _on_Door_body_exited(body):
	if body.is_in_group("player"):
		door=false

func _process(delta):
	if Input.is_action_pressed("up"):
		if door:
			get_tree().change_scene("res://scenes/ending.tscn")
