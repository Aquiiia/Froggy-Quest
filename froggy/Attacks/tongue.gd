extends Area2D

@export var velocity = Vector2.ZERO
@export var damage = 8 # How much damage the tongue deals

func _physics_process(delta):
	damage = Global.player_abilities["tongue_damage"] 
	position += velocity * delta

func _ready():
	connect("body_entered", Callable(self, "_on_tongue_body_entered"))

func _on_tongue_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		print("HIT")
		body.take_damage(damage)
