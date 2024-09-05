extends Node

class_name StateMachine

var current_state: Object

var history = []
var states = {}

# fsm short for finite state machine
# The Initial State is set to the first child Node
func _ready():
	for state in get_children():
		state.fsm = self
		states[state.name] = state
		if current_state:
			remove_child(state)
		else:
			current_state = state
	current_state.enter()

# Adds the previous state into the history list
func change_state(state_name):
	history.append(current_state.name)
	set_state(state_name)

# Checks if there are any elements in history
func back():
	if history.size() > 0:
		# Removes and returns the last element of the array
		set_state(history.pop_back())

func set_state(state_name):
	# Removes the current state node from the scene tree
	remove_child(current_state)
	
	# Adds the new state to the scene tree
	current_state = states[state_name]
	add_child(current_state)
	
	# Calls the states enter function
	current_state.enter()
