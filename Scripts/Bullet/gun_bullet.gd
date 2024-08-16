extends CharacterBody2D
class_name Bullet

@export var visible_notifier: VisibleOnScreenNotifier2D
@export var bullet_speed : int
@export var shattered_collision: Area2D
@export var animation_player: AnimationPlayer

func _ready() -> void:
	visible_notifier.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
	animation_player.play("shoot")
	shattered_collision.body_entered.connect(on_contact)
	shattered_collision.area_entered.connect(on_contact)
	
func _physics_process(delta):
	move_and_collide(velocity.normalized() * delta * bullet_speed)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func on_contact(body):
	velocity = Vector2.ZERO
	animation_player.play("shattered")
	
#need to check if collision_layer contain layer 3 on area_entered
