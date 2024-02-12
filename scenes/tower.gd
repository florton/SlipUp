extends Node2D

const Ninja = preload("res://scenes/ninja.tscn")

onready var player = get_node("KinematicBody2D")
onready var healthSprite = get_node("UI/HP")
onready var scoreLabel = get_node("UI/Score")
onready var coinsLabel = get_node("UI/Coins")
onready var cam = get_node("Camera2D")
onready var pbar= get_node("pbbar")
const camera_offset_y = 50
const death_offset_y = 250

var playerStart = 525
var score = 0
var highScore = 0
var totalCoins = 0
var coins = 0
var save1 = "user://save1.res"
var playerOnScreen = true
var pget=false
var pbsettingrun=false

#func loadData():
	#var file = File.new()
	#file.open("user://save.dat", File.READ)
	#var content = file.get_as_text()
	#var values = content.split("|")
	#highScore = int(values[0]) if content else 0
	#if (len(values) > 1):
	#	totalCoins = int(values[1]) if content else 0
	#file.close()

#func saveData(newScore, totalCoins):
	#var file = File.new()
	#file.open("user://save.dat", File.WRITE)
	##var saveres= Global.new()
	#file.store_string(str(score) + "|" + str(totalCoins) + "|" + str(highscore_setter))
	#var save = ResourceSaver.save("user://save1.res", saveres)
	
	#file.close()

# Called when the node enters the scene tree for the first time.
func _ready():
	cam.global_position.y = player.global_position.y - camera_offset_y
	Global.load_data("res://customres/save1.tres")
	highScore = Global.savedata.highscore
	pbar.position.x = 1
	pbar.position.y=(1 - (highScore * 48)) + playerStart - 50
	var showPurse = Global.savedata.purse.coins!=0
	if showPurse:
		$purse.position.y=(1 - (Global.savedata.purse.lvl * 48)) + playerStart - 50
	$purse.visible = showPurse
	if Global.savedata.character == "ninja":
		var ninja = Ninja.instance()
		ninja.global_position = player.global_position
		ninja.scale = player.scale
		player.queue_free()
		player = ninja
		player.move_speed+=Global.savedata.ninja_data.speed
		player.jump_speed+=Global.savedata.ninja_data.jump_str*50
		add_child(ninja)
	player.connect("dead", self, "_on_KinematicBody2D_dead")
	player.connect("get_coin", self, "_on_KinematicBody2D_get_coin")
	if Global.savedata.character=="guy":
		player.move_speed+=Global.savedata.guy_data.speed
		player.jump_speed+=Global.savedata.guy_data.jump_str*50
	if Global.checkpoint:
		player.global_position=Global.checkpoint
		player.global_position.x -= 50
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	healthSprite.frame = player.heath
	var playerY = floor((1 - (player.position.y - playerStart)) / 48)
	if player.is_on_floor() && playerY > score:
		score = playerY
		if score> Global.savedata.purse.lvl && !pget:
			coins+=Global.savedata.purse.coins
			coinsLabel.text = str("$",coins)
			$purse.visible = false
			pget=true
		if score > highScore && !pbsettingrun:
			$UI/Sprite/AnimationPlayer.play("pb")
			pbsettingrun=true
	scoreLabel.text = str("LVL.",score)
	if player.global_position.y - camera_offset_y < cam.global_position.y:
		cam.global_position.y = player.global_position.y - camera_offset_y
	Global.Music.global_position.y = player.global_position.y
#
#	print(player.global_position.y - cam.global_position.y)
	playerOnScreen = player.global_position.y - death_offset_y <= cam.global_position.y
	if !playerOnScreen:
		player.fallDown()

func dead():
	Global.savedata.purse.lvl=score
	Global.savedata.purse.coins=coins
	if score > highScore:
		Global.savedata.highscore=score
		Global.savedata.coins+=coins
		Global.savedata.purse.lvl=0
		Global.savedata.purse.coins=0
		scoreLabel.add_color_override("font_color", '00ff28')
	Global.save_data()
	player.queue_free()

func _on_KinematicBody2D_dead():
	dead()
	if Global.checkpoint:
		get_tree().change_scene("res://scenes/checkpoint.tscn")
	else:
		get_tree().change_scene("res://scenes/hub.tscn")

func _on_KinematicBody2D_get_coin():
	coins = coins + 1
	coinsLabel.text = str("$",coins)


func _on_Checkpoint_body_entered(body):
	if body.is_in_group("player"):
		Global.checkpoint = body.global_position
		dead()
		get_tree().change_scene("res://scenes/checkpoint.tscn")
