extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var blood_splatter: AudioStreamPlayer = $BloodSplatter

var last_pitch = 1.0

func _ready() -> void:
	random_pitch()
	random_pitch2()
	animation_player.play("death")

func random_pitch(from_position=0.0):
	randomize()
	audio_stream_player.pitch_scale = randf_range(1.2, 1.5)
	
	while abs(audio_stream_player.pitch_scale - last_pitch) < .1:
		randomize()
		audio_stream_player.pitch_scale = randf_range(0.8, 1.2)
	
	last_pitch = audio_stream_player.pitch_scale
	
	audio_stream_player.play(0.0)

func random_pitch2(from_position=0.0):
	randomize()
	blood_splatter.pitch_scale = randf_range(1.2, 1.5)
	
	while abs(blood_splatter.pitch_scale - last_pitch) < .1:
		randomize()
		blood_splatter.pitch_scale = randf_range(0.8, 1.2)
	
	last_pitch = blood_splatter.pitch_scale
	
	blood_splatter.play(0.0)
	
