extends State

@export var enemy :CharacterBody2D
@onready var shield_hurtbox: HurtBoxComponent = $"../../ShieldHurtBox"
@onready var shield_health: HealthComponent = $"../../ShieldHealth"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func state_enter():
	shield_hurtbox.visible = false
	shield_hurtbox.monitoring = false
	shield_hurtbox.monitorable = false

func state_physics_update(delta):
	owner.velocity.y += gravity * delta
	await get_tree().create_timer(4).timeout
	#animation_player.play("vulnerable")
	transitioned.emit(self, "sideattack")
	
func state_exit():
	shield_health.current_health = shield_health.max_health
	shield_hurtbox.visible = true
	shield_hurtbox.monitoring = true
	shield_hurtbox.monitorable = true
