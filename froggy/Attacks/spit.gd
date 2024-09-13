extends Area2D

var velocity = Vector2.ZERO
@export var damage = 5

func _physics_process(delta):
	position += velocity * delta
	
	damage = Global.player_abilities["spit_damage"]
	
	if is_out_of_bounds():
		queue_free()
		

func _ready():
	connect("body_entered", Callable(self, "_on_spit_body_entered"))

func _on_spit_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(damage)
		queue_free()

func is_out_of_bounds() -> bool:
	var viewport_rect = get_viewport_rect()
	return not viewport_rect.has_point(global_position)
