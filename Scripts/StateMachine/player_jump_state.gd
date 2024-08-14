extends State

@export var jump_height:= -240
@export var jump_horizontal_speed := 200
@export var max_jump_horizontal_speed := 80
@export var jump_gravity:= 900
@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ray_cast: RayCast2D = $"../../RayCastFront"
		
func state_physics_update(delta):
	var direction = Input.get_axis("left", "right")
	
	owner.velocity.y += jump_gravity * delta
	if direction!=0:
			if direction > 0.0:
				animated_sprite.flip_h = false
				if owner.weapon != null:
					owner.weapon.flip_right()
			elif direction < 0.0:
				animated_sprite.flip_h = true
				if owner.weapon != null:
					owner.weapon.flip_left()
					
	if not owner.is_on_floor():
		owner.velocity.x += direction * jump_horizontal_speed
		owner.velocity.x = clamp(owner.velocity.x, -max_jump_horizontal_speed, max_jump_horizontal_speed)
		
	owner.move_and_slide()
	
	if owner.is_on_floor():
		transitioned.emit(self, "idle")
		
	if ray_cast.is_colliding():
		if ray_cast.get_collider().is_in_group("ladder") && Input.is_action_just_pressed("interact"):
			transitioned.emit(self,"climb")
		else :
			return	
	
	if owner.velocity.y >= 0:
		transitioned.emit(self, "fall")
		
func state_enter():
	animated_sprite.play("jump")
	if owner.is_on_floor():
		owner.velocity.y = jump_height
	
func state_exit():
	animated_sprite.stop()
