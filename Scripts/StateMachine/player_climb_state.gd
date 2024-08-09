extends State

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ray_cast: RayCast2D = $"../../RayCastFront"
@onready var ray_cast_up: RayCast2D = $"../../RayCastUp"

var climb_speed := 50

func state_enter():
	animated_sprite.frame = 1
	owner.weapon.visible = false
	owner.global_position = ray_cast.get_collision_point()
	owner.animated_sprite.flip_h = false
	owner.weapon.flip_right()
	owner.can_shoot_pistol = false
	
func state_physics_update(delta):	
	var y_direction = Input.get_axis("up", "down")
	
	if y_direction :
		owner.velocity.y = climb_speed * y_direction
		animated_sprite.play("climb")
	if not y_direction:
		owner.velocity.y = 0
		animated_sprite.pause()
	if not ray_cast_up.is_colliding():
		transitioned.emit(self, "idle")
	
func state_exit():
	owner.can_shoot_pistol = true
	owner.weapon.visible = true
	#if not ray_cast.is_colliding():
		#transitioned.emit(self, "idle")
