extends Control

var hearts := 6 : set = _set_health
var max_hearts := 6

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var progress_bar: TextureProgressBar = $TextureProgressBar

func _ready() -> void:
	progress_bar.visible = false
	progress_bar.value = 6
	PickupManager.player_health_changed.connect(on_player_health_changed)
	DimensionManager.game_start.connect(on_game_start)
	
func on_game_start():
	progress_bar.visible = true
	
func _set_health(value:int):
	hearts = clamp(value, 0, max_hearts)
	
func on_player_health_changed():
	_set_health(player.health_component.current_health)
	progress_bar.value = player.health_component.current_health
	
