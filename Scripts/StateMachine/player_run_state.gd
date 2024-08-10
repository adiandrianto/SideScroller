extends State

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@export var speed: int
@export var max_horizontal_speed : int
@onready var ray_cast: RayCast2D = $"../../RayCastFront"

func state_physics_update(delta):
	var direction = Input.get_axis("left", "right")
	
	if direction :
		owner.velocity.x += direction * speed
		owner.velocity.x = clamp(owner.velocity.x, -max_horizontal_speed, max_horizontal_speed)
		
	if direction!=0:
		if direction > 0.0:
			animated_sprite.flip_h = false
			if owner.weapon != null:
				owner.weapon.flip_right()
		elif direction < 0.0:
			animated_sprite.flip_h = true
			if owner.weapon != null:
				owner.weapon.flip_left()
	if direction == 0:
		transitioned.emit(self, "idle")
	if not owner.is_on_floor():
		transitioned.emit(self, "fall")
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
	
	if ray_cast.is_colliding():
		if ray_cast.get_collider().is_in_group("ladder") && Input.is_action_just_pressed("interact"):
			transitioned.emit(self,"climb")
		else :
			return	
		
	owner.move_and_slide()
	
func state_enter():
	animated_sprite.play("run")
	
	
