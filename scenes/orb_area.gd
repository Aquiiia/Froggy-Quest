extends Area2D

@export var add_xp: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("body_entered", Callable(self, "_on_area_2d_body_entered"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	#Uppdatera export value xp på frooooog
	if _body.name == "Froggy":  # Kontrollera att det är rätt nod
		#print("yay")
		if _body.has_method("increase_xp"):
			_body.call("increase_xp", add_xp)
			queue_free()
			#print("yuay")
