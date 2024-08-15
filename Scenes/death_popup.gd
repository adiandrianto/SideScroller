extends TextureRect

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var button: Button = $VBoxContainer/Button
@onready var button_2: Button = $VBoxContainer/Button2

func _ready() -> void:
	visible = false
	button.disabled = true
	button_2.disabled = true
	DimensionManager.player_died.connect(on_player_died)
	
func _on_button_pressed() -> void:
	player.health_component.current_health = player.health_component.max_health
	PickupManager.emit_signal("player_health_changed")
	get_tree().paused = false
	visible = false
	button.disabled = true
	button_2.disabled = true

func _on_button_2_pressed() -> void:
	get_tree().reload_current_scene()

func on_player_died():
	visible = true
	button.disabled = false
	button_2.disabled = false
