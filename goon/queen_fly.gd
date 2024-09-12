extends CharacterBody2D

@onready var player = get_parent().find_child("Froggy")
@onready var sprite = $Sprite2D

var direction : Vector2


func _ready():
	set_physics_process(false) 

func _process(_delta):
	direction = player.position - position
	
	if direction.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true


func _physics_process(delta):
	if player:
		velocity = direction.normalized() * 40
		move_and_collide(velocity * delta)
