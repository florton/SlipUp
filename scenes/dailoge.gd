extends Node2D


# Declare member variables here. Examples:
# var a = 2
var b = "textt 5ty565y5reyretr!"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/Label.visible_characters=0

	#_display_text(b,2)
	pass # Replace with function body.

func _display_text(text,textspeed):
	$Panel/Label.text=text
	for c in text.length():
		$Panel/Label.visible_characters=c
		yield(get_tree().create_timer(textspeed),"timeout")
	yield(get_tree().create_timer(.5),"timeout")
	$AnimationPlayer.play("dpopout")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
