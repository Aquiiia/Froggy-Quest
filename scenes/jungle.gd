extends Node

func game_over() -> void:
	$HUD.show_game_over()
	$MobSpawner/Timer.stop()
	$MobSpawner._remove_mobs()


func _ready():
	var player = preload("res://froggy/frooog.tscn").instantiate()
	add_child(player)
	player.position = $StartPos.position
	pass
