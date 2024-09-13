extends State

func enter():
	super.enter()
 
func transition():
	if owner.direction.length() > 110:
		get_parent().change_state("Follow")
