extends CharacterBody2D
class_name EnemyBullet

@export var bullet_speed : int
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	animation_player.play("shoot")

func _physics_process(delta):
	move_and_collide(velocity.normalized() * delta * bullet_speed)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_hit_box_component_area_entered(area: Area2D) -> void:
	queue_free()
