extends CharacterBody2D
class_name Player

@export var speed : float
@onready var label = $Label
@onready var health_component = $HealthComponent
@onready var weapon = get_tree().get_first_node_in_group("weapon")
@onready var grenade_scene = preload("res://Scenes/Weapons/Grenade.tscn")
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var can_shoot_pistol := true 
@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hurt_sfx: AudioStreamPlayer2D = $HurtSFX
@onready var state_machine: Node = $StateMachine
@export var grenade_count:int

var direction = Input.get_axis("left", "right")

func _ready() -> void:
	PickupManager.add_grenade.connect(on_add_grenade)
	PickupManager.add_health.connect(on_add_health)
	
func on_add_grenade():
	grenade_count += 1
	PickupManager.grenade_changed.emit()
	
func on_add_health():
	health_component.current_health += 1
	health_component.health_changed.emit()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") && can_shoot_pistol && weapon != null:
		weapon.shoot()

func _process(delta):
	label.text = str(state_machine.current_state.name)
	
func _physics_process(delta):
	if weapon != null:
		if Input.is_action_pressed("up"):
			if weapon.sprite.flip_h:
				weapon.sprite.rotation = deg_to_rad(90)
			else :
				weapon.sprite.rotation = deg_to_rad(-90)
		else :
			weapon.sprite.rotation = deg_to_rad(0.0)
			
	if Input.is_action_just_pressed("Throw") && grenade_count > 0 :
		var grenade_x_force: int = 350
		var grenade_y_force: int = -400
		var grenade = grenade_scene.instantiate()
		var target = get_global_mouse_position()
		if animated_sprite.flip_h == true:
			grenade_x_force *= -1
			
		grenade.global_position = global_position
		grenade.apply_central_impulse(Vector2(grenade_x_force,grenade_y_force))
		get_tree().root.add_child(grenade)
		grenade_count -= 1
		PickupManager.grenade_changed.emit()
		
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	get_tree().reload_current_scene()

func SetShader_BlinkIntensity(newValue : float):
	animated_sprite.material.set_shader_parameter("blink_intensity", newValue)

func _on_hurt_box_component_being_hit() -> void:
	hurt_sfx.play(0.0)
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0,0.0,0.5)

	#if Input.is_action_just_pressed("Throw"):
		#var grenade = grenade_scene.instantiate()
		#var target = get_global_mouse_position()
		#var range = global_position.distance_to(get_global_mouse_position())
		#var distance =  get_global_mouse_position() - global_position 
		#var distance_x = get_global_mouse_position().x - global_position.x
		#var distance_y = get_global_mouse_position().y - global_position.y
		#var angle = deg_to_rad(45)
		#var gravity = 980
		#var t = 1 #1second
		#var force = sqrt((distance_x * gravity)/ sin(2*angle))
		#var x = force*t*cos(angle)
		#var y = -(gravity/2) + (force * sin(angle) * t)
#
		#var v_init_squared = gravity*(distance_x*distance_x) / 2*(cos(angle)*cos(angle))*(-distance_y + (distance_x*tan(angle)))
		#var v_init = sqrt(v_init_squared)
		#print(v_init)
		#var x = v_init * cos(angle)
		#var y = v_init * sin(angle)
		#grenade.global_position = global_position
		#grenade.apply_central_impulse(Vector2(x,y))
		#get_tree().root.add_child(grenade)
