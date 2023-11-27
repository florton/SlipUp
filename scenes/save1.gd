extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var data
var sprite
var label
var curntsave
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $Sprite
	label=$savelabel
	pass # Replace with function body.

func set_data(save,numb):
	data = save
	if data.character=="guy":
		$Sprite.frame=1
	else:
		$Sprite.frame = 2
	$savelabel.text = "save " +str(numb)
	$Button/Label.text = str(data.coins)+"  "+str(data.highscore)
	curntsave = numb
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	Global.currentsave = curntsave
	Global.savedata = data
	get_tree().change_scene("res://scenes/hub.tscn")
	pass # Replace with function body.
