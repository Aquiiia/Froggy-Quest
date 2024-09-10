extends CanvasLayer

signal start_game
signal game_over

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	#await $MessageTimer.timeout
	$Message.show()
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$Message.hide()

@export var pause_action = "pause"

func toggle_pause():
	var tree = get_tree()
	# If paused then unpause or unpause if paused
	tree.paused = !tree.paused
	if tree.paused:
		$PausePanel.show()
	else:
		$PausePanel.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(pause_action):
		toggle_pause()


func _on_leave_game_button_pressed() -> void:
	game_over.emit()
	toggle_pause()
