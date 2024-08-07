extends CharacterBody2D

@onready var bullet_scene = preload("res://Scenes/Bullets/enemy_ball.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player = get_tree().get_first_node_in_group("player")
@onready var marker: Marker2D = $Marker2D
@onready var timer: Timer = $Timer
@onready var sprite: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _physics_process(delta: float) -> void:
	var distance = global_position - player.global_position
	if distance.length() <1000:
		animation_player.play("produce_bomb")
		
func SetShader_BlinkIntensity(newValue : float):
	sprite.material.set_shader_parameter("blink_intensity", newValue)
	
func attack():
	var bullet = bullet_scene.instantiate()
	bullet.position = marker.global_position
	get_tree().root.add_child(bullet)

func _on_hurt_box_component_being_hit() -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0,0.0,0.5)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		audio_stream_player.play()

func _on_health_component_died() -> void:
	queue_free()
