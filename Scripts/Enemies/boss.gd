extends CharacterBody2D
class_name Boss

@export var summon_markers : Array[Marker2D]
@onready var player :Player = get_tree().get_first_node_in_group("player")
@onready var boss_sprite: Sprite2D = $BossSprite
@onready var label: Label = $Label
@onready var state_machine: Node = $StateMachine
@onready var alien_health: HealthComponent = $AlienHealth
@export var blood: PackedScene
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(_delta: float) -> void:
	if self.global_position < player.global_position:
		boss_sprite.flip_h = true
	else:
		boss_sprite.flip_h = false
	label.text = state_machine.current_state.name + str(alien_health.current_health)

func SetShader_BlinkIntensity(newValue : float):
	boss_sprite.material.set_shader_parameter("blink_intensity", newValue)
	
func _on_alien_health_health_changed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0,0.0,0.1)
