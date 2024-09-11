extends Area2D

@export var velocity = Vector2.ZERO
@export var damage = 2  # How much damage the tongue deals

func _physics_process(delta):
	position += velocity * delta

func _on_tongue_area_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(damage)
