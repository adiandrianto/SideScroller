extends Control

@onready var player: CharacterBody2D
@onready var label: Label = $Label

func _ready() -> void:
	PickupManager.grenade_change.connect(on_grenade_change)
	player = get_tree().get_first_node_in_group("player")
	label.text = str(player.grenade_count)

func on_grenade_change():
	label.text = str(player.grenade_count)
	
