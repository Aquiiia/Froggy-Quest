extends State

@onready var detection = $"../../PlayerDection/CollisionShape2D"
@onready var progress_bar = owner.find_child("ProgressBar")

var player_enterd: bool = false:
	set(value):
		player_enterd = value
		detection.set_deferred("disabled", value)
		progress_bar.set_deferred("visible", value)

func transition():
	if player_enterd:
		get_parent().change_state("Follow")


func _on_player_dection_body_entered(_body):
	player_enterd = true


func _on_queen_fly_boss_dmged() -> void:
	player_enterd = true
