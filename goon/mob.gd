extends CharacterBody2D

signal mob_died

@export var speed = 75
@export var health = 10

var flyhealth = Global.swamp_flies["health"]

var jungle_fly = load("res://img/djungle_fly.png")

var froggy_chase = false
var froggy = null

#func _ready():
	
	
func _physics_process(_delta):
	var scene = get_tree().current_scene
	#print(scene.name)
	if scene.name == "Main":
		$Sprite2D.texture = jungle_fly
		flyhealth = Global.jungle_flies["health"]
		speed = 140
	
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
	
	var scene_to_add = load("res://scenes/orb.tscn")
	var current_scene = get_tree().current_scene
	var orb = scene_to_add.instantiate()
	orb.position = _location
	# Lägg till orb som ett barn till den aktuella scenen
	current_scene.call_deferred("add_child", orb)
	
	
