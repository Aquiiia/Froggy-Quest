extends Area2D

@onready var big_circle = $Joy
@onready var small_circle = $Joy/Stick
@onready var max_distance = $CollisionShape2D.shape.radius
@onready var collision = $CollisionShape2D

var touched = false

func _ready() -> void:
	if !Global.is_mobile:
		self.visible = false
		big_circle.position = Vector2(-200, -200)
		collision.disabled = true
		collision.PROCESS_MODE_DISABLED
		
		#small_circle.mouse_filter = Control.MOUSE_FILTER_IGNORE
		#collision.mouse_filter = Control.MOUSE_FILTER_IGNORE

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
		var local_position = big_circle.to_local(get_global_mouse_position())
		if local_position.length() > max_distance:
			local_position = (local_position.normalized() * max_distance)
		small_circle.position = local_position

func get_velo():
	var joy_velo = Vector2(0,0)
	joy_velo.x = small_circle.position.x / max_distance
	joy_velo.y = small_circle.position.y / max_distance
	#print(joy_velo)
	return joy_velo
	
