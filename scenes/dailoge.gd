extends Node2D


# Declare member variables here. Examples:
# var a = 2
var isPlaying = false
var prevText = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/Label.visible_characters=0
	$Panel.visible = false
	$AnimationPlayer.play("dpopout")
	#_display_text(b,2)
	pass # Replace with function body.

func _display_text(text,textspeed):
	if !isPlaying || text != prevText:
		prevText = text
		isPlaying = true
		$Panel.visible = true
		$AnimationPlayer.play("dpopin")
		$Panel/Label.text=text
		for c in text.length():
			if text != prevText:
				return
			$Panel/Label.visible_characters=c
			yield(get_tree().create_timer(textspeed),"timeout")
		yield(get_tree().create_timer(.5),"timeout")
		$AnimationPlayer.play("dpopout")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "dpopout":
		isPlaying = false
		$Panel.visible = false
