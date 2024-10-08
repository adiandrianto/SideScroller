extends State

@export var boss :CharacterBody2D
@export var wait_time:float
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var marker_left: Marker2D = $"../../MarkerLeft"
@onready var marker_right: Marker2D = $"../../MarkerRight"
@onready var sprite: Sprite2D = $"../../BossSprite"
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var gate1: int
@onready var gate2: int
const BOSS_CLONE = preload("res://Scenes/Enemies/boss_clone.tscn")
const BOSS_BOULDER = preload("res://Scenes/Bullets/boss_boulder.tscn")
var can_shoot:bool = true
@onready var boss_sprite: Sprite2D = $"../../BossSprite"
@onready var timer: Timer = $"../../WaitTimer"
@onready var alien_hurt_box: HurtBoxComponent = $"../../AlienHurtBox"
@onready var shield: AnimatedSprite2D = $"../../ShieldHurtBox/AnimatedSprite2D"

func state_enter():
	$"../../BossTalk".play_random()
	timer.start(wait_time)
	boss_sprite.frame = 1
	var clone = BOSS_CLONE.instantiate()
	gate1 = pick_random_gate()
	gate2 = pick_random_gate()
	if gate1 == gate2:
		gate1 = pick_random_gate()
	else:
		boss.global_position = boss.summon_markers[gate1].global_position
		clone.global_position = boss.summon_markers[gate2].global_position
		animation_player.play("appear_side")
		get_tree().root.add_child.call_deferred(clone)
	alien_hurt_box.monitoring = false
	alien_hurt_box.monitorable = false

func state_physics_update(_delta):
	if not animation_player.is_playing():
		shoot()
			
func state_exit():
	pass

func pick_random_gate():
	return randi_range(0,3)
	
func _on_shield_health_died() -> void:
	transitioned.emit(self,"vulnerable")

func shoot():
	var boulder = BOSS_BOULDER.instantiate()
	var marker: Marker2D
	if not can_shoot:
		return
	else :
		if sprite.flip_h == true:
			boulder.velocity = Vector2.RIGHT
			marker = marker_right
		else:
			boulder.velocity = Vector2.LEFT
			boulder.rotate(deg_to_rad(180))
			marker = marker_left
		
		boulder.position = marker.global_position
		get_tree().root.add_child(boulder)
	
	can_shoot = false
	var t = randf_range(2.0, 3.5)
	await get_tree().create_timer(t).timeout #time between shoot
	can_shoot = true

func _on_wait_timer_timeout() -> void:
	transitioned.emit(self, "wait")

func SetShader_BlinkIntensity(newValue : float):
	shield.material.set_shader_parameter("blink_intensity", newValue)
	
func _on_shield_health_health_changed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 3.0,0.0,0.1)
