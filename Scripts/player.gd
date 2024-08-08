extends CharacterBody2D
class_name Player

@export var speed : float = 120.0
@onready var label = $Label
@onready var health_component = $HealthComponent
@onready var weapon = get_tree().get_first_node_in_group("weapon")
@onready var grenade = preload("res://Scenes/Weapons/Grenade.tscn")
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var can_shoot_pistol := true 
@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hurt_sfx: AudioStreamPlayer2D = $HurtSFX
@onready var state_machine: Node = $StateMachine

var gre
var direction : Vector2 = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") && can_shoot_pistol && weapon != null:
		weapon.shoot()
	if Input.is_action_just_pressed("Throw"):
		gre = grenade.instantiate()
		get_parent().add_child(gre)
		gre.init(direction)
		gre.global_position = global_position
		gre.throw(Vector2(1000, -700))
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
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	get_tree().reload_current_scene()

func SetShader_BlinkIntensity(newValue : float):
	animated_sprite.material.set_shader_parameter("blink_intensity", newValue)

func _on_hurt_box_component_being_hit() -> void:
	hurt_sfx.play(0.0)
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0,0.0,0.5)
