extends State

@export var enemy :CharacterBody2D
@export var wait_time:float
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var boss_sprite: Sprite2D = $"../../BossSprite"
@onready var timer: Timer = $"../../WaitTimer"
const BOSS_BOULDER = preload("res://Scenes/Bullets/boss_boulder.tscn")
var can_shoot:bool = true
@onready var alien_hurt_box: HurtBoxComponent = $"../../AlienHurtBox"

func state_enter():
	$"../../BossTalk".play_random()
	timer.start(wait_time)
	boss_sprite.frame = 0
	enemy.global_position = Vector2((enemy.summon_markers[2].global_position.x + enemy.summon_markers[0].global_position.x)/2,enemy.summon_markers[0].global_position.y)
	animation_player.play("appear")
	alien_hurt_box.monitoring = false
	alien_hurt_box.monitorable = false

func state_physics_update(delta):
	if not animation_player.is_playing():
		mid_shoot()
	
func state_exit():
	pass

func mid_shoot():
	var boulder = BOSS_BOULDER.instantiate()
	var marker: Vector2
	
	if not can_shoot:
		return
	else :
		marker = Vector2(enemy.global_position.x, enemy.global_position.y - 50)
	
		boulder.position = marker
		boulder.velocity = boulder.global_position.direction_to(player.global_position)
		boulder.look_at(player.global_position)
		get_tree().root.add_child(boulder)
	
	can_shoot = false
	await get_tree().create_timer(0.8).timeout #time between shoot
	can_shoot = true

func _on_wait_timer_timeout() -> void:
	transitioned.emit(self,"wait")

func _on_shield_health_died() -> void:
	transitioned.emit(self, "vulnerable")
