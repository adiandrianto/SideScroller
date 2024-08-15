extends State
class_name FlyingEnemyChase

@onready var animation_player = $"../../AnimationPlayer"
@export var enemy :CharacterBody2D

var direction := Vector2.LEFT
var player: CharacterBody2D
const SPEED := 120

func state_enter():
	animation_player.play("idle")
	player = get_tree().get_first_node_in_group("player")
	
func state_physics_update(delta):
	var direction_to_player:Vector2 = (player.global_position - enemy.global_position).normalized()
	var distance_x = enemy.global_position.x - player.global_position.x
	enemy.velocity = Vector2(direction_to_player.x,0) * SPEED
	if distance_x < 15:
		if DimensionManager.is_inside == false :
			transitioned.emit(self, "attack")
	elif distance_x > 150:
		transitioned.emit(self, "idle")
		
func state_exit():
	pass

func _on_hurt_box_component_being_hit():
	transitioned.emit(self,"hurt")
