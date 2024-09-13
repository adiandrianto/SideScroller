extends AudioStreamPlayer

@export var audio_list: Array[AudioStream]

func _ready() -> void:
	DimensionManager.boss_defeated.connect(on_boss_defeated)
	
func on_boss_defeated():
	stream = audio_list[2]
	play()
	
func play_level_music():
	stream = audio_list[0]
	volume_db = -7
	play()
	
func _on_boss_area_detector_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		stream = audio_list[1]
		volume_db = -7
		play()
