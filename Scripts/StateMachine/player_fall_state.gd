extends State

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 100

func state_enter():
	animated_sprite.play("fall")

func state_physics_update(delta):
	var direction := Input.get_axis("left", "right")
	owner.velocity.x = speed * direction
	owner.velocity.y += gravity * delta
	owner.move_and_slide()
	
	if owner.is_on_floor():
		if is_equal_approx(direction, 0.0):
			transitioned.emit(self, "idle")
		else :
			transitioned.emit(self, "run")
		
func state_exit():
	animated_sprite.stop()
