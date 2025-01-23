extends CharacterBody2D

signal boss_dmged

@onready var player = get_parent().find_child("Froggy")
@onready var sprite = $Sprite2D
@onready var progress_bar = $UI/ProgressBar

var direction : Vector2

var health = 100:
	set(value):
		health = value
		progress_bar.value = value
		
		if value <= 0:
			progress_bar.visible = false
			find_child("StateMachine").change_state("Death")

func _ready():
	set_physics_process(false)

func _process(_delta):
	direction = player.position - position
	
	if direction.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)

func take_damage(amount: int):
	health -= amount
	boss_dmged.emit()
