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
		print(prop1.name, typeof(save_copy.get(prop1.name)))
		if Global.savedata.get(prop1.name):
			if typeof(save_copy.get(prop1.name)) == 17:
				var character_copy = save_copy.get(prop1.name).duplicate()
				for prop2 in Global.savedata.get(prop1.name).get_property_list():
					character_copy.set(prop2.name, Global.savedata.get(prop1.name).get(prop2.name))
				save_copy.set(prop1.name, character_copy)
			else:
				save_copy.set(prop1.name, Global.savedata.get(prop1.name))
	Global.savedata = save_copy

func set_data(save,numb):
	data = save
	if data.character=="guy":
		$Sprite.frame=1
	else:
		$Sprite.frame = 2
	$savelabel.text = "save\n" +str(numb)
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
