extends Node

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_return_timer_timeout() -> void:
	$Frog.position = $StartPos.position
	


func _on_start_button_pressed() -> void:
	$intro.show()
	await get_tree().create_timer(7).timeout
	$intro.hide()
	get_tree().change_scene_to_file("res://scenes/swamp_scene.tscn")
	start_game.emit()
	
