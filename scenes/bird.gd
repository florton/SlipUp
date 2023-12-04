extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var i = abs(Global.rngseed.seed %10)
	print(i)
	if i   <= 3:
		$AnimationPlayer.play("empty")
	if i >3 and i<8:
		$AnimationPlayer.play("bird")
	if i >7 and i<10:
		$AnimationPlayer.play("ctoe")
	if i  ==10:
		$AnimationPlayer.play("bunny")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


	
#	pass
