extends State

func enter():
	super.enter()
	owner.set_physics_process(true)
	# Add animation

func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	var distance = owner.direction.length()
	
	if distance < 110:
		get_parent().change_state("Bite")
	elif distance < 300:
		get_parent().change_state("Spit")
