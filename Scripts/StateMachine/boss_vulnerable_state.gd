extends State

@export var enemy :CharacterBody2D
@onready var shield_hurtbox: HurtBoxComponent = $"../../ShieldHurtBox"
@onready var shield_health: HealthComponent = $"../../ShieldHealth"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var boss_sprite: Sprite2D = $"../../BossSprite"
@onready var alien_hurt_box: HurtBoxComponent = $"../../AlienHurtBox"
@export var vulnerable_time: float

func state_enter():
	animation_player.play("vulnerable")
	$"../../Growl".play(0.1)
	boss_sprite.frame = 2
	shield_hurtbox.visible = false
	shield_hurtbox.monitoring = false
	shield_hurtbox.monitorable = false
	alien_hurt_box.monitorable = true
	alien_hurt_box.monitoring = true
	
func state_physics_update(delta):
	owner.velocity.y += gravity * delta
	owner.move_and_slide()
	await get_tree().create_timer(vulnerable_time).timeout
	transitioned.emit(self, "wait")
	
func state_exit():
	shield_health.current_health = shield_health.max_health
	shield_hurtbox.visible = true
	shield_hurtbox.monitoring = true
	shield_hurtbox.monitorable = true
	alien_hurt_box.monitorable = false
	alien_hurt_box.monitoring = false


func _on_alien_health_died() -> void:
	transitioned.emit(self,"death")
