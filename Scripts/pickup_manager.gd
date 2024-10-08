extends Node

@onready var player: Player = get_tree().get_first_node_in_group("player")
var grenade_ammo: int
var max_grenade_ammo: int
var player_health: int
var max_player_health: int

signal add_grenade
signal add_health
signal grenade_changed
signal player_health_changed

func update_player():
	player = get_tree().get_first_node_in_group("player")
	
func change_weapon(pickup):
	var scene = load(pickup)
	if is_instance_valid(player):
		var current_weapon = player.get_children(false)
		var new_weapon = scene.instantiate()
	
		if player.weapon != null:
			player.weapon.queue_free()
#
		player.add_child(new_weapon)
		player.weapon = new_weapon
	
	else:
		var new_player: Player = get_tree().get_first_node_in_group("player")
		var current_weapon = new_player.get_children(false)
		var new_weapon = scene.instantiate()
	
		if new_player.weapon != null:
			new_player.weapon.queue_free()
#
		new_player.add_child(new_weapon)
		new_player.weapon = new_weapon
