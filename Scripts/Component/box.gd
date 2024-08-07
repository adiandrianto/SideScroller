extends Node2D

func _on_health_component_died() -> void:
	queue_free()

func _on_hurt_box_component_being_hit() -> void:
	print("BOX HIT")
