extends CharacterBody2D
class_name Player

@onready var hurt: AnimationPlayer = $Hurt
@export var randomStrength: float = 1.0
@export var shakeFade: float = 9.0
@export var grenade_count:int
@export var camera_left_limit: int
@export var camera_right_limit: int
@export var cutscene_animation_player: AnimationPlayer
@onready var label = $Label
@onready var health_component = $HealthComponent
@onready var weapon = get_tree().get_first_node_in_group("weapon")
@onready var grenade_scene = preload("res://Scenes/Weapons/Grenade.tscn")
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var can_shoot_pistol := true 
@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hurt_sfx: AudioStreamPlayer2D = $HurtSFX
@onready var state_machine: Node = $StateMachine
@onready var camera_2d: Camera2D = $Camera2D
@onready var hurt_box_collision: CollisionShape2D = $HurtBoxComponent/CollisionShape2D

var flag = false
var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0
var is_boss_fight:= false
#var screen_width = get_viewport_rect().size.x
#var camera_target
#var target_distance = 125
#var camera_speed = 3


var direction = Input.get_axis("left", "right")

func _ready() -> void:
	PickupManager.add_grenade.connect(on_add_grenade)
	PickupManager.add_health.connect(on_add_health)
	DimensionManager.door_open.connect(on_door_open)
	DimensionManager.door_close.connect(on_door_close)
	DimensionManager.boss_started.connect(on_boss_started)
	camera_2d.limit_left = camera_left_limit
	camera_2d.limit_right = camera_right_limit
	
func on_add_grenade():
	grenade_count += 1
	PickupManager.grenade_changed.emit()
	
func on_add_health():
	health_component.current_health = min(2 + health_component.current_health, health_component.max_health)
	health_component.health_changed.emit()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") && can_shoot_pistol && weapon != null:
		weapon.shoot()

func _process(delta):
	label.text = str(state_machine.current_state.name)
	
	#if animated_sprite.flip_h == false :
		#camera_target = owner.position.x + target_distance - screen_width/2
		#camera_2d.offset.x = min(camera_2d.offset.x + camera_speed, camera_target)
	#else:
		#camera_target = owner.position.x - target_distance - screen_width/2
		#camera_2d.offset.x = max(camera_2d.offset.x - camera_speed, camera_target)
	#camera_2d.offset.y = owner.position.y - 50
	
	if health_component.current_health <= 0:
		DimensionManager.emit_signal("player_died")
		get_tree().paused = true
	
	if flag == true:
		apply_shake()
		if shake_strength > 0:
			shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
			camera_2d.offset = randomOffset()
	
	if is_boss_fight:
		camera_2d.offset.x = move_toward(camera_2d.offset.x, 0, 0.5)
		
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
		var grenade_x_force: int
		if animated_sprite.flip_h == false:
			grenade_x_force = get_local_mouse_position().x
		else:
			grenade_x_force = -get_local_mouse_position().x
		var grenade_y_force: int = -500
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

func SetShader_BlinkIntensity(newValue : float):
	animated_sprite.material.set_shader_parameter("blink_intensity", newValue)

func _on_hurt_box_component_being_hit() -> void:
	timefreeze(0.05, 0.5)
	hurt.play("blink_hurt")
	hurt_sfx.play(0.0)
	flag = true
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0,0.0,0.5)
	hurt_box_collision.set_deferred("disabled", true)
	await get_tree().create_timer(1.5).timeout
	hurt_box_collision.set_deferred("disabled", false)
	flag = false



func timefreeze(timescale, duration):
	Engine.time_scale = timescale
	await get_tree().create_timer(duration * timescale).timeout
	Engine.time_scale = 1.0

func _on_health_component_health_changed() -> void:
	PickupManager.emit_signal("player_health_changed")


func on_door_open():
	animated_sprite.play("open_door")
	if weapon != null:
		weapon.visible = false
		
func on_door_close():
	animated_sprite.play("close_door")
	if weapon != null:
		weapon.visible = false

func on_boss_started():
	is_boss_fight = true
	
func facing_right():
	animated_sprite.flip_h = false

func apply_shake():
	shake_strength = randomStrength
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
