extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var savebutton = preload("res://scenes/savemenubtn.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
#	var savebutton1=$ScrollContainer/VBoxContainer/save1
	var saves = Global.saves
	var c = 0
	for save in saves:
		if save:
			c+=1
			var button= savebutton.instance()
			button.set_data(save,c)
			$ScrollContainer/VBoxContainer.add_child(button)
			button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
