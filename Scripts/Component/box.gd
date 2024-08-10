extends Node2D

@export var drop_scene: PackedScene

func _on_health_component_died() -> void:
	var drop = drop_scene.instantiate()
	drop.global_position = global_position
	get_tree().root.add_child(drop)
	queue_free()

func _on_hurt_box_component_being_hit() -> void:
	print("BOX HIT")
