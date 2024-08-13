extends State

@onready var camera: Camera2D
@export var enemy :CharacterBody2D
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func state_enter():
	timefreeze(0.1, 1)

func state_physics_update(delta):
	pass
	
func state_exit():
	pass
	
func timefreeze(timescale, duration):
	Engine.time_scale = timescale
	await get_tree().create_timer(duration * timescale).timeout
	Engine.time_scale = 1.0
