extends Area2D

var velocity = Vector2.ZERO

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))

func _physics_process(delta):
	position += velocity * delta
	
	if is_out_of_bounds():
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		area.take_damage(1)
		queue_free()

func is_out_of_bounds() -> bool:
	var viewport_rect = get_viewport_rect()
	return not viewport_rect.has_point(global_position)
