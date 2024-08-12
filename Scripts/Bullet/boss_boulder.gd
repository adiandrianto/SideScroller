extends CharacterBody2D

@export var bullet_speed := 300
@onready var animated_sprite: AnimatedSprite2D = $Sprite2D

func _ready() -> void:
	pass

func _physics_process(delta):
	move_and_collide(velocity.normalized() * delta * bullet_speed)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
