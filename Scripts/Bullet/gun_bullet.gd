extends CharacterBody2D
class_name Bullet

@export var bullet_speed := 300
@export var shattered_collision: Area2D
@export var animation_player: AnimationPlayer

func _ready() -> void:
	animation_player.play("shoot")
	shattered_collision.body_entered.connect(on_contact)

func _physics_process(delta):
	move_and_collide(velocity.normalized() * delta * bullet_speed)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func on_contact(body):
	print(body.name)
	velocity = Vector2.ZERO
	animation_player.play("shattered")
