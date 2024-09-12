extends CharacterBody2D

signal froggy_killed

@export var hp = 10
@export var speed = 150
@export var xp: int = 0
#spit ability
#@export var spit : PackedScene
@export var spit : PackedScene = preload("res://froggy/Attacks/spit.tscn")
@export var tongue_scene : PackedScene = preload("res://froggy/Attacks/tongue.tscn")
@export var tongue_range = 100

@onready var sprite = $Sprite2D
@onready var animsprite = $AnimatedSprite2D


#Variables spit
var spit_speed = 400
var spit_cooldown = 1.5
var last_spit_time = 100

var is_tongue_attacking = false

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if velocity.x > 0:
		sprite.flip_h = true
	elif velocity.x < 0:
		sprite.flip_h = false

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	
	#print(xp)
	# Update the timer (spit)
	last_spit_time += delta
	#print("Time since last spit: ", last_spit_time)
	
	
	if Input.is_action_just_pressed("spit"):
		Spit()
		print("pressed attack")
		
	if Input.is_action_just_pressed("tongue_attack"):
		tongue_attack()

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

func tongue_attack():
	if is_tongue_attacking:
		return  # Prevent another tongue attack while one is ongoing
	
	is_tongue_attacking = true
	
	if tongue_scene != null:
		var tongue_instance = tongue_scene.instantiate()
		
		var direction = Vector2(1, 2) if not sprite.flip_h else Vector2(-1, 2)
		var tongue_position = position + direction * -10  # Adjust to be near the mouth
		
		tongue_instance.position = tongue_position
		
		get_parent().add_child(tongue_instance)
		
		animsprite.play("tongue_attack")
		
		await get_tree().create_timer(tongue_range).timeout
		
		tongue_instance.queue_free()
		is_tongue_attacking = false
		animsprite.play("idle")
		
		# Animate the tongue extending and retracting
		#var animation = AnimationPlayer.new()
		#add_child(animation)
		#
		#animation.connect("animation_finished", self, "_on_tongue_attack_finished", [tongue_instance])
		#var anim = Animation.new()
		#anim.length = tongue_range / tongue_speed
		#
		#Animate the tongue moving out
		#anim.track_insert_key(tongue_instance.position, 0, tongue_position)
		#anim.track_insert_key(tongue_instance.position, anim.length, tongue_position + direction * tongue_range)
		#
		#animation.add_animation("extend", anim)
		#animation.play("extend")
	else:
		print("Tongue scene is not assigned!")

func _on_tongue_attack_finished(anim_name: String, tongue_instance: Node2D):
	tongue_instance.queue_free()  # Remove the tongue after the animation
	is_tongue_attacking = false

func _on_hurt_box_entered(_body: Node2D) -> void:
	if hp > 0:
		hp -= 1
		print(hp)
	else:
		froggy_killed.emit()
	
func increase_xp(amount: int) -> void:
	xp += amount
	Global.player_data["xp"] = xp #Uppdaterar alla froogs
	
	
	level_Up()
	print("Frog XP increased to: ", xp)
	
func level_Up():
	var show_card = false
	if xp == 5:
		show_card = true
		#Funkar, men fråga erik hur man gör så att spelet pausas :D
		print("Level up: 5 xp")
	elif xp == 15:
		show_card = true
		#show levelup 
		print("Level up: 15 xp")
	elif xp > 15 and xp % 15 == 0: 
		show_card = true
		#show levelup 
		print("Level up: 30 or higher xp")
	
	if show_card == true:
		var level_up_card = get_parent().get_node("Levelup")
		level_up_card.show()
		
		for child in level_up_card.get_children():
			child.show()
			
		#Pausa spelet här
		
	
