extends Control

@onready var player: Player
@onready var label: Label = $HBoxContainer/Label
@onready var texture_rect: TextureRect = $HBoxContainer/TextureRect

func _ready() -> void:
	DimensionManager.game_start.connect(on_game_start)
	PickupManager.grenade_changed.connect(on_grenade_changed)
	player = get_tree().get_first_node_in_group("player")
	label.text = " X " + str(player.grenade_count)
	label.visible = false
	texture_rect.visible = false

func on_game_start():
	label.visible = true
	texture_rect.visible = true

	
func on_grenade_changed():
	label.text = " X " + str(player.grenade_count)
	
