extends Node

func game_over() -> void:
	$HUD.show_game_over()
	$MobSpawner._remove_mobs()


func _ready():
	$Froggy.position = $StartPos.position
