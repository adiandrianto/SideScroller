extends State
class_name EnemyHurt

@onready var animation_player = $"../../AnimationPlayer"
@export var enemy :CharacterBody2D

func state_enter():
	animation_player.play("hurt")
	
func to_idle():
	transitioned.emit(self,"idle")
		
func state_exit():
	pass

func _on_hurt_box_component_being_hit():
	transitioned.emit(self,"hurt")
