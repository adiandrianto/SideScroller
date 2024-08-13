extends State

@onready var camera: Camera2D
@export var enemy :CharacterBody2D
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var music: AudioStreamPlayer = get_tree().get_first_node_in_group("music")

func state_enter():
	music.stop()
	timefreeze(0.2, 2)
	animation_player.play("death")

func state_physics_update(delta):
	pass
	
func state_exit():
	pass
	
func timefreeze(timescale, duration):
	Engine.time_scale = timescale
	await get_tree().create_timer(duration * timescale).timeout
	Engine.time_scale = 1.0
