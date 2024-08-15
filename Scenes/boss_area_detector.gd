extends Area2D

@onready var player: Player = get_tree().get_first_node_in_group("player")

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		DimensionManager.emit_signal("boss_started")
		
