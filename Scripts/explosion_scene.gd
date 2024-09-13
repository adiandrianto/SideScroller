extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer

func _ready() -> void:
	animation_player.play("default")
	audio_stream_player.play()
