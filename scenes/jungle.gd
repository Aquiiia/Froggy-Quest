extends Node

func game_over() -> void:
	$HUD.show_game_over()
	$MobSpawner._remove_mobs()


func _ready():
	var player = preload("res://froggy/frooog.tscn").instantiate()
	add_child(player)
	player.xp = Global.player_data["xp"]
	player.hp = Global.player_data["health"] #hämtar datan för alla frogs
	player.position = $StartPos.position

	
	Global.doors_open = false
	pass
