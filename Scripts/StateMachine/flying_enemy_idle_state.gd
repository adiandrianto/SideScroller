extends State
class_name FlyingEnemyIdle

@onready var animation_player = $"../../AnimationPlayer"
@export var enemy :CharacterBody2D

var direction := Vector2.LEFT
var player: CharacterBody2D
const SPEED := 50

func state_enter():
	animation_player.play("idle")
	player = get_tree().get_first_node_in_group("player")

func state_physics_update(delta):
	enemy.velocity = lerp(enemy.velocity, Vector2.ZERO,0.1)
	var distance_x = enemy.global_position.x - player.global_position.x
	#print(distance)
	if distance_x < 175:
		transitioned.emit(self, "chase")
		
func state_exit():
	pass
