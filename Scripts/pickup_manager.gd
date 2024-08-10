extends Node

@onready var player: Player = get_tree().get_first_node_in_group("player")
var grenade_ammo: int
var max_grenade_ammo: int
var player_health: int
var max_player_health: int

signal grenade_change

func add_grenade():
	print("add 1 grenade")
	player.grenade_count += 1
	
func add_heart():
	print("add 1 heart")
	player.health_component.current_health += 1
	
func change_weapon(pickup):
	var scene = load(pickup)
	var current_weapon = player.get_children()
	var new_weapon = scene.instantiate()
	
	print(current_weapon)
	if player.weapon != null:
		player.weapon.queue_free()
#
	player.add_child(new_weapon)
	player.weapon = new_weapon
