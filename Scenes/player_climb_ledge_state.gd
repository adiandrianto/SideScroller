extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
var x_ledge: int = 5
var y_ledge: int = -12

func state_enter():
	animated_sprite.play("climb_ledge")
	owner.velocity = Vector2.ZERO
	animated_sprite.animation_finished.connect(on_animation_finished)

func state_physics_update(delta):
	owner.global_position.x = move_toward(owner.global_position.x, owner.global_position.x + x_ledge, .6)
	owner.global_position.y = move_toward(owner.global_position.y, owner.global_position.y + y_ledge, .6)

func on_animation_finished():
	transitioned.emit(self, "idle")
