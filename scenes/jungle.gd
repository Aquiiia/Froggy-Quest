extends Node

func game_over() -> void:
	$HUD.show_game_over()
	$MobSpawner._remove_mobs()


func _ready():
	var player = preload("res://froggy/frooog.tscn").instantiate()
	add_child(player)
	player.xp = Global.player_data["xp"]
	player.hp = Global.player_data["health"] #hämtar datan för alla frogs
	player.add_to_group("player")
	player.xp = Global.player_data["xp"] #hämtar datan för alla frogs
	player.position = $StartPos.position

	print("spit_damage", Global.player_abilities["spit_damage"])
	print("cooldown", Global.player_abilities["spit_cooldown"])
	print("tongue_damage", Global.player_abilities["tongue_damage"])
	print(Global.player_abilities["tongue_cooldown"])
	Global.doors_open = false
	
	var healthbar = get_node("health_bar")
	var health_progress = healthbar.get_child(0)
	health_progress.value = Global.player_data["health"]
