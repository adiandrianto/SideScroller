extends Area2D

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var boss_music: AudioStreamPlayer = $"../BOSSMusic"
@onready var music_a: AudioStreamPlayer = $"../MusicA"

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		music_a.stop()
		boss_music.play()
		DimensionManager.emit_signal("boss_started")
		
