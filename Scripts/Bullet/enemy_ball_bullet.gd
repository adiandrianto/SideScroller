extends RigidBody2D

@export var force = 125
const EXPLOSION_SCENE = preload("res://Scenes/explosion_scene.tscn")
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	add_constant_force(Vector2(-force,0), Vector2(3,0))


func _on_hit_box_component_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		var explosion = EXPLOSION_SCENE.instantiate()
		explosion.global_position = global_position
		get_tree().root.add_child(explosion)
		queue_free()
		
func _on_health_component_died() -> void:
	var explosion = EXPLOSION_SCENE.instantiate()
	explosion.global_position = global_position
	get_tree().root.add_child(explosion)
	queue_free()

func _on_health_component_health_changed() -> void:
	audio_stream_player.play()
	animation_player.play("being_hit")
	
func _on_timer_timeout() -> void:
	var explosion = EXPLOSION_SCENE.instantiate()
	explosion.global_position = global_position
	get_tree().root.add_child(explosion)
	queue_free()
