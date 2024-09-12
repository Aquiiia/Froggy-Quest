extends Node

@export var mob_scene: PackedScene

# Edit the amount of mobs per wave values by changing the array values or
# add more values at the end of the array for more waves
@export var mobs_per_wave: Array[int] = [2, 3, 4, 6, 8]
var current_wave: int = 0
var mobs_left: int = 0

func _ready() -> void:
	start_wave(current_wave)

func start_wave(wave: int) -> void:
	if wave >= mobs_per_wave.size(): # Checks if all waves are complete
		
		var new_map_choice = get_parent().get_node("Next_map")
		new_map_choice.show()
		
		return
	mobs_left = mobs_per_wave[wave]  # Set how many mobs need to be killed
	for i in range(mobs_left):
		print("Spawning mob", i + 1)
		_mob_creator()

func _mob_creator():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Spawn the mob by adding it to the Main scene.
	call_deferred("add_child", mob)
	mob.add_to_group("enemies")
	mob.connect("mob_died", Callable(self, "_on_mob_died"))


func _on_mob_died() -> void:
	mobs_left -= 1
	if mobs_left <= 0:
		print("Wave completed!")
		current_wave += 1
		start_wave(current_wave)

func _remove_mobs():
	for mob in get_tree().get_nodes_in_group("enemies"):
		mob.queue_free()
