extends Node2D



# Declare member variables here. Examples:
# var a = 2

#func load_data(save1):
	#	var save = ResourceLoader.load(save1)
	##	if save is Global.new(): # Check that the data is valid
		#	return save
		#else:
		#	print("nodata")
# Called when the node enters the scene tree for the first time.

func _ready():
	$newgamebutton.grab_focus()
	
#	Global.load_data("res://customres/save1.tres")
#	var s1 = "user://customres/save1.tres"
#	var loaddata = Global.load_data(s1)
#	print(loaddata)
	if ResourceLoader.exists("user://save1.tres"):
		$countbutton.disabled=false
#		print(loaddata)
#		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_New_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.button_index == 1 && event.pressed):
		get_tree().change_scene_to(load('res://scenes/hub.tscn'))


func _on_Quit_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.button_index == 1 && event.pressed):
		get_tree().change_scene_to(load('res://scenes/outside.tscn'))


func _on_newgamebutton_pressed():
	Global.currentsave+=1 
	Global.save_data()
# Load opening here
	get_tree().change_scene_to(load('res://scenes/openigg.tscn'))
	pass # Replace with function body.


func _on_countbutton_pressed():
	$countbutton/Panel.visible=true
	
	pass # Replace with function body.
