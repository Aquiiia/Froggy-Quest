extends Area2D

@onready var big_circle = $Joy
@onready var small_circle = $Joy/Stick
@onready var button = $Joy/button
@onready var collision = $CollisionShape2D
@onready var max_distance = $CollisionShape2D.shape.radius
@onready var timer = $Timer
#@onready var froggy = preload("res://froggy/froggy.gd")

var onCooldown = false
var touched = false
var wasReleased = false
var isDisabled = false

func _ready() -> void:
	
	if !Global.is_mobile:
		self.visible = false
		big_circle.position = Vector2(-200, -200)
		collision.disabled = true
		

	timer.wait_time = Global.player_abilities["spit_cooldown"]
	pass # Replace with function body.

func _input(event):
	if event is InputEventScreenTouch:
		var distance = event.position.distance_to(big_circle.global_position)
		if not touched:
			if distance < max_distance:
				touched = true
				small_circle.position = big_circle.to_local(event.position)
		else:
			small_circle.position = Vector2(0, 0)
			touched = false
	
func _process(delta):
	if touched:
		
		print("Touched")
		Global.holding_shoot = true
		
		var local_position = big_circle.to_local(get_global_mouse_position())
		if local_position.length() > max_distance:
			local_position = (local_position.normalized() * max_distance)
		small_circle.position = local_position
		
		#if !timer.is_stopped():
		#	return
		
		shoot()
		#timer.start()
		#print("timer start")
	else:
		print("not touched")
		Global.holding_shoot = false

func shot_direction():
	var joy_velo = Vector2(0,0)
	joy_velo.x = (small_circle.position.x / max_distance)
	joy_velo.y = (small_circle.position.y / max_distance)
	
	return joy_velo.normalized()
	
func shoot():
	#Input.action_press("spit")
	var direction = shot_direction()
	Global.direction = direction


func _on_timer_timeout() -> void:
	timer.stop()
	pass # Replace with function body.
