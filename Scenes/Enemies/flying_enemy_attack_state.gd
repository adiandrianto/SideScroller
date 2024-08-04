extends State
class_name FlyingEnemyAttack

@onready var animation_player = $"../../AnimationPlayer"
@export var enemy :CharacterBody2D
var player:CharacterBody2D

func state_enter():
	player = get_tree().get_first_node_in_group("player")
	animation_player.play("attack")
		
func to_idle():
	transitioned.emit(self, "idle")
	
func _on_hurt_box_component_being_hit():
	enemy.sprite.modulate = Color.WHITE # NOT WORKING
