extends CharacterBody2D
@export var speed = 100

@onready var ap = $AnimationPlayer
@onready var sprite = $PointLight2D/Pic

@export var spit : PackedScene = preload("res://TopFrog/Attacks/spit_top_down.tscn")

var joystick
var spitstick
#Variables spit
var spit_speed = 400
var spit_cooldown = 1.5
var last_spit_time = 100

func _unhandled_input(event):
	#print(event)
	#print(velocity)
	if event is InputEventKey:
		if event.pressed: #Fortsätt att byta bild osv när du har speed, men speeden byts efter event
			get_input(true)
		elif event.is_action_released:
			get_input(false)
			
	
func get_input(pressed):
	
	
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = input_direction * speed
	
	if  velocity.x != 0 or velocity.y != 0 or pressed:
		$PointLight2D/Pic.set_rotation_degrees(input_direction.angle()*180/PI)
		ap.play("Jump")
	
	
	#print(input_direction.angle())
	#print($PointLight2D/Pic.get_rotation_degrees())
	#print(velocity, velocity.x, velocity.y)
	
func _physics_process(delta):
	move_and_slide()
	
	var current_scene = get_tree().current_scene
	if current_scene:
		#print("Scene found")
		var hud = current_scene.get_node("HUD")
		if hud:
			joystick = hud.get_node("CL/Joystick")
			spitstick = hud.get_node("CL/spitjoy")
			
	if joystick && Global.is_mobile:
		velocity = speed*joystick.get_velo()
		
		if velocity.x != 0 or velocity.y != 0:
			$PointLight2D/Pic.set_rotation_degrees(joystick.get_velo().angle()*180/PI)
			ap.play("Jump")
		
	last_spit_time += delta
	#print("Time since last spit: ", last_spit_time)
	
	if Input.is_action_just_pressed("spit"):
		Spit()
		print("pressed attack")
		
		
	if Global.holding_shoot:
		Spit()
		print("pressed attack")
	

func Spit():
	print("spit")
	if last_spit_time >= spit_cooldown:
		print("spit2")
		var mouse_position = get_global_mouse_position()
		
		var direction 
		
		if Global.is_mobile:
			direction = spitstick.shot_direction()
		else:
			direction = (mouse_position - position).normalized()
		
		
		if Spit != null:
			print("spit3")
			var mouth_offset = Vector2(12, 0)
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
