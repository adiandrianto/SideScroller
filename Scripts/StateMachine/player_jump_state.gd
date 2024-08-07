extends State

@export var jump_height:= -240
@export var jump_horizontal_speed := 200
@export var max_jump_horizontal_speed := 80
@export var jump_gravity:= 900
@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
		
func state_physics_update(delta):
	var direction = Input.get_axis("left", "right")
	
	owner.velocity.y += jump_gravity * delta
	if direction!=0:
			if direction > 0.0:
				animated_sprite.flip_h = false
				owner.weapon.flip_right()
			elif direction < 0.0:
				animated_sprite.flip_h = true
				owner.weapon.flip_left()
	if not owner.is_on_floor():
		
		owner.velocity.x += direction * jump_horizontal_speed
		owner.velocity.x = clamp(owner.velocity.x, -max_jump_horizontal_speed, max_jump_horizontal_speed)
		
	owner.move_and_slide()
	
	if owner.is_on_floor():
		transitioned.emit(self, "idle")
	
func state_enter():
	animated_sprite.play("jump")
	if owner.is_on_floor():
		owner.velocity.y = jump_height
	
func state_exit():
	animated_sprite.stop()
