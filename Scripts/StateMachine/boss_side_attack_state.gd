extends State

@export var boss :CharacterBody2D
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var marker_left: Marker2D = $"../../MarkerLeft"
@onready var marker_right: Marker2D = $"../../MarkerRight"
@onready var sprite: Sprite2D = $"../../BossSprite"
@onready var player: Player = get_tree().get_first_node_in_group("player")

const BOSS_CLONE = preload("res://Scenes/Enemies/boss_clone.tscn")
const BOSS_BOULDER = preload("res://Scenes/Bullets/boss_boulder.tscn")
var gate1
var gate2
var can_shoot:bool = true

func state_enter():
	var clone = BOSS_CLONE.instantiate()
	gate1 = pick_random_gate()
	gate2 = pick_random_gate()
	
	boss.global_position = boss.summon_markers[1].global_position
	clone.global_position = boss.summon_markers[2].global_position
	animation_player.play("appear_side")
	get_tree().root.add_child(clone)
	

func state_physics_update(_delta):
	if not animation_player.is_playing():
		shoot()
	
func state_exit():
	pass

func pick_random_gate():
	randi_range(0,3)
	
func _on_shield_health_died() -> void:
	transitioned.emit(self,"vulnerable")

func shoot():
	var boulder = BOSS_BOULDER.instantiate()
	var marker: Marker2D
	if not can_shoot:
		return
	else :
		if sprite.flip_h == true:
			#boulder.velocity = Vector2.RIGHT
			marker = marker_right
		else:
			#boulder.velocity = Vector2.LEFT
			#boulder.rotate(deg_to_rad(180))
			marker = marker_left
		
		boulder.position = marker.global_position
		boulder.velocity = boulder.global_position.direction_to(player.global_position)
		boulder.look_at(player.global_position)
		get_tree().root.add_child(boulder)
	
	can_shoot = false
	await get_tree().create_timer(2).timeout #time between shoot
	can_shoot = true
