extends State

@export var boss :CharacterBody2D
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var marker_left: Marker2D = $"../../MarkerLeft"
@onready var marker_right: Marker2D = $"../../MarkerRight"
@onready var boss_sprite: Sprite2D = $"../../BossSprite"

const BOSS_BOULDER = preload("res://Scenes/Bullets/boss_boulder.tscn")
var gate

func state_enter():
	pick_random_gate()
	boss.global_position = boss.summon_markers[gate].global_position
	animation_player.play("appear_side")

func state_physics_update(delta):
	var boulder = BOSS_BOULDER.instantiate()
	var marker: Marker2D
	await get_tree().create_timer(1).timeout
	if boss_sprite.flip_h == true:
		boulder.velocity = Vector2.RIGHT
		boulder.rotation = deg_to_rad(-90)
		marker = marker_right
	elif boss_sprite.flip_h == false:
		boulder.velocity = Vector2.LEFT
		boulder.rotation = deg_to_rad(90)	
		marker = marker_left
	boulder.global_position = marker.global_position
	get_tree().root.add_child(boulder)
	
func state_exit():
	pass

func pick_random_gate():
	gate = randi_range(0,3) #later have 2 gate, boss can mirror
	
func _on_shield_health_died() -> void:
	transitioned.emit(self,"vulnerable")
