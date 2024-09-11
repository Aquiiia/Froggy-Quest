extends CharacterBody2D

signal mob_died

@export var speed = 100
@export var health = 2

var froggy_chase = false
var froggy = null

func _physics_process(_delta):
	if froggy_chase:
		position += (froggy.position - position) / speed
		move_and_collide(Vector2(0,0))

func _on_detection_area_body_entered(body: Node2D) -> void:
	froggy = body
	froggy_chase = true


func _on_detection_area_body_exited(_body: Node2D) -> void:
	froggy = null
	froggy_chase = false

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()

func die() -> void:
	# Add logic to remove the enemy, play an animation, etc.
	mob_died.emit()
	queue_free()
