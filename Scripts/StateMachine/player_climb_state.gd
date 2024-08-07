extends State

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ray_cast: RayCast2D = $"../../RayCastFront"
@onready var ray_cast_up: RayCast2D = $"../../RayCastUp"

var climb_speed := 50

func state_enter():
	animated_sprite.play("climb")
	owner.global_position = ray_cast.get_collision_point()
	
func state_physics_update(delta):	
	var y_direction = Input.get_axis("up", "down")
	
	if y_direction :
		owner.velocity.y = climb_speed * y_direction
	if not y_direction:
		owner.velocity.y = 0
	if not ray_cast_up.is_colliding():
		transitioned.emit(self, "idle")
	
	#if not ray_cast.is_colliding():
		#transitioned.emit(self, "idle")
