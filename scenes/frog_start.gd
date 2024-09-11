extends CharacterBody2D
@export var speed = 75

@onready var ap = $AnimationPlayer

func _physics_process(_delta: float) -> void:
	ap.play("jump")
	velocity.x = speed
	
	move_and_slide()
	await $AnimationPlayer.animation_finished
	process_mode = PROCESS_MODE_DISABLED

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	await get_tree().create_timer(0.5, true, true, false).timeout
	print("MUTHERFUCKER")
	process_mode = PROCESS_MODE_INHERIT
	

	
