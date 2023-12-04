extends Node


# Declare member variables here. Examples:
export var currentsave = 0
var savedata
var playtime  = 0
# var b = "text"
#var saveresource = get_child(0)
export (Array,Resource) var saves
# Called when the node enters the scene tree for the first time.
func _ready():
	var save1="res://customres/blank_save.tres"
	savedata = load_data("res://customres/blank_save.tres")
	for i in range(100):
	
		var data = load_data("user://save" + str(i) + ".tres")
		if data:
			currentsave += 1
			saves.append(data)
	
	
func add_a_save():
	var savedatta2 = savedata
	saves.append(savedatta2)
	pass

func save_data():
	ResourceSaver.save("user://save" + str(currentsave) + ".tres",savedata,2)
	
func load_data(save1):
	if ResourceLoader.exists(save1):
		var save = ResourceLoader.load(save1)
		if save : # Check that the data is valid
			return save
		else:
			print("nodata")
			
func _process(delta):
	playtime += delta
	print(playtime)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
