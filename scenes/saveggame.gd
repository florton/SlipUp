extends Resource
class_name saveggame

export var character = "guy"
export var ninjaunlocked = false
export var coins = 0
export var highscore = 0
export var fpt = false
export var highscoresetter =1
export var checkpoint=0
export (Resource) var guy_data
export (Resource) var ninja_data
export (Resource) var rocket_data
export (Resource) var purse


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
