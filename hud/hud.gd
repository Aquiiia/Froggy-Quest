extends Node


signal game_over


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	#await $MessageTimer.timeout
	$Message.show()


func update_score(score):
	$ScoreLabel.text = str(score)


func _on_message_timer_timeout() -> void:
	$Message.hide()


@export var pause_action = "pause"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(pause_action):
		toggle_pause()


func toggle_pause():
	var tree = get_tree()
	# If paused then unpause or unpause if paused
	tree.paused = !tree.paused
	if tree.paused:
		$CanvasLayer/PausePanel.show()
	else:
		$CanvasLayer/PausePanel.hide()


func _on_leave_game_button_pressed() -> void:
	toggle_pause()
	get_tree().change_scene_to_file("res://scenes/start_scene.tscn")
