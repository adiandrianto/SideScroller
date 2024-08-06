extends State

@export var jump_height:= -250
@export var jump_horizontal_speed := 100
@export var max_jump_horizontal_speed := 120
@export var jump_gravity:= 1000
@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"


func state_physics_update(delta):
	var direction = Input.get_axis("left", "right")
	
	owner.velocity.y += jump_gravity * delta
	if owner.is_on_floor():
		owner.velocity.y = jump_height
	if not owner.is_on_floor():
		owner.velocity.x += direction * jump_horizontal_speed * delta
		owner.velocity.x = clamp(owner.velocity.x, -max_jump_horizontal_speed, max_jump_horizontal_speed)
		
	owner.move_and_slide()
	
	if owner.is_on_floor():
		transitioned.emit(self, "idle")
	
func state_enter():
	animated_sprite.play("jump")
	
func state_exit():
	animated_sprite.stop()
