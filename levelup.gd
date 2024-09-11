extends Node2D

var spit_sb_posx = 424
var spit_db_posx = 424
var tongue_sb_posx = 424
var tongue_db_posx = 424

var spit_s_pressed = 0
var spit_d_pressed = 0
var tongue_s_pressed = 0
var tongue_d_pressed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print($spit_speedbar.position,$spit_dmgbar.position, $tongue_dmgbar.position, $tongue_speedbar.position)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_spit_speed_pressed() -> void:
	print("Mjauw")
	
	spit_s_pressed += 1
	
	disable_buttons_with_ending()
	
	#Upgrade the bar 1
	spit_sb_posx += 28
	$spit_speedbar.position.x = spit_sb_posx
	
	#No more upgrades
	if spit_s_pressed == 4:
		$spit_speed.visible = false


func _on_spit_dmg_pressed() -> void:
	print("Eh")
	spit_d_pressed += 1
	
	disable_buttons_with_ending()
	
	#Upgrade the bar 1
	spit_db_posx += 28
	$spit_dmgbar.position.x = spit_db_posx
	
	#No more upgrades
	if spit_d_pressed == 4:
		$spit_dmg.visible = false


func _on_tongue_speed_pressed() -> void:
	print("Ye")
	tongue_s_pressed += 1
	
	disable_buttons_with_ending()
	
	#Upgrade the bar 1
	tongue_sb_posx += 28
	$tongue_speedbar.position.x = tongue_sb_posx
	
	#No more upgrades
	if tongue_s_pressed == 4:
		$tongue_speed.visible = false
	
	

func _on_tongue_dmg_pressed() -> void:
	print("UGH")
	tongue_d_pressed += 1
	
	disable_buttons_with_ending()
	
	#Upgrade the bar 1
	tongue_db_posx += 28
	$tongue_dmgbar.position.x = tongue_db_posx
	
	#No more upgrades
	if tongue_d_pressed == 4:
		$tongue_dmg.visible = false
	
func disable_buttons_with_ending():
	for child in get_children():
		if child is Button:
			if child.name.ends_with("dmg") or child.name.ends_with("speed"):
				child.disabled = true
				#print("button disabled", child.name)#Test which buttons show

func _on_exit_button_pressed() -> void:
	print("Exit button")
	#För vidare till den scenen den spelas i och stäng "LEVELUP" den från main sidan genom en signla???
	pass # Replace with function body.
