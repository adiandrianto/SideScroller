extends State

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ray_cast: RayCast2D = $"../../RayCastFront"
@onready var ray_cast_up: RayCast2D = $"../../RayCastUp"

var climb_speed := 50

func state_enter():
	owner.velocity = Vector2.ZERO
	animated_sprite.play("climb")
	animated_sprite.pause()
	animated_sprite.flip_h = true
	if owner.weapon != null:
		owner.weapon.visible = false
		owner.weapon.flip_right()
	owner.global_position = ray_cast.get_collision_point()
	owner.animated_sprite.flip_h = false
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
		
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		transitioned.emit(self, "fall")
	
func state_exit():
	if owner.weapon != null:
		owner.can_shoot_pistol = true
		owner.weapon.visible = true
	#if not ray_cast.is_colliding():
		#transitioned.emit(self, "idle")
