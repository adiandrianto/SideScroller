extends State

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@export var speed:= 600
@export var max_horizontal_speed := 75

func state_physics_update(delta):
	var direction = Input.get_axis("left", "right")
	
	if direction > 0.0:
		animated_sprite.flip_h = false
		owner.weapon.flip_right()
	elif direction < 0.0:
		animated_sprite.flip_h = true
		owner.weapon.flip_left()
	
	if direction :
		owner.velocity.x += direction * speed * delta
		owner.velocity.x = clamp(owner.velocity.x, -max_horizontal_speed, max_horizontal_speed)
	if direction!=0:
		animated_sprite.flip_h = false if direction > 0 else true
	if direction == 0:
		transitioned.emit(self, "idle")
	if not owner.is_on_floor():
		transitioned.emit(self, "fall")
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
	owner.move_and_slide()
	
func state_enter():
	animated_sprite.play("run")
	
	
