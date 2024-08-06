extends Node
class_name Ladder

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

func _on_area_entered(area: Area2D) -> void:
	if area.name == "PlayerCollider" :
		player.on_ladder = true
	else : return


func _on_area_exited(area: Area2D) -> void:
	if area.name == "PlayerCollider" :
		player.on_ladder = false
	else : return
