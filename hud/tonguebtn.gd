extends TouchScreenButton

@onready var progress_bar = $TextureProgressBar
@onready var timer = $Timer
var isDisabled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Global.is_mobile:
		self.visible = false
		
	timer.wait_time = Global.player_abilities["tongue_cooldown"]
	progress_bar.max_value = timer.wait_time
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.value = timer.time_left
	pass


func _on_pressed() -> void:
	if isDisabled:
		pass
	else:
		isDisabled = true
		timer.start()


func _on_timer_timeout() -> void:
	isDisabled = false
	timer.stop()
	pass # Replace with function body.
