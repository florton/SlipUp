extends Area2D

var x_min = 1
var x_max = 30

var direction = 1

func init(x0, x1):
	print(x_min, null, x_max)
	x_min = x0
	x_max = x1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += direction
	if position.x < x_min:
		direction = 1
	if position.x > x_max:
		direction = -1
