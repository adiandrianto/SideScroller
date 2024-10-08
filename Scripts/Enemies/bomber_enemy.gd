extends CharacterBody2D

var last_pitch = 1.0
@export var enemy_a_scene: PackedScene
@onready var explosion_scene = preload("res://Scenes/explosion_scene.tscn")
@onready var bullet_scene = preload("res://Scenes/Bullets/enemy_ball.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player = get_tree().get_first_node_in_group("player")
@onready var marker: Marker2D = $Marker2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var label: Label = $Label
@onready var health_component: HealthComponent = $HealthComponent
@onready var dead_sfx: AudioStreamPlayer2D = $deadSFX
@onready var blood_splatter: AudioStreamPlayer2D = $BloodSplatter

var alive : bool = true

func _physics_process(_delta: float) -> void:
	label.text = str(health_component.current_health)
	var distance = global_position - player.global_position
	if distance.length() <1000 && alive && DimensionManager.is_inside == false:
		animation_player.play("produce_bomb")
		
func SetShader_BlinkIntensity(newValue : float):
	sprite.material.set_shader_parameter("blink_intensity", newValue)
	
func attack():
	if DimensionManager.is_inside == false:
		var bullet = bullet_scene.instantiate()
		bullet.position = marker.global_position
		get_tree().root.add_child(bullet)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		audio_stream_player.play()

func _on_health_component_died() -> void:
	var enemy_a = enemy_a_scene.instantiate()
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position + Vector2(-8,0)
	enemy_a.global_position = global_position
	get_tree().root.add_child(enemy_a)
	get_tree().root.add_child(explosion)
	queue_free()
	#deadSFX()
	#bloodSFX()
	alive = false
	animation_player.play("death")

func _on_health_component_health_changed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0,0.0,0.2)

func deadSFX():
	randomize()
	dead_sfx.pitch_scale = randf_range(0.8, 1.2)
	
	while abs(dead_sfx.pitch_scale - last_pitch) < .1:
		randomize()
		dead_sfx.pitch_scale = randf_range(0.8, 1.2)
	
	last_pitch = dead_sfx.pitch_scale
	
	dead_sfx.play(0.0)

func bloodSFX():
	randomize()
	blood_splatter.pitch_scale = randf_range(0.8, 1.2)
	
	while abs(blood_splatter.pitch_scale - last_pitch) < .1:
		randomize()
		blood_splatter.pitch_scale = randf_range(0.8, 1.2)
	
	last_pitch = blood_splatter.pitch_scale
	
	blood_splatter.play(0.0)
	await blood_splatter.finished
