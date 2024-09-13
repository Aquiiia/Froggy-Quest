extends Node2D

#Pausa bakgrunden när denna är öppen
var spit_sb_posx = Global.upgrades_bars["ssb"]
var spit_db_posx = Global.upgrades_bars["sdb"]
var tongue_sb_posx = Global.upgrades_bars["tsb"]
var tongue_db_posx = Global.upgrades_bars["tdb"]
	
var spit_s_pressed = Global.upgrade_btns["ss"]
var spit_d_pressed = Global.upgrade_btns["sd"]
var tongue_s_pressed = Global.upgrade_btns["ts"]
var tongue_d_pressed = Global.upgrade_btns["td"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#print($spit_speedbar.position,$spit_dmgbar.position, $tongue_dmgbar.position, $tongue_speedbar.position)
	process_mode = Node.PROCESS_MODE_ALWAYS
	#Sätter de till positionen som de var innan de bytte
	$spit_speedbar.position.x = Global.upgrades_bars["ssb"]
	$spit_dmgbar.position.x = Global.upgrades_bars["sdb"]
	$tongue_speedbar.position.x = Global.upgrades_bars["tsb"]
	$tongue_dmgbar.position.x = Global.upgrades_bars["tdb"]
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_spit_speed_pressed() -> void:
	
	if spit_s_pressed == 4:#No more upgrades
		$spit_speed.visible = false
	else:
		spit_s_pressed += 1
		
		disable_buttons_with_ending()
		
		#Upgrade the bar 1
		spit_sb_posx += 28
		$spit_speedbar.position.x = spit_sb_posx
		Global.upgrades_bars["ssb"] = spit_sb_posx
		upgrade_abilities("SCD")


func _on_spit_dmg_pressed() -> void:
	
	#No more upgrades
	if spit_d_pressed == 4:
		$spit_dmg.visible = false
	else:
		
		spit_d_pressed += 1
		
		disable_buttons_with_ending()
		
		#Upgrade the bar 1
		spit_db_posx += 28
		$spit_dmgbar.position.x = spit_db_posx
		Global.upgrades_bars["sdb"] = spit_db_posx
		upgrade_abilities("SD")
	

func _on_tongue_speed_pressed() -> void:
	if tongue_s_pressed == 4:
		$tongue_speed.visible = false
	else:
		tongue_s_pressed += 1
		
		disable_buttons_with_ending()
		
		#Upgrade the bar 1
		tongue_sb_posx += 28
		$tongue_speedbar.position.x = tongue_sb_posx
		Global.upgrades_bars["tsb"] = tongue_sb_posx
		upgrade_abilities("TCD")
	

func _on_tongue_dmg_pressed() -> void:
	#print("UGH")
	
	if tongue_d_pressed == 4:
		$tongue_dmg.visible = false
	else:
		tongue_d_pressed += 1
		
		disable_buttons_with_ending()
		
		#Upgrade the bar 1
		tongue_db_posx += 28
		$tongue_dmgbar.position.x = tongue_db_posx
		Global.upgrades_bars["tdb"] = tongue_db_posx
		upgrade_abilities("TD")
	
func disable_buttons_with_ending():
	for child in get_children():
		if child is Button:
			if child.name.ends_with("dmg") or child.name.ends_with("speed"):
				child.disabled = true
				#print("button disabled", child.name)#Test which buttons show

func _on_exit_button_pressed() -> void:
	print("Exit button")
	hide_all_children()
	
	get_tree().paused = false
	

func hide_all_children():
	
	for children in get_children(): #Stänger ner
		if children is Button:
			children.disabled = false
		
		children.hide()

func upgrade_abilities(function):
	if function == "SCD":
		Global.player_abilities["spit_cooldown"] -= 0.15
	elif function == "SD":
		Global.player_abilities["spit_damage"] += 5
	elif function == "TCD":
		Global.player_abilities["tongue_cooldown"] -= 0.1
	elif function == "TD":
		Global.player_abilities["tongue_damage"] += 6
