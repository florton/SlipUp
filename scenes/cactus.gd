extends RigidBody2D

var rng = RandomNumberGenerator.new()

var x_min = -1000
var x_max = 1000

var direction = 1

func init(x0, x1):
	x_min = x0
	x_max = x1

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	direction = 1 if rng.randf() > 0.5 else -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += direction
	if position.x < x_min:
		direction = 1
	if position.x > x_max:
		direction = -1
