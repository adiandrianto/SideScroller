extends Area2D

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func _on_area_entered(area: Area2D) -> void:
	if area == get_tree().get_first_node_in_group("player"):
		print("asdwd")
		DimensionManager.emit_signal("closing_cue")
		animation_player.play("closing")
		
