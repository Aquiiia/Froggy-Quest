extends CharacterBody2D
@export var speed = 100

@onready var ap = $AnimationPlayer
@onready var sprite = $PointLight2D/Pic

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			get_input(true)
		elif event.is_action_released:
			get_input(false)
			
	
func get_input(pressed):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if pressed:
		$PointLight2D/Pic.set_rotation_degrees(input_direction.angle()*180/PI)
		ap.play("Jump")
	
	#print(input_direction.angle())
	#print($PointLight2D/Pic.get_rotation_degrees())
	#print()
	
func _physics_process(_delta):
	move_and_slide()
	
