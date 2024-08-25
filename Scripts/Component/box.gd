extends Node2D

@export var drop_scene: PackedScene
@export var is_inside : bool
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_health_component_died() -> void:
	animation_player.play("break")
	audio_stream_player.play()
	var drop = drop_scene.instantiate()
	drop.global_position = global_position
	get_tree().root.add_child(drop)

func _process(delta: float) -> void:
	if is_inside && DimensionManager.is_inside:
		can_be_seen()
	elif is_inside && not DimensionManager.is_inside:
		invincible()
	elif not is_inside && DimensionManager.is_inside:
		invincible()
	else :
		can_be_seen()
		
func invincible():
	visible = false
	
func can_be_seen():
	visible = true
	
func SetShader_BlinkIntensity(newValue : float):
	sprite.material.set_shader_parameter("blink_intensity", newValue)

func _on_health_component_health_changed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0,0.0,0.1)
