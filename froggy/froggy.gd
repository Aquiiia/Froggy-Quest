extends CharacterBody2D

signal froggy_killed

@export var hp = 10
@export var speed = 150
@export var xp: int = 0
#spit ability
#@export var spit : PackedScene
@export var spit : PackedScene = preload("res://froggy/Attacks/spit.tscn")
@export var tongue_scene : PackedScene = preload("res://froggy/Attacks/tongue.tscn")
@export var tongue_range = 0.5

@onready var sprite = $Sprite2D
@onready var animsprite = $AnimatedSprite2D


#Variables spit
var spit_speed = 400
var spit_cooldown = Global.player_abilities["spit_cooldown"]
var last_spit_time = 100

var tongue_cooldown = Global.player_abilities["tongue_cooldown"]
var last_tongue_time = 100
var is_tongue_attacking = false

var active_tongue: Node2D = null 

var joystick
var spitstick

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	#velocity = input_direction * speed
	
	if joystick:
		velocity = speed*joystick.get_velo()

	if velocity.x > 0:
		sprite.flip_h = true
	elif velocity.x < 0:
		sprite.flip_h = false
		

func _ready()-> void:
	# Hitta 'HUD' i root-scenen
	var current_scene = get_tree().current_scene
	if current_scene:
		print("Scene found")
		var hud = current_scene.get_node("HUD")
		if hud:
			joystick = hud.get_node("CL/Joystick")
			spitstick = hud.get_node("CL/spitjoy")
		

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	#print(xp)
	# Update the timer (spit)
	last_spit_time += delta
	last_tongue_time += delta
	#print("Time since last spit: ", last_spit_time)
	
	#if active_tongue != null:
		#var direction = Vector2(-1, 2) if not sprite.flip_h else Vector2(1, 2)
		#var tongue_position = position + direction * -12 + Vector2(-100, 0) if not sprite.flip_h else position + direction * -12 + Vector2(80, 0)
		#active_tongue.position = tongue_position
		
	if Input.is_action_just_pressed("spit"):
		Spit()
		print("pressed attack")
		
	if Global.holding_shoot:
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
		
		var direction = Vector2(0, 0)
		
		if Global.is_mobile:
			direction = spitstick.shot_direction()
		else:
			direction = (mouse_position - position).normalized()
		
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
	if last_tongue_time >= tongue_cooldown:
		if is_tongue_attacking:
			return  # Prevent another tongue attack while one is ongoing
		
		is_tongue_attacking = true
		
		if tongue_scene != null: #tongue_scene här och tonguescene är basically samma
			var tonguescene = preload("res://froggy/Attacks/tongue.tscn")
			var tongue_instance = tonguescene.instantiate()
			var animated_sprite = tongue_instance.get_node("AnimatedSprite2D")
			#add_child(tongue_instance)
		
			var direction = Vector2(-1, 2) if not sprite.flip_h else Vector2(1, 2)
			var tongue_position = position + direction * -12 + Vector2(-100, 0) if not sprite.flip_h else position + direction * -12 + Vector2(80, 0)# Adjust to be near the mouth
			
			tongue_instance.position = tongue_position
			
			get_parent().add_child(tongue_instance) #get.parent()
			
			
			animated_sprite.play("tongue_attacker")
			
			await get_tree().create_timer(tongue_range).timeout
			
			tongue_instance.queue_free()
			#active_tongue = null
			is_tongue_attacking = false
			animated_sprite.play("idle")
			last_tongue_time = 0.0
		else:
			print("Tongue scene is not assigned!")

func damage_taken():
	if hp > 0:
		var scene = get_tree().current_scene
		var scenename = scene.name
		
		if scenename == "Swamp_scene":
			hp -= Global.swamp_flies["damage"]
		elif scenename == "Main":
			hp -= Global.jungle_flies["damage"]
		elif scenename == "Final_scene":
			hp -= Global.boss_damage["damage"]
		
		Global.player_data["health"] = hp
		
		Global.health_changed = true
		print(hp)
	else:
		froggy_killed.emit()

func _on_hurt_box_entered(_body: Node2D) -> void:
	damage_taken()

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
		
		get_tree().paused = true
		
		#level_up_card.pause_mode = Node.PROCESS_MODE_WHEN_PAUSED
		#for child in level_up_card.get_children():	
			#if child is Node:
				#child.pause_mode = Node.PROCESS_MODE_WHEN_PAUSED
		#Pausa spelet här
		
	
