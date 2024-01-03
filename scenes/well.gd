extends Sprite


# Declare member variables here. Examples:
signal ch
var state = ""
var wellmax =60

# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var i = 99#abs(Global.rngseed.seed %100)
	
	if i<25:
		state="mushroom"
		self.frame=2
		pass
	if i >24 and i<53:
		state="grave"
		self.frame=1
		pass
	if i  >52:
		wellmax=Global.rngseed.randi()%21+60
		state="well"
		self.frame=0
		pass
	pass # Replace with function body.

func get_hat():
	var hats=Global.rngseed.randi()%14
	$Sprite.frame=hats
	$Sprite.visible=true
	$AnimationPlayer.play("hat")
	if Global.savedata.character=="guy":
		Global.savedata.guy_data.hat=hats
		print(Global.savedata.guy_data.hat)
	if Global.savedata.character=="ninja":
		Global.savedata.ninja_data.hat=hats
	emit_signal("ch")
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Areawell_body_entered(body):
	if body.is_in_group("player"):
		body.velocity.x=0
		if state=="well":
			$AnimationPlayer.play("popin")
			if wellmax<0:
				$Panel/Label.text="no more coins pls"
				$Panel/Button.disabled=false
		
		if state=="grave":
			$Panel.visible =true
		pass
	pass # Replace with function body.


func _on_Button_pressed():
	wellmax-=1
	$Panel/Button.disabled=true
	$Panel.visible=false
	$Particles2D.emitting=true
	yield(get_tree().create_timer(1.5),"timeout")
	var hat=Global.rngseed.randi()%10
	if hat <10:
		get_hat()
		yield(get_tree().create_timer(1.5),"timeout")
	$Panel.visible=true
	if wellmax<=0:
		$Panel/Button.visible=false
		$Panel/Label.text="no more coins pls"
	$Panel/Button.disabled=false
	
		
	pass # Replace with function body.


func _on_Areawell_body_exited(body):
	if body.is_in_group("player")and $Panel.visible:
		$AnimationPlayer.play("popout")
	pass # Replace with function body.
