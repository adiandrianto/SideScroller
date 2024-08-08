extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var last_pitch = 1.0

func _ready() -> void:
	random_pitch()
	animation_player.play("death")

func random_pitch(from_position=0.0):
	randomize()
	audio_stream_player.pitch_scale = randf_range(1.2, 1.5)
	
	while abs(audio_stream_player.pitch_scale - last_pitch) < .1:
		randomize()
		audio_stream_player.pitch_scale = randf_range(0.8, 1.2)
	
	last_pitch = audio_stream_player.pitch_scale
	
	audio_stream_player.play(0.0)
	
