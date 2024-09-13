extends Node

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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
