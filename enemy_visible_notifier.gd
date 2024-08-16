extends VisibleOnScreenNotifier2D

@onready var player: Player = get_tree().get_first_node_in_group("player")

func _on_screen_exited() -> void:
	if owner.global_position.x - player.global_position.x < -200:
		owner.queue_free()
