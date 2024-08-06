extends CharacterBody2D

@export var speed : float = 120.0
@export var jump_velocity : float = -350.0
@onready var label = $Label
@onready var health_component = $HealthComponent
@onready var pistol = $MachineGun
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var can_shoot_pistol := true 
@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hurt_sfx: AudioStreamPlayer2D = $HurtSFX
@onready var state_machine: Node = $StateMachine

var direction : Vector2 = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") && can_shoot_pistol:
		pistol.shoot()
		
func _process(delta):
	label.text = str(state_machine.current_state)
	
func _physics_process(delta):
	if Input.is_action_pressed("up"):
		if pistol.sprite.flip_h:
			pistol.sprite.rotation = deg_to_rad(90)
		else :
			pistol.sprite.rotation = deg_to_rad(-90)
	else :
		pistol.sprite.rotation = deg_to_rad(0.0)
	move_and_slide()
	update_facing_direction()
				
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

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	get_tree().reload_current_scene()

func SetShader_BlinkIntensity(newValue : float):
	animated_sprite.material.set_shader_parameter("blink_intensity", newValue)

func _on_hurt_box_component_being_hit() -> void:
	hurt_sfx.play(0.0)
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0,0.0,0.5)
