extends CharacterBody2D

const SPEED := 40
var direction = 1
var last_pitch = 1.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var is_inside: bool
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurt_box_component: HurtBoxComponent = $HurtBoxComponent
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_label: Label = $StateLabel
@onready var state_machine: Node = $StateMachine
@onready var player = get_tree().get_first_node_in_group("player")
@onready var ray_cast: RayCast2D = $RayCast2D
const ENEMY_A_DEATH_SCENE = preload("res://Scenes/Enemies/enemy_a_death_scene.tscn")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.4)
		velocity.y += gravity * delta
	move_and_slide()

func _process(delta: float) -> void:
	state_label.text = str(health_component.current_health)
	
	if is_inside && DimensionManager.is_inside:
		can_be_seen()
	elif is_inside && not DimensionManager.is_inside:
		invincible()
	elif not is_inside && DimensionManager.is_inside:
		invincible()
	else :
		can_be_seen()
		
func invincible():
	visible = false
	
func can_be_seen():
	visible = true
	
func _on_health_component_died() -> void:

	var death_scene = ENEMY_A_DEATH_SCENE.instantiate()
	death_scene.global_position = global_position
	get_tree().root.add_child(death_scene)
	queue_free()

func SetShader_BlinkIntensity(newValue : float):
	sprite.material.set_shader_parameter("blink_intensity", newValue)

func _on_health_component_health_changed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0,0.0,0.2)

#<<<<<<<<<<<<<<<<<<<NEW SIGNALS HERE>>>>>>>>>>>>>>>>>>>>>>>
#func _on_door_dimension_change() -> void:
	#if can_shoot == true:
		#can_shoot = false
	#else:
		#can_shoot = true
		
#func _on_door_dimension_1() -> void:
	#can_shoot = true
#
#func _on_door_dimension_2() -> void:
	#can_shoot = false
