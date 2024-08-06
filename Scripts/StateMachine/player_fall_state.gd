extends State

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func state_enter():
	animated_sprite.play("fall")

func state_physics_update(delta):
	owner.velocity.y += gravity * delta
	owner.move_and_slide()
	
	if owner.is_on_floor():
		transitioned.emit(self, "idle")
func state_exit():
	animated_sprite.stop()
