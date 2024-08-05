extends State

@onready var animation_player = $"../../AnimationPlayer"
@export var enemy :CharacterBody2D

var direction := Vector2.LEFT
var player: CharacterBody2D
const SPEED := 50

func state_enter():
	#animation_player.play("idle")
	player = get_tree().get_first_node_in_group("player")

func state_physics_update(delta):
	
	enemy.velocity = lerp(enemy.velocity, Vector2.ZERO,0.1)
	var distance = enemy.global_position - player.global_position
	#print(distance)
	if distance.length() < 320:
		transitioned.emit(self, "attack")
	enemy.move_and_slide()
	
func state_exit():
	pass
