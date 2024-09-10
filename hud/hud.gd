extends Node


signal game_over
@export var pause_action = "pause"


func show_game_over():
	$CL/Message.show()
	await get_tree().create_timer(1.5).timeout
	_restart_game()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(pause_action):
		toggle_pause()


func toggle_pause():
	var tree = get_tree()
	# If paused then unpause or unpause if paused
	tree.paused = !tree.paused
	if tree.paused:
		$CL/PausePanel.show()
	else:
		$CL/PausePanel.hide()


func _restart_game() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/start_scene.tscn")


func _on_leave_game_button_pressed() -> void:
	toggle_pause()
	_restart_game()
