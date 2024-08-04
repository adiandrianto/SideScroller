extends State

@onready var animation_player = $"../../AnimationPlayer"
@onready var audio_stream_player: AudioStreamPlayer = $"../../AudioStreamPlayer"
@onready var area_2d: Area2D = $"../../Area2D"

func state_enter():
	var player = get_tree().get_first_node_in_group("player")

func state_physics_update(delta):
	pass
	
func state_exit():
	pass
