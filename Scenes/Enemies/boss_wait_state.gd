extends State

@export var enemy :CharacterBody2D
@export var wait_time: float
@onready var timer: Timer = $"../../WaitTimer"
@onready var alien_hurt_box: HurtBoxComponent = $"../../AlienHurtBox"
@onready var shield_hurt_box: HurtBoxComponent = $"../../ShieldHurtBox"

func state_enter():
	timer.start(wait_time)
	enemy.visible = false
	alien_hurt_box.monitoring = false
	alien_hurt_box.monitorable = false
	shield_hurt_box.monitoring = false
	shield_hurt_box.monitorable = false
	
func state_physics_update(delta):
	pass
	
func state_exit():
	enemy.visible = true
	alien_hurt_box.monitoring = true
	alien_hurt_box.monitorable = true
	shield_hurt_box.monitoring = true
	shield_hurt_box.monitorable = true

func _on_wait_timer_timeout() -> void:
	var random = randf()
	if random < 0.5:
		transitioned.emit(self,"midattack")
	else:
		transitioned.emit(self,"sideattack")
