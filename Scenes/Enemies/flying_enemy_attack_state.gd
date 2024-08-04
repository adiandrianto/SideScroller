extends State
class_name FlyingEnemyAttack

@onready var sprite : Sprite2D = $"../../Sprite2D"
@onready var animation_player = $"../../AnimationPlayer"
@export var enemy :CharacterBody2D
var player:CharacterBody2D

func state_enter():
	player = get_tree().get_first_node_in_group("player")
	animation_player.play("attack")
		
func to_idle():
	transitioned.emit(self, "idle")

func SetShader_BlinkIntensity(newValue : float):
	sprite.material.set_shader_parameter("blink_intensity", newValue)


func _on_hurt_box_component_being_hit():
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0, 0.0, 0.5)
