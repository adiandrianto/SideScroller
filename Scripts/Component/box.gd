extends Node2D

@export var drop_scene: PackedScene
@export var is_inside : bool

func _on_health_component_died() -> void:
	var drop = drop_scene.instantiate()
	drop.global_position = global_position
	get_tree().root.add_child(drop)
	queue_free()

func _process(delta: float) -> void:
	if is_inside && DimensionManager.is_inside:
		can_be_seen()
	elif is_inside && not DimensionManager.is_inside:
		invincible()
	elif not is_inside && DimensionManager.is_inside:
		invincible()
	else :
		can_be_seen()
		
func invincible():
	visible = false
	
func can_be_seen():
	visible = true
	
func _on_hurt_box_component_being_hit() -> void:
	print("BOX HIT")
