extends CharacterBody2D

const SPEED := 40
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurt_box_component: HurtBoxComponent = $HurtBoxComponent
@onready var sprite: Sprite2D = $Sprite2D
@onready var health_label: Label = $HealthLabel
@onready var state_label: Label = $StateLabel
@onready var state_machine: Node = $StateMachine
@onready var player = get_tree().get_first_node_in_group("player")
@onready var ray_cast: RayCast2D = $RayCast2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.4)
		velocity.y += gravity * delta
	move_and_slide()

func _process(delta: float) -> void:
		state_label.text = state_machine.current_state.name

func _on_health_component_died() -> void:
	queue_free()

func SetShader_BlinkIntensity(newValue : float):
	sprite.material.set_shader_parameter("blink_intensity", newValue)
	
func _on_hurt_box_component_being_hit() -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0,0.0,0.5)
