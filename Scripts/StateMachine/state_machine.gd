extends Node

@export var initial_state: State
@onready var idle: Node = %Idle

var current_state: State
var states: Dictionary = {}

func _ready():
	for children in get_children():
		if children is State:
			states[children.name.to_lower()] = children
			children.transitioned.connect(on_children_transitioned)
	if initial_state:
		initial_state.state_enter()
		current_state = initial_state
		
func _physics_process(delta):
	if current_state:
		current_state.state_physics_update(delta)

func _process(delta):
	if current_state:
		current_state.state_update(delta)
		
func on_children_transitioned(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.state_exit()  
	new_state.state_enter()
	current_state = new_state
