extends Node2D

#Pausa bakgrunden när denna är öppen


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	pass


func _on_gobutton_pressed() -> void:
	for children in get_children():
		children.hide()
	Global.doors_open = true
	get_tree().paused = false
