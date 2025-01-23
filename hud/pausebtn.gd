extends TouchScreenButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Global.is_mobile:
		self.visible = false
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	pass # Replace with function body.
