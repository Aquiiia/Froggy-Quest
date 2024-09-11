extends CharacterBody2D

signal froggy_killed

@export var hp = 10
@export var speed = 150
#spit ability
#@export var spit : PackedScene
@export var spit : PackedScene = preload("res://froggy/Attacks/spit.tscn")


#Variables spit
var spit_speed = 400
var spit_cooldown = 1.5
var last_spit_time = 100

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	# Update the timer (spit)
	last_spit_time += delta
	#print("Time since last spit: ", last_spit_time)
	
	if Input.is_action_just_pressed("spit"):
		Spit()
		print("pressed attack")

func start(pos):
	position = pos
	show()

func Spit():
	print("spit")
	if last_spit_time >= spit_cooldown:
		print("spit2")
		var mouse_position = get_global_mouse_position()
		
		var direction = (mouse_position - position).normalized()
		
		if Spit != null:
			print("spit3")
			var mouth_offset = Vector2(0, 0)
			var spit_position = position + mouth_offset
			print("Character Position: ", position)
			print("Mouth Offset: ", mouth_offset)
			print("Spit Position: ", spit_position)
			var spit_instance = spit.instantiate()
			spit_instance.position = position + mouth_offset
			spit_instance.velocity = direction * spit_speed

			get_parent().add_child(spit_instance)
		
			last_spit_time = 0.0
			print("Spit created at: ", spit_instance.position)
	else:
		print("Spit scene is not assigned!")


func _on_hurt_box_entered(_body: Node2D) -> void:
	if hp > 0:
		hp -= 1
		print(hp)
	else:
		froggy_killed.emit()
	
