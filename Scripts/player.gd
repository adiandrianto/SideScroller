extends CharacterBody2D

@export var speed : float = 120.0
@export var jump_velocity : float = -350.0
@export var double_jump : float =  -100       #just testing
@onready var health_component = $HealthComponent
@onready var pistol = $Pistol
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var can_shoot_pistol := true 
@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var has_double_jumped : bool = false
var direction : Vector2 = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") && can_shoot_pistol:
		pistol.shoot()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else: 
		has_double_jumped = false
	
	if Input.is_action_pressed("up"):
		if pistol.sprite.flip_h:
			pistol.sprite.rotation = deg_to_rad(90)
		else :
			pistol.sprite.rotation = deg_to_rad(-90)
	else :
		pistol.sprite.rotation = deg_to_rad(0.0)
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		elif not has_double_jumped:
			velocity.y += double_jump
			has_double_jumped = true
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")   #need up and down animation
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation():
	if not animation_locked:
		if not is_on_floor():
			animated_sprite.play("jump_loop")
		else:
			if direction.x != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")
				
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
		pistol.flip_right()
	elif direction.x < 0:
		animated_sprite.flip_h = true
		pistol.flip_left()
		
func jump():
	velocity.y = jump_velocity
	animated_sprite.play("jump")
	animation_locked = true

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "jump":
		animation_locked = false

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	get_tree().reload_current_scene()
