extends Control

var hearts := 4 : set = _set_health
var max_hearts := 4

@onready var player: CharacterBody2D
@onready var progress_bar: TextureProgressBar = $TextureProgressBar

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player.health_component.health_changed.connect(on_player_health_changed)
	hearts = player.health_component.current_health
	max_hearts = player.health_component.max_health
	progress_bar.value = player.health_component.current_health
	
func _set_health(value:int):
	hearts = clamp(value, 0, max_hearts)
	
func on_player_health_changed():
	_set_health(player.health_component.current_health)
	progress_bar.value = player.health_component.current_health
	
