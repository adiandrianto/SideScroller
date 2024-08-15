extends AudioStreamPlayer

@export var audio_list: Array[AudioStream]

func _ready() -> void:
	DimensionManager.boss_defeated.connect(on_boss_defeated)
	stream = audio_list[0]
	play()
	
func on_boss_defeated():
	stream = audio_list[2]
	play()


func _on_boss_area_detector_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		stream = audio_list[1]
		play()
