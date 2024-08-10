extends Control

@onready var player: Player
@onready var label: Label = $HBoxContainer/Label

func _ready() -> void:
	PickupManager.grenade_changed.connect(on_grenade_changed)
	player = get_tree().get_first_node_in_group("player")
	label.text = " X " + str(player.grenade_count)

func on_grenade_changed():
	label.text = " X " + str(player.grenade_count)
	
