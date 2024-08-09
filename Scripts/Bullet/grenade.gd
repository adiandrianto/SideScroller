extends RigidBody2D

@onready var explosion_scene = preload("res://Scenes/Weapons/grenade_explosion.tscn")

func _on_area_entered(area: Area2D) -> void:
	print(area.name)
	explode()

func _on_timer_timeout() -> void:
	explode()

func explode():
	var explode = explosion_scene.instantiate()
	explode.global_position = global_position
	get_tree().root.add_child(explode)
	queue_free()
