extends Node

var is_mobile: bool = true

func _ready():
	print("hello")
	#var platform_name = OS.get_name()
	#if platform_name == "Android" or platform_name == "iOS":
		#is_mobile = true
	#else:
		#is_mobile = false

var direction: Vector2 = Vector2(1, 1)
var holding_shoot: bool = false

var player_data: Dictionary = {
	"health": 10,
	"xp": 0
}

var upgrades_bars: Dictionary = { # keep update on upgradebars ;D
	"ssb": 424,
	"sdb": 424,
	"tsb": 424,
	"tdb": 424
}


var upgrade_btns: Dictionary = {
	"ss": 0,
	"sd": 0,
	"ts": 0,
	"td": 0
	}

var doors_open = false

var health_changed = false

var player_abilities: Dictionary = {
	"spit_cooldown": 0.8,
	"spit_damage": 5,
	"tongue_cooldown": 3,
	"tongue_damage": 8
}

var swamp_flies: Dictionary = {
	"health": 10, #2 shot
	"damage": 1
}

var jungle_flies: Dictionary = {
	"health": 25,
	"damage": 2
}

var boss_damage: Dictionary = {
	"range_damage": 4,
	"damage": 2
}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
