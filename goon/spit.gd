extends State

@export var acid_spit_node: PackedScene
var can_transition: bool = false
 
func enter():
	super.enter()
	await get_tree().create_timer(1.0).timeout
	shoot()
	can_transition = true
 
func shoot():
	var acid = acid_spit_node.instantiate()
	acid.position = owner.position
	get_tree().current_scene.add_child(acid)
 
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Charge")
