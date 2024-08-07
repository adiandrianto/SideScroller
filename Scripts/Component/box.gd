extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_health_component_died() -> void:
	queue_free()


func _on_hurt_box_component_being_hit() -> void:
	print("BOX HIT")
