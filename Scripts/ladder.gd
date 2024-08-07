extends Node
class_name Ladder

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var label: Label = $Label

func _process(delta: float) -> void:
	if label.visible :
		if Input.is_action_pressed("interact"):
			player.state_machine.current_scene = "Climb"
func _on_area_entered(area: Area2D) -> void:
	label.visible = true

func _on_area_exited(area: Area2D) -> void:
	label.visible = false
	
