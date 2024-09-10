extends State

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@export var speed: int
@export var max_horizontal_speed : int
@onready var ray_cast: RayCast2D = $"../../RayCastFront"
@onready var smoke = preload("res://Scenes/smokerun.tscn")

func state_physics_update(delta):
	var direction = Input.get_axis("left", "right")
	if direction && owner.weapon != null:
		owner.velocity.x += direction * speed
		owner.velocity.x = clamp(owner.velocity.x, -max_horizontal_speed, max_horizontal_speed)
		
	elif direction && owner.weapon == null:
		owner.velocity.x += direction * speed
		owner.velocity.x = clamp(owner.velocity.x, -max_horizontal_speed/2, max_horizontal_speed/2)
		
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
		
	if Input.is_action_just_pressed("jump") && owner.weapon != null:
		transitioned.emit(self, "jump")
	
	if ray_cast.is_colliding():
		if ray_cast.get_collider() == Ladder && Input.is_action_just_pressed("interact"):
			transitioned.emit(self,"climb")
		else: 
			return
		
	owner.move_and_slide()
	
func state_enter():
	var direction = Input.get_axis("left", "right")
	if owner.weapon != null:
		var fx = smoke.instantiate()
		if direction < 0:
			fx.flip_h = true
		elif direction > 0 :
			fx.flip_h = false
		fx.global_position = owner.global_position
		get_tree().root.add_child(fx)
	
		animated_sprite.play("run")
		owner.weapon.visible = true
		
	elif owner.weapon == null:
		animated_sprite.play("walk")
		
	
	
