extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var level= 32
var gapsizemax=30
var dif
var cell= Vector2(32,2)


# Called when the node enters the scene tree for the first time.
func _ready():
	level -= 7
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if level>=70:
		if cell.y<=32:
			self.set_cell(cell.x,cell.y,1)
			cell.y=+1
		else:
			level -= 7
			cell.x ==2 
		pass
	pass # Replace with function body.

#	pass
