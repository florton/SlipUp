extends Area2D

var rng = RandomNumberGenerator.new()
onready var Coin = preload("res://scenes/coin.tscn")
var x_min = -1000
var x_max = 1000
var thrown= false
var dying = false
var speed = 0

export var can_hurt = true

var direction = 1
var ydirection = 0
onready var part= get_node("Particles2D")

func init(x0, x1):
	x_min = x0
	x_max = x1

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	direction = 1 if rng.randf() > 0.5 else -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !dying:
		position.x += direction
		position.y += ydirection
		if position.x < x_min:
			if thrown:
				_die()
			direction = 1
		if position.x > x_max:
			if thrown:
				_die()
			direction = -1
	if direction != 0:
		scale.x = direction * -1
	if dying and !part.emitting:
		queue_free()

func _on_Area2D_body_entered(body):
	if can_hurt:
		if body.is_in_group("player") && !thrown:
			body.takeDamage()

func _on_Area2D_area_entered(area):
	if area.get_name()== "grabbox":
		direction=0
	if area.is_in_group("enemy") and thrown:
		area._die()
		_die()
	
func _throw_up():
	thrown=true
	direction=0
	ydirection=-5
	
func _throw_down():
	thrown=true
	direction=0
	ydirection=5

func _throw_right():
	thrown=true
	direction=5
	ydirection=0

func _throw_left():
	thrown=true
	direction=-5
	ydirection=0

func _throw_upright():
	thrown=true
	direction=1
	ydirection=-1

func _throw_upleft():
	thrown=true
	direction=-1
	ydirection=-1
	
func _throw_downright():
	thrown=true
	direction=1
	ydirection=1
	
func _throw_downleft():
	thrown=true
	direction=-1
	ydirection=1
	
func _die():
		part.emitting = true
		dying= true
		var c=Coin.instance()
		var parent = get_parent().get_parent()
		parent.add_child(c)
		c.global_position=global_position
		# print(parent)

