extends Node2D

const Ninja = preload("res://scenes/ninja.tscn")

onready var player = get_node("KinematicBody2D")
onready var text = get_node("Text")

var rng = RandomNumberGenerator.new()
var door = false
var ninjabox = false
var totalCoins =0
var oldtext

var phrases = [
	"You can do it",
	"One more try?",
	"Fancy a beer?",
	"Don't Slip Up!",
	"Where are all the pretty ladies?",
	"I had a dream like this once",
	"I heard there's a top floor to this tower",
	"Want to buy some magic beans?",
	"Hey what's your name?",
	"I think I'm trapped here",
	"This is like that scene in The Shining",
	"Wow you're very handsome",
	"Don't you have better things to do?",
	"Fancy a beer or a bottle of wine?",
	"You remind me of my grandmother",
	"You remind me of my ex-husband",
	"You remind me of that new celebrity",
	"Got any smokes?",
	"This is kind of a boring bar huh?",
	"Know any good knock knock jokes?",
	"Sorry we're closed right now",
	"Up Up Down Down Left Right Left Right B A Select Start",
	"Somebody call a Doctor!",
	"My right thigh itches",
	"I'm a big fan of reality TV",
	"Want a shot of vodka?",
	"How about a dram of scotch?",
	"We're running a $5 special on pitchers",
	"Make sure to tell your friends about us",
	"Youre one in a hundred million",
	"I don't like spiders",
	"I love spiders",
	"Got any jacks?",
	"You ever hear the one about the old man and the broccoli?",
	"I'm so excited for my birthday next week!",
	"Looks like it might rain",
	"Can I interest you in an absinthe?",
	"Would you like some shitake mushrooms?",
	"You're not very good at this are you?",
	"Check out more Handcrafted Games!",
	"I think you're really cute",
	"I think you're really ugly",
	"Phew what's that smell?",
	"Well, time to hit the hay",
	"The only thing we have to fear is fear itself",
	"Three can keep a secret, if two of them are dead",
	"All the world’s a stage, and all the men and women merely players",
	"Frankly, my dear, I don't give a damn",
	"He travels the fastest who travels alone",
	"If you want something done right, do it yourself",
	"Speak softly and carry a big stick",
	"Two roads diverged in a yellow wood",
	"Can't get fooled again",
	"Ships at a distance have every man’s wish on board",
	"Boo!"
]

# Called when the node enters the scene tree for the first time.
func loadData():
	var file = File.new()
	file.open("user://save.dat", File.READ)
	var content = file.get_as_text()
	var values = content.split("|")
	if (len(values) > 1):
		totalCoins = int(values[1])
func _ready():
	rng.randomize()
	text.text = phrases[rng.randi_range(0, len(phrases)-1)]
	Global.savedata.coins 
	if !Global.savedata.ninjaunlocked:
		var ninja = get_child(4)
		ninja.visible = true
		pass 
	if Global.savedata.character == "ninja":
		var ninja = Ninja.instance()
		ninja.global_position = player.global_position
		ninja.scale = player.scale
		player.queue_free()
		player = ninja
		get_parent().call_deferred("add_child", ninja)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("up"):
		if door:
			player.queue_free()
			get_tree().change_scene("res://scenes/hub.tscn")
		if ninjabox and Global.savedata.coins  >= 10 :
			Global.savedata.coins -= 10
			Global.savedata.ninjaunlocked=true
			Global.save_data()
			pass
			
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		door=true
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	door=false
	pass # Replace with function body.


func _on_ninjabox_body_entered(body):
	if body.is_in_group("player") && !Global.savedata.ninjaunlocked:
		oldtext = text.text
		text.text = "For 10 coins i'll join in"
		ninjabox = true
		pass
	pass # Replace with function body.


func _on_ninjabox_body_exited(body):
	if body.is_in_group("player"):
		text.text = oldtext
		ninjabox = false
	pass # Replace with function body.
