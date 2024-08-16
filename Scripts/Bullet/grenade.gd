extends RigidBody2D

@onready var explosion_scene = preload("res://Scenes/explosion_scene.tscn")
	
func _on_timer_timeout() -> void:
	explode()

func explode():
	var explode = explosion_scene.instantiate()
	explode.global_position = global_position
	get_tree().root.add_child(explode)
	queue_free()

func _on_hit_box_component_area_entered(area: Area2D) -> void:
	explode()
