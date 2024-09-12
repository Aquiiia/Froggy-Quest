extends TextureProgressBar

#@export var player: NodePath
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#var froggy_instance = get_parent().get_node("Froggy")
		  # Add it to the current scene tree
	#froggy_instance.HealthChanged.connect(update)
	update()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.health_changed == true:
		update()
		Global.health_changed = false
	pass

func update():
	value = Global.player_data["health"] #hämtar hpet
	
