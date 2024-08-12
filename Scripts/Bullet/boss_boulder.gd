extends CharacterBody2D

@export var bullet_speed := 240
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("shoot")

func _physics_process(delta):
	move_and_collide(velocity.normalized() * delta * bullet_speed)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
