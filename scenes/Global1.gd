extends Node2D


# Declare member variables here. Examples:
export var currentsave =0
var savedata
# var b = "text"
#var saveresource = get_child(0)
export (Array,Resource) var saves
# Called when the node enters the scene tree for the first time.
func _ready():
	var save1="res://customres/save1.tres"
	saves[0] = load_data(save1)
	savedata=saves[0]
	pass # Replace with function body.
func add_a_save():
	var savedatta2 = savedata
	saves[currentsave+1]=savedatta2
	pass
func save_data():
	ResourceSaver.save("res://customres/save1.tres",savedata)
func load_data(save1):
	if ResourceLoader.exists(save1):
		var save = ResourceLoader.load(save1)
		if save : # Check that the data is valid
			return save
		else:
			print("nodata")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
