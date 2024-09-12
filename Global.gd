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



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
