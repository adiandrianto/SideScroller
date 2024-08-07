extends State

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ray_cast: RayCast2D = $"../../RayCast2D"
var climb_speed := 40

func state_enter():
	animated_sprite.play("climb")

func state_physics_update(delta):	
	var y_direction = Input.get_axis("up", "down")
	
	if y_direction :
		owner.velocity.y = climb_speed * y_direction
	if not y_direction:
		owner.velocity.y = 0
	
	if not ray_cast.is_colliding():
		transitioned.emit(self, "idle")
