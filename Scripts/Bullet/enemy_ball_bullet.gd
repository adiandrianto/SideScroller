extends RigidBody2D

@export var force = 125
const EXPLOSION_SCENE = preload("res://Scenes/explosion_scene.tscn")

func _ready() -> void:
	add_constant_force(Vector2(-force,0), Vector2(3,0))


func _on_hit_box_component_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		var explosion = EXPLOSION_SCENE.instantiate()
		explosion.global_position = global_position
		get_tree().root.add_child(explosion)
		queue_free()
		
		
