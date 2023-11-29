extends Button



# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cost=20


# Called when the node enters the scene tree for the first time.
func _ready():
	set_cost()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_cost():
	if Global.savedata.character=="guy":
		var lvl = Global.savedata.guy_data.jump_str+1
		cost = lvl*20
		if cost == 120:
			self.disabled=true
			$Label.text = "Jump maxxed"
			$Label/costLabel.text=""
		$Label/costLabel.text="+"+str(lvl)+"\n"+str(cost)
		$Sprite2.frame =Global.savedata.guy_data.jump_str
		
	if Global.savedata.character=="ninja":
		var lvl = Global.savedata.ninja_data.jump_str+1
		cost = lvl*20
		if cost == 120:
			$Label.text = "Jump maxxed"
			$Label/costLabel.text=""
			self.disabled=true
		$Label/costLabel.text="+"+str(lvl)+"\n"+str(cost)
		$Sprite2.frame =Global.savedata.ninja_data.jump_str
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button2_pressed():
	if Global.savedata.coins>=cost:
		Global.savedata.coins-=cost
		if Global.savedata.character=="guy":
			Global.savedata.guy_data.jump_str+=1
		if Global.savedata.character=="ninja":
			Global.savedata.ninja_data.jump_str+=1
		set_cost()
		Global.save_data()
	pass # Replace with function body.
