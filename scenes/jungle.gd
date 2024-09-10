extends Node

var score


func game_over() -> void:
	$ScoreTimer.stop()
	$HUD.show_game_over()
	$MobSpawner/Timer.stop()
	$MobSpawner._remove_mobs()

func new_game():
	score = 0
	$StartTimer.start()
	$HUD.update_score(score)

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$HUD/Message.hide()
	$HUD/StartButton.hide()
	$MobTimer.start()
	$ScoreTimer.start()


func _ready():
	pass
