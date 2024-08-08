extends Node

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

func change_weapon(pickup):
	print(pickup)
	var scene = load(pickup)
	var current_weapon = player.get_children()
	var new_weapon = scene.instantiate()
	
	print(current_weapon)
	if player.weapon != null:
		player.weapon.queue_free()
#
	player.add_child(new_weapon)
	player.weapon = new_weapon
