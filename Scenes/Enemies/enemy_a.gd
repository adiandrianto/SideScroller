extends CharacterBody2D

const SPEED := 40
var direction = 1
var last_pitch = 1.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurt_box_component: HurtBoxComponent = $HurtBoxComponent
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_label: Label = $StateLabel
@onready var state_machine: Node = $StateMachine
@onready var player = get_tree().get_first_node_in_group("player")
@onready var ray_cast: RayCast2D = $RayCast2D
@onready var dead_sfx: AudioStreamPlayer2D = $DeadSFX
@onready var blood_splatter: AudioStreamPlayer2D = $BloodSplatter

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.4)
		velocity.y += gravity * delta
	move_and_slide()

func _process(delta: float) -> void:
		state_label.text = state_machine.current_state.name

func _on_health_component_died() -> void:
	deadSFX()
	bloodSFX()
	
	queue_free()

func SetShader_BlinkIntensity(newValue : float):
	sprite.material.set_shader_parameter("blink_intensity", newValue)
	
func _on_hurt_box_component_being_hit() -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0,0.0,0.5)

func deadSFX():
	randomize()
	dead_sfx.pitch_scale = randf_range(0.8, 1.2)
	
	while abs(dead_sfx.pitch_scale - last_pitch) < .1:
		randomize()
		dead_sfx.pitch_scale = randf_range(0.8, 1.2)
	
	last_pitch = dead_sfx.pitch_scale
	
	dead_sfx.play(0.0)

func bloodSFX():
	randomize()
	blood_splatter.pitch_scale = randf_range(0.8, 1.2)
	
	while abs(blood_splatter.pitch_scale - last_pitch) < .1:
		randomize()
		blood_splatter.pitch_scale = randf_range(0.8, 1.2)
	
	last_pitch = blood_splatter.pitch_scale
	
	blood_splatter.play(0.0)
