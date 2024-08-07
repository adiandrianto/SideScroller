extends State

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
var climb_speed := 50
func state_enter():
	animated_sprite.play("climb")

func state_process(delta):	
	if Input.is_action_pressed("up"):
		owner.velocity.y -= climb_speed * delta
	elif Input.is_action_pressed("down"):
		owner.velocity.y += climb_speed * delta
	else :
		owner.velocity.y = 0
