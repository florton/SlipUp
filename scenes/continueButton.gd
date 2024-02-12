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
	
func allowOldSaves():
	var blank_save = ResourceLoader.load(("res://customres/blank_save.tres"))
	var save_copy = blank_save.duplicate()
	for prop1 in blank_save.get_property_list():
		var character = Global.savedata.get(prop1.name)
		if character is Object:
			for prop2 in character.get_property_list():
				if character.get(prop2.name):
					pass
				else:
					save_copy.get(prop1.name).set(prop2.name, blank_save.get(prop1.name).get(prop2.name))
		else:
			save_copy.set(prop1.name, blank_save.get(prop1.name))
	Global.savedata= save_copy

#	var characters = ["guy_data", ]
#	cons save
#	blank_save.
	print()
#	savedata

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
	allowOldSaves()
	get_tree().change_scene("res://scenes/hub.tscn")
	pass # Replace with function body.
