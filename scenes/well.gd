extends Sprite


# Declare member variables here. Examples:
signal ch
var state = ""
var wellmax =0
var inwell= false
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$WellPanel/WellButton.disabled=true
	$WellPanel/WellButton.visible=false
					
	var i = abs(Global.rngseed.seed %100)
	
	if i<25:
		state="mushroom"
		self.frame=2
		pass
	if i >24 and i<53:
		state="grave"
		self.frame=1
		pass
	if i  >52 and i <89:
		wellmax=Global.rngseed.randi()%21+1
		state="well"
		self.frame=0
		pass
	if i >88:
		self.queue_free()
	pass # Replace with function body.

func get_hat():
	var hats=Global.rngseed.randi()%14
	$hatsprite.frame=hats
	$hatsprite.visible=true
	$AnimationPlayer.play("hat")
	if Global.savedata.character=="guy":
		Global.savedata.guy_data.hat=hats
	if Global.savedata.character=="ninja":
		Global.savedata.ninja_data.hat=hats
	if Global.savedata.character=="rman":
		Global.savedata.rocket_data.hat=hats
	emit_signal("ch")
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Areawell_body_entered(body):
	if body.is_in_group("player"):
		var uprompt=body.find_node("uprompt")
		uprompt.visible=true
		if Input.is_action_just_pressed("up"):
			body.velocity.x=0
			Global.paused=true
			if state=="well":
				$AnimationPlayer.play("popin")
				$WellPanel/WellLabel.text="throw coin?"
				if wellmax<=0 :
					$WellPanel/WellLabel.text="no more coins for now, thank you"
					$WellPanel/WellButton.disabled=true
					$WellPanel/WellButton.visible=false
				if !Global.savedata.coins>0:
					$WellPanel/WellLabel.text="no coins to throw"
					$WellPanel/WellButton.disabled=true
					$WellPanel/WellButton.visible=false
			
		if state=="grave":
			$AnimationPlayer.play("popin")
			$WellPanel/WellLabel.text="pay respest"
			$WellPanel/WellButton.disabled=false
		if state=="mushroom":
			$AnimationPlayer.play("popin")
			$WellPanel/WellLabel.text="say hi"
			$WellPanel/WellButton.disabled=false
			
	pass # Replace with function body.


func _on_Button_pressed():
	if state=="well":
		wellmax-=1
		$WellPanel/WellButton.disabled=true
		$WellPanel.visible=false
		
		Global.savedata.coins-=1
		var hat=Global.rngseed.randi()%100
		$water.amount=hat
		$water.emitting=true
		yield(get_tree().create_timer(1.5),"timeout")


		if hat==99:
			Global.savedata.coins+=100
			$AnimationPlayer.play("coin in")
			$spritecoin/coinget.text="+100"
			$spritecoin.visible=true
			yield(get_tree().create_timer(3),"timeout")
		if hat >90 and hat<99:
			Global.savedata.coins+=10
			$spritecoin.visible=true
			$AnimationPlayer.play("coin in")
			$spritecoin/coinget.text="+10"
			yield(get_tree().create_timer(3),"timeout")
		if hat >60 and hat<91:
			Global.savedata.coins+=2
			$spritecoin.visible=true
			$AnimationPlayer.play("coin in")
			$spritecoin/coinget.text="+2"
			yield(get_tree().create_timer(3),"timeout")
		if hat <2:
			get_hat()
			yield(get_tree().create_timer(1.5),"timeout")
		$WellPanel.visible=true
		if wellmax<=0 or Global.savedata.coins<=0:
			$WellPanel/WellButton.visible=false
			$WellPanel/WellLabel.text="no more coins"
		$WellPanel/WellButton.disabled=false
		
	if state=="grave":
		$AnimationPlayer.play("popout")
		yield(get_tree().create_timer(1.5),"timeout")
		$AnimationPlayer.play("nice swoop")
		$AnimationPlayer/nice.text="Thanks, BUD!"

		
	if state=="mushroom":
		$AnimationPlayer.play("popout")
		yield(get_tree().create_timer(1.5),"timeout")
		$AnimationPlayer.play("nice swoop")
		$AnimationPlayer/nice.text="hi there ;)!"

	pass # Replace with function body.


func _on_Areawell_body_exited(body):
	if body.is_in_group("player")and $WellPanel.visible:
		var uprompt=body.find_node("uprompt")
		uprompt.visible=false
		$AnimationPlayer.play("popout")
	pass # Replace with function body.


func _on_xButton_pressed():
	Global.paused=false
	$AnimationPlayer.play("popout")
	pass # Replace with function body.
