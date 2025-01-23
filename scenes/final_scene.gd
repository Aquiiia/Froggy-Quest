extends Node

@onready var player = find_child("Froggy")

func game_over() -> void:
	$HUD.show_game_over()
	Global.player_data["health"] = 10
	Global.player_data["xp"] = 0
	Global.upgrades_bars["ssb"] = 424
	Global.upgrades_bars["sdb"] = 424
	Global.upgrades_bars["tsb"] = 424
	Global.upgrades_bars["tdb"] = 424
	Global.upgrade_btns["ss"] = 0
	Global.upgrade_btns["sd"] = 0
	Global.upgrade_btns["ts"] = 0
	Global.upgrade_btns["td"] = 0
	Global.player_abilities["spit_cooldown"] = 0.8
	Global.player_abilities["spit_damage"] = 5
	Global.player_abilities["tongue_cooldown"] = 3
	Global.player_abilities["tongue_damage"] = 8



func _ready():
	player.connect("froggy_killed", Callable(self, "game_over"))
	player.xp = Global.player_data["xp"]
	player.hp = Global.player_data["health"] #hämtar datan för alla frogs
	player.xp = Global.player_data["xp"] #hämtar datan för alla frogs
	player.position = $StartPos.position
	
	var healthbar = get_node("health_bar")
	var health_progress = healthbar.get_child(0)
	health_progress.value = Global.player_data["health"]
