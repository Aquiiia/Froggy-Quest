extends CharacterBody2D
@export var speed = 150



func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			get_input()
		elif event.is_action_released():
			velocity = null
		
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	$PointLight2D/Pic.set_rotation_degrees(input_direction.angle()*180/PI)
	
	print(input_direction.angle())
	
func _physics_process(_delta):
	
	move_and_slide()
