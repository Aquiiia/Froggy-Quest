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


func _on_detection_area_body_exited(body: Node2D) -> void:
	froggy = null
	froggy_chase = false

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()

func die() -> void:
	# Add logic to remove the enemy, play an animation, etc.
	xp_n_special_item(position)
	mob_died.emit()
	queue_free()
	
	
func xp_n_special_item(_location):
	var rng = RandomNumberGenerator.new()
	
	#Olika chans beroende på om man är i olika waves, sätt if satster
	
	var is_number = rng.randf_range(0.0, 100.0)
	
	if is_number == 1:
		#Drop item
		print("YE")
	
	var scene_to_add = load("res://scenes/orb.tscn")
	var current_scene = get_tree().current_scene
	var orb = scene_to_add.instantiate()
	orb.position = _location
	# Lägg till orb som ett barn till den aktuella scenen
	current_scene.call_deferred("add_child", orb)
	
	
